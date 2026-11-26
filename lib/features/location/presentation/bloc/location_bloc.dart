import 'dart:async';

import 'package:casttime/app/presentation/util/load_status.dart';
import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/features/location/domain/model/location.dart';
import 'package:casttime/features/location/domain/serviceinterface/location_service.dart';
import 'package:casttime/features/location/presentation/bloc/location_event.dart';
import 'package:casttime/features/location/presentation/bloc/location_state.dart';
import 'package:casttime/features/map/presentation/util/debouncer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc(this._locationService, @factoryParam Location initialLocation)
    : super(LocationState.initial(initialLocation)) {
    on<LocationRequested>(_onRequested);
    on<LocationLikeToggled>(_onLikeToggled);
    on<LocationLikeSynced>(_onLikeSynced);
    on<LocationJoinToggled>(_onJoinToggled);
    on<LocationJoinSynced>(_onJoinSynced);
  }

  final LocationService _locationService;
  final Debouncer _likeDebouncer = Debouncer(
    delay: const Duration(milliseconds: 500),
  );

  final Debouncer _joinDebouncer = Debouncer(
    delay: const Duration(milliseconds: 500),
  );

  Future<void> _onRequested(
    LocationRequested event,
    Emitter<LocationState> emit,
  ) async {
    emit(state.copyWith(status: LoadStatus.loading, clearFailure: true));

    final result = await _locationService.fetchFullLocation(event.id);
    switch (result) {
      case Success<Location>(:final data):
        emit(
          state.copyWith(
            status: LoadStatus.success,
            location: data,
            clearFailure: true,
          ),
        );
      case Failure<Location>(:final failure):
        emit(state.copyWith(status: LoadStatus.failure, failure: failure));
    }
  }

  FutureOr<void> _onLikeToggled(LocationLikeToggled event, Emitter emit) {
    final location = state.location;
    if (location == null) return null;

    final nowLiked = !(location.likedByCurrentUser ?? false);
    final delta = nowLiked ? 1 : -1;

    emit(
      state.copyWith(
        location: location.copyWith(
          likedByCurrentUser: nowLiked,
          likedUserCount: location.likedUserCount + delta,
        ),
      ),
    );

    _likeDebouncer.run(() {
      if (!isClosed) add(LocationLikeSynced(liked: nowLiked));
    });
  }

  FutureOr<void> _onJoinToggled(LocationJoinToggled event, Emitter emit) {
    final location = state.location;
    if (location == null) {
      debugPrint("joined ${event.id}");
      return null;
    }

    final nowJoined = !(location.joinedByCurrentUser ?? false);
    final delta = nowJoined ? 1 : -1;

    emit(
      state.copyWith(
        location: location.copyWith(
          joinedByCurrentUser: nowJoined,
          joinedUserCount: location.joinedUserCount + delta,
        ),
      ),
    );

    _joinDebouncer.run(() {
      if (!isClosed) add(LocationJoinSynced(joined: nowJoined));
    });
  }

  Future<void> _onLikeSynced(
    LocationLikeSynced event,
    Emitter<LocationState> emit,
  ) async {
    final location = state.location;
    if (location == null) return;

    final isLiked = location.likedByCurrentUser ?? false;

    final result = isLiked
        ? await _locationService.like(location.id)
        : await _locationService.unlike(location.id);

    if (result case Failure(:final failure)) {
      emit(
        state.copyWith(
          location: location.copyWith(
            likedByCurrentUser: !isLiked,
            likedUserCount: location.likedUserCount + (!isLiked ? 1 : -1),
          ),
          failure: failure,
        ),
      );
    }
  }

  Future<void> _onJoinSynced(
    LocationJoinSynced event,
    Emitter<LocationState> emit,
  ) async {
    final location = state.location;
    if (location == null) return;

    final isJoined = location.joinedByCurrentUser ?? false;

    final result = isJoined
        ? await _locationService.join(location.id)
        : await _locationService.unjoin(location.id);

    if (result case Failure(:final failure)) {
      emit(
        state.copyWith(
          location: location.copyWith(
            likedByCurrentUser: !isJoined,
            likedUserCount: location.joinedUserCount + (!isJoined ? 1 : -1),
          ),
          failure: failure,
        ),
      );
    }
  }
}
