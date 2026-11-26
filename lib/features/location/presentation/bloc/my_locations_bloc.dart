import 'package:casttime/app/presentation/util/load_status.dart';
import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/core/result/paged_result.dart';
import 'package:casttime/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:casttime/features/location/domain/model/location.dart';
import 'package:casttime/features/location/domain/repositoryinterface/location_repository.dart';
import 'package:casttime/features/location/presentation/bloc/my_locations_event.dart';
import 'package:casttime/features/location/presentation/bloc/my_locations_state.dart';
import 'package:casttime/features/map/presentation/util/debouncer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class MyLocationsBloc extends Bloc<MyLocationsEvent, MyLocationsState> {
  MyLocationsBloc(this._repository, this._authCubit)
    : super(const MyLocationsState()) {
    on<MyLocationsRequested>(_onRequested);
    on<MyLocationsLoadMoreRequested>(_onLoadMoreRequested);
    on<MyLocationLikeToggled>(_onLikeToggled);
    on<MyLocationJoinToggled>(_onJoinToggled);
    on<MyLocationLikeSynced>(_onLikeSynced);
    on<MyLocationJoinSynced>(_onJoinSynced);
  }

  final LocationRepository _repository;
  final AuthCubit _authCubit;

  final _likeDebouncer = Debouncer(delay: const Duration(milliseconds: 500));
  final _joinDebouncer = Debouncer(delay: const Duration(milliseconds: 500));

  String? get _username => _authCubit.state.username;

  Future<void> _onRequested(
    MyLocationsRequested event,
    Emitter<MyLocationsState> emit,
  ) async {
    final username = _username;
    if (username == null) return;

    emit(state.copyWith(status: LoadStatus.loading, failure: null));

    final result = await _repository.fetchJoinedLocations(
      username: username,
      page: 0,
    );

    switch (result) {
      case Success<PagedResult<Location>>(:final data):
        emit(
          state.copyWith(
            status: LoadStatus.success,
            locations: data.items,
            page: 0,
            hasMore: data.hasMore,
            isLoadingMore: false,
            pendingRemovalIds: const {},
          ),
        );
      case Failure<PagedResult<Location>>(:final failure):
        emit(state.copyWith(status: LoadStatus.failure, failure: failure));
    }
  }

  Future<void> _onLoadMoreRequested(
    MyLocationsLoadMoreRequested event,
    Emitter<MyLocationsState> emit,
  ) async {
    if (state.isLoadingMore) return;

    // Verlassene Einträge wegräumen statt nachzuladen.
    if (state.isDirty) {
      add(MyLocationsRequested());
      return;
    }

    if (!state.hasMore) return;

    final username = _username;
    if (username == null) return;

    emit(state.copyWith(isLoadingMore: true));
    final nextPage = state.page + 1;

    final result = await _repository.fetchJoinedLocations(
      username: username,
      page: nextPage,
    );

    switch (result) {
      case Success<PagedResult<Location>>(:final data):
        emit(
          state.copyWith(
            locations: [...state.locations, ...data.items],
            page: nextPage,
            hasMore: data.hasMore,
            isLoadingMore: false,
          ),
        );
      case Failure<PagedResult<Location>>(:final failure):
        emit(state.copyWith(isLoadingMore: false, failure: failure));
    }
  }

  void _onLikeToggled(
    MyLocationLikeToggled event,
    Emitter<MyLocationsState> emit,
  ) {
    final current = _find(event.locationId);
    if (current == null) return;

    final next = !(current.likedByCurrentUser ?? false);
    emit(
      _replace(
        current.copyWith(
          likedByCurrentUser: next,
          likedUserCount: current.likedUserCount + (next ? 1 : -1),
        ),
      ),
    );

    _likeDebouncer.run(() {
      if (!isClosed) add(MyLocationLikeSynced(event.locationId, next));
    });
  }

  Future<void> _onLikeSynced(
    MyLocationLikeSynced event,
    Emitter<MyLocationsState> emit,
  ) async {
    final result = event.liked
        ? await _repository.like(event.locationId)
        : await _repository.unlike(event.locationId);

    if (result case Failure<void>(:final failure)) {
      final current = _find(event.locationId);
      if (current == null) return;

      emit(
        _replace(
          current.copyWith(
            likedByCurrentUser: !event.liked,
            likedUserCount: current.likedUserCount + (event.liked ? -1 : 1),
          ),
        ).copyWith(failure: failure),
      );
    }
  }

  void _onJoinToggled(
    MyLocationJoinToggled event,
    Emitter<MyLocationsState> emit,
  ) {
    final current = _find(event.locationId);
    if (current == null) return;

    final next = !(current.joinedByCurrentUser ?? false);
    final pending = {...state.pendingRemovalIds};
    next ? pending.remove(event.locationId) : pending.add(event.locationId);

    emit(
      _replace(
        current.copyWith(
          joinedByCurrentUser: next,
          joinedUserCount: current.joinedUserCount + (next ? 1 : -1),
        ),
      ).copyWith(pendingRemovalIds: pending),
    );

    _joinDebouncer.run(() {
      if (!isClosed) add(MyLocationJoinSynced(event.locationId, next));
    });
  }

  Future<void> _onJoinSynced(
    MyLocationJoinSynced event,
    Emitter<MyLocationsState> emit,
  ) async {
    final result = event.joined
        ? await _repository.join(event.locationId)
        : await _repository.unjoin(event.locationId);

    if (result case Failure<void>(:final failure)) {
      final current = _find(event.locationId);
      if (current == null) return;

      final pending = {...state.pendingRemovalIds}..remove(event.locationId);

      emit(
        _replace(
          current.copyWith(
            joinedByCurrentUser: !event.joined,
            joinedUserCount: current.joinedUserCount + (event.joined ? -1 : 1),
          ),
        ).copyWith(pendingRemovalIds: pending, failure: failure),
      );
    }
  }

  Location? _find(int id) =>
      state.locations.where((l) => l.id == id).firstOrNull;

  MyLocationsState _replace(Location updated) {
    return state.copyWith(
      locations: [
        for (final location in state.locations)
          location.id == updated.id ? updated : location,
      ],
    );
  }

  @override
  Future<void> close() {
    _likeDebouncer.cancel();
    _joinDebouncer.cancel();
    return super.close();
  }
}
