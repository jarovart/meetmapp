import 'package:casttime/app/presentation/cubit/app_busy_cubit.dart';
import 'package:casttime/app/presentation/util/load_status.dart';
import 'package:casttime/core/failure/app_failure.dart';
import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/features/image/domain/model/image_entry.dart';
import 'package:casttime/features/image/domain/service/image_compressor_service.dart';
import 'package:casttime/features/image/domain/service/image_loader_service.dart';
import 'package:casttime/features/location/domain/model/location.dart';
import 'package:casttime/features/location/domain/model/location_update.dart';
import 'package:casttime/features/location/domain/repositoryinterface/location_repository.dart';
import 'package:casttime/features/location/presentation/bloc/location_create_state.dart';
import 'package:casttime/features/location/presentation/bloc/location_edit_event.dart';
import 'package:casttime/features/location/presentation/bloc/location_edit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LocationEditBloc extends Bloc<LocationEditEvent, LocationEditState> {
  LocationEditBloc(
    this._repository,
    this._imageLoader,
    this._compressor,
    this._appBusyCubit,
    @factoryParam int locationId,
  ) : _locationId = locationId,
      super(const LocationEditState()) {
    on<LocationEditStarted>(_onStarted);
    on<LocationEditTitleChanged>(
      (e, emit) => emit(state.copyWith(title: e.value)),
    );
    on<LocationEditDescriptionChanged>(
      (e, emit) => emit(state.copyWith(description: e.description)),
    );
    on<LocationEditAddressChanged>(
      (e, emit) => emit(state.copyWith(address: e.address)),
    );
    on<LocationEditStartDateChanged>(
      (e, emit) =>
          emit(state.copyWith(startDateTime: e.dateTime, failure: null)),
    );
    on<LocationEditEndDateChanged>(
      (e, emit) => emit(state.copyWith(endDateTime: e.dateTime, failure: null)),
    );
    on<LocationEditPositionChanged>(
      (e, emit) => emit(state.copyWith(position: e.position, failure: null)),
    );
    on<LocationEditImageAdded>(_onImageAdded);
    on<LocationEditImageRemoved>(_onImageRemoved);
    on<LocationEditImagesReordered>(_onImagesReordered);
    on<LocationEditSubmitted>(_onSubmitted);
    on<LocationEditReset>(_onReset);
  }

  final LocationRepository _repository;
  final ImageLoaderService _imageLoader;
  final ImageCompressorService _compressor;
  final AppBusyCubit _appBusyCubit;
  final int _locationId;

  Future<void> _onStarted(
    LocationEditStarted event,
    Emitter<LocationEditState> emit,
  ) async {
    emit(state.copyWith(status: LoadStatus.loading, failure: null));

    final result = await _repository.fetchFullLocation(_locationId);
    if (result case Failure<Location>(:final failure)) {
      emit(state.copyWith(status: LoadStatus.failure, failure: failure));
      return;
    }

    final location = (result as Success<Location>).data;
    final images = await _imageLoader.loadExisting(location.images ?? const []);

    emit(_fromLocation(location, images).copyWith(status: LoadStatus.success));
  }

  LocationEditState _fromLocation(Location location, List<ImageEntry> images) {
    return LocationEditState(
      original: location,
      title: location.title,
      description: location.description,
      address: location.address,
      position: location.position,
      startDateTime: location.startDateTime,
      endDateTime: location.endDateTime,
      images: images,
    );
  }

  void _onReset(LocationEditReset event, Emitter<LocationEditState> emit) {
    final original = state.original;
    if (original == null) return;

    emit(
      _fromLocation(
        original,
        state.images.whereType<ExistingImage>().toList(),
      ).copyWith(status: LoadStatus.success),
    );
  }

  Future<void> _onSubmitted(
    LocationEditSubmitted event,
    Emitter<LocationEditState> emit,
  ) async {
    final validationFailure = _validate();
    if (validationFailure != null) {
      emit(state.copyWith(failure: validationFailure));
      return;
    }

    emit(state.copyWith(isSaving: true, failure: null));
    _appBusyCubit.start(this, messageKey: 'savingLocation');

    try {
      final update = LocationUpdate(
        id: _locationId,
        title: state.title.trim(),
        description: state.description.trim(),
        address: state.address.trim(),
        position: state.position!,
        startDateTime: state.startDateTime!,
        endDateTime: state.endDateTime!,
        images: state.images,
      );

      final result = await _repository.updateLocation(update);
      switch (result) {
        case Success<Location>():
          emit(state.copyWith(isSaving: false, isSaved: true));
        case Failure<Location>(:final failure):
          emit(state.copyWith(isSaving: false, failure: failure));
      }
    } finally {
      _appBusyCubit.finish(this);
    }
  }

  AppFailure? _validate() {
    if (state.title.trim().isEmpty || state.description.trim().isEmpty) {
      return const FillAllFields();
    }
    if (state.position == null) return const GeopositionMissing();
    if (state.startDateTime == null || state.endDateTime == null) {
      return const DatesMissing();
    }
    if (state.endDateTime!.isBefore(state.startDateTime!)) {
      return const EndDateBeforeStartDate();
    }
    return null;
  }

  // _onImageAdded / _onImageRemoved / _onImagesReordered
  // analog zum LocationCreateBloc
  Future<void> _onImageAdded(
    LocationEditImageAdded event,
    Emitter<LocationEditState> emit,
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
          images: [
            ...state.images,
            ImageEntry.added(bytes: compressed),
          ],
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
    LocationEditImageRemoved event,
    Emitter<LocationEditState> emit,
  ) {
    final updated = [...state.images]..removeAt(event.index);
    emit(state.copyWith(images: updated));
  }

  void _onImagesReordered(
    LocationEditImagesReordered event,
    Emitter<LocationEditState> emit,
  ) {
    var newIndex = event.newIndex;
    if (newIndex > event.oldIndex) newIndex--;

    final updated = [...state.images];
    final moved = updated.removeAt(event.oldIndex);
    updated.insert(newIndex, moved);

    emit(state.copyWith(images: updated));
  }
}
