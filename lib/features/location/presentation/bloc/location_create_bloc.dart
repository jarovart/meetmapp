import 'package:casttime/app/presentation/cubit/app_busy_cubit.dart';
import 'package:casttime/core/failure/app_failure.dart';
import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:casttime/features/image/domain/service/image_compressor_service.dart';
import 'package:casttime/features/location/domain/model/app_image.dart';
import 'package:casttime/features/location/domain/model/location.dart';
import 'package:casttime/features/location/domain/model/location_draft.dart';
import 'package:casttime/features/location/domain/repositoryinterface/location_repository.dart';
import 'package:casttime/features/location/domain/serviceinterface/location_service.dart';
import 'package:casttime/features/location/presentation/bloc/location_create_event.dart';
import 'package:casttime/features/location/presentation/bloc/location_create_state.dart';
import 'package:casttime/features/map/presentation/util/debouncer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

@injectable
class LocationCreateBloc
    extends Bloc<LocationCreateEvent, LocationCreateState> {
  LocationCreateBloc(
    this._repository,
    this._compressor,
    this._authCubit,
    this._appBusyCubit,
    this._locationService,
    @factoryParam LatLng? position,
    @factoryParam String? initialAddress,
  ) : super(
        LocationCreateState(initialPosition: position, position: position),
      ) {
    on<LocationCreateStarted>(_onLocationCreateStarted);
    on<LocationImageAdded>(_onImageAdded);
    on<LocationImageRemoved>(_onImageRemoved);
    on<LocationImagesReordered>(_onImagesReordered);
    on<LocationPositionChanged>(_onPositionChanged);
    on<LocationStartDateChanged>(_onStartDateChanged);
    on<LocationEndDateChanged>(_onEndDateChanged);
    on<LocationCreateSubmitted>(_onSubmitted);
    on<LocationCreateReset>(_onReset);
    on<LocationGeocodeRequested>(_onGeocodeRequested);
  }

  final LocationRepository _repository;
  final ImageCompressorService _compressor;
  final AuthCubit _authCubit;
  final LocationService _locationService;
  final AppBusyCubit _appBusyCubit;
  final Debouncer _geocodeDebouncer = Debouncer(
    delay: const Duration(seconds: 1),
  );

  @override
  Future<void> close() {
    _geocodeDebouncer.cancel();
    return super.close();
  }

  Future<void> _onLocationCreateStarted(
    LocationCreateStarted event,
    Emitter<LocationCreateState> emit,
  ) async {
    final position = state.initialPosition;
    if (position == null) return;

    _appBusyCubit.start(this, messageKey: CreateStep.updatePosition.messageKey);

    try {
      final result = await _locationService.reverseGeocodeOSM(position);

      if (result case Success<String?>(:final data) when data != null) {
        emit(state.copyWith(initialAddress: data, address: data));
      }
    } finally {
      _appBusyCubit.finish(this);
    }
  }

  void _onReset(LocationCreateReset event, Emitter<LocationCreateState> emit) {
    emit(
      LocationCreateState(
        initialPosition: state.initialPosition,
        position: state.initialPosition,
        initialAddress: state.initialAddress,
      ),
    );
  }

  Future<void> _onImageAdded(
    LocationImageAdded event,
    Emitter<LocationCreateState> emit,
  ) async {
    emit(state.copyWith(isProcessingImage: true, failure: null));
    _appBusyCubit.start(
      this,
      messageKey: CreateStep.uploadingImages.messageKey,
    );

    try {
      final compressed = await _compressor.compress(event.bytes);
      emit(
        state.copyWith(
          images: [...state.images, compressed],
          isProcessingImage: false,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          isProcessingImage: false,
          failure: const ImageProcessingFailed(),
        ),
      );
    } finally {
      _appBusyCubit.finish(this);
    }
  }

  void _onImageRemoved(
    LocationImageRemoved event,
    Emitter<LocationCreateState> emit,
  ) {
    final updated = [...state.images]..removeAt(event.index);
    emit(state.copyWith(images: updated));
  }

  void _onImagesReordered(
    LocationImagesReordered event,
    Emitter<LocationCreateState> emit,
  ) {
    var newIndex = event.newIndex;
    if (newIndex > event.oldIndex) newIndex--;

    final updated = [...state.images];
    final moved = updated.removeAt(event.oldIndex);
    updated.insert(newIndex, moved);

    emit(state.copyWith(images: updated));
  }

  void _onStartDateChanged(
    LocationStartDateChanged event,
    Emitter<LocationCreateState> emit,
  ) {
    emit(state.copyWith(startDateTime: event.dateTime, failure: null));
  }

  void _onEndDateChanged(
    LocationEndDateChanged event,
    Emitter<LocationCreateState> emit,
  ) {
    emit(state.copyWith(endDateTime: event.dateTime, failure: null));
  }

  void _onPositionChanged(
    LocationPositionChanged event,
    Emitter<LocationCreateState> emit,
  ) {
    emit(state.copyWith(position: event.position, failure: null));
    _geocodeDebouncer.run(() => add(LocationGeocodeRequested(event.position)));
  }

  Future<void> _onSubmitted(
    LocationCreateSubmitted event,
    Emitter<LocationCreateState> emit,
  ) async {
    final validationFailure = _validate();
    if (validationFailure != null) {
      emit(state.copyWith(failure: validationFailure));
      return;
    }

    debugPrint('submit position=${state.position}');
    try {
      _setStep(emit, CreateStep.savingLocation, null);

      final draft = LocationDraft(
        title: event.title.trim(),
        description: event.description.trim(),
        address: event.address.trim(),
        startDateTime: state.startDateTime!,
        endDateTime: state.endDateTime!,
        position: state.position!,
        createdUsername: _authCubit.state.username!,
      );

      final createResult = await _repository.createLocation(draft);
      if (createResult case Failure<Location>(:final failure)) {
        emit(state.copyWith(step: CreateStep.idle, failure: failure));
        return;
      }

      var location = (createResult as Success<Location>).data;

      if (state.images.isNotEmpty) {
        _setStep(emit, CreateStep.uploadingImages, null);

        final uploadResult = await _repository.uploadImages(
          state.images,
          location.id,
        );
        if (uploadResult case Success<List<AppImage>>(:final data)) {
          _setStep(emit, CreateStep.settingThumbnail, null);

          final thumbnailResult = await _repository.setThumbnail(
            location.id,
            data.first.id,
          );
          if (thumbnailResult case Success<Location>(:final data)) {
            location = data;
          }
        }
      }

      emit(state.copyWith(step: CreateStep.done, createdLocation: location));
    } finally {
      debugPrint('>>> emitted done');
      _appBusyCubit.finish(this);
    }
  }

  Future<void> _onGeocodeRequested(
    LocationGeocodeRequested event,
    Emitter<LocationCreateState> emit,
  ) async {
    _appBusyCubit.start(this, messageKey: CreateStep.updatePosition.messageKey);

    try {
      final result = await _locationService.reverseGeocodeOSM(event.position);

      switch (result) {
        case Success<String?>(:final data):
          if (data != null && data.isNotEmpty) {
            emit(state.copyWith(address: data));
          }
        case Failure<String?>(:final failure):
          debugPrint('reverse geocode failed: $failure');
      }
    } finally {
      _appBusyCubit.finish(this);
    }
  }

  AppFailure? _validate() {
    if (state.position == null) {
      return const GeopositionMissing();
    }

    if (state.startDateTime == null || state.endDateTime == null) {
      return const DatesMissing();
    }
    if (state.endDateTime!.isBefore(state.startDateTime!)) {
      return const EndDateBeforeStartDate();
    }
    return null;
  }

  void _setStep(
    Emitter<LocationCreateState> emit,
    CreateStep step,
    AppFailure? failure,
  ) {
    emit(state.copyWith(step: step, failure: failure));
    _appBusyCubit.start(this, messageKey: step.messageKey);
  }
}
