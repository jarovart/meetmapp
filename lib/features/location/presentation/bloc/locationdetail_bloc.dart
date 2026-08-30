import 'dart:async';

import 'package:casttime/app/presentation/util/load_status.dart';
import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/features/location/domain/model/location.dart';
import 'package:casttime/features/location/domain/model/location_detail.dart';
import 'package:casttime/features/location/domain/serviceinterface/location_service.dart';
import 'package:casttime/features/location/presentation/bloc/locationdetail_event.dart';
import 'package:casttime/features/location/presentation/bloc/locationdetail_state.dart';
import 'package:casttime/features/map/presentation/util/debouncer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LocationDetailBloc
    extends Bloc<LocationDetailEvent, LocationDetailState> {
  LocationDetailBloc(this._locationService, Location initialLocation)
    : super(LocationDetailState.initial(initialLocation)) {
    on<LocationDetailRequested>(_onRequested);
    on<LocationLikeToggled>(_onLikeToggled);
    on<LocationLikeSynced>(_onLikeSynced);
    on<LocationJoinToggled>(_onJoinToggled);
  }

  final LocationService _locationService;
  final Debouncer _likeDebouncer = Debouncer(
    delay: const Duration(milliseconds: 500),
  );

  Future<void> _onRequested(
    LocationDetailRequested event,
    Emitter<LocationDetailState> emit,
  ) async {
    emit(state.copyWith(status: LoadStatus.loading, location: event.location));

    final result = await _locationService.fetchLocationDetail(
      event.location.id,
    );
    switch (result) {
      case Success<LocationDetail>(:final data):
        emit(
          state.copyWith(
            status: LoadStatus.success,
            locationDetail: data,
            clearFailure: true,
          ),
        );
      case Failure<LocationDetail>(:final failure):
        emit(state.copyWith(status: LoadStatus.failure, failure: failure));
    }
  }

  FutureOr<void> _onLikeToggled(LocationLikeToggled event, Emitter emit) {
    final detail = state.locationDetail;
    if (detail == null) return null;

    final nowLiked = !(detail.location.likedByCurrentUser ?? false);
    final delta = nowLiked ? 1 : -1;

    emit(
      state.copyWith(
        locationDetail: detail.copyWith(
          location: detail.location.copyWith(
            likedByCurrentUser: nowLiked,
            likedUserCount: detail.location.likedUserCount + delta,
          ),
        ),
      ),
    );

    _likeDebouncer.run(() => add(LocationLikeSynced()));
  }

  FutureOr<void> _onJoinToggled(LocationJoinToggled event, Emitter emit) {}

  Future<void> _onLikeSynced(
    LocationLikeSynced event,
    Emitter<LocationDetailState> emit,
  ) async {
    final detail = state.locationDetail;
    if (detail == null) return;

    final isLiked = detail.location.likedByCurrentUser ?? false;

    final result = isLiked
        ? await _locationService.like(detail.location.id)
        : await _locationService.unlike(detail.location.id);

    if (result case Failure(:final failure)) {
      // Revert: einfach nochmal togglen + Fehler zeigen
      emit(
        state.copyWith(
          locationDetail: detail.copyWith(
            location: detail.location.copyWith(
              likedByCurrentUser: !isLiked,
              likedUserCount:
                  detail.location.likedUserCount + (!isLiked ? 1 : -1),
            ),
          ),
          failure: failure,
        ),
      );
    }
  }
}
