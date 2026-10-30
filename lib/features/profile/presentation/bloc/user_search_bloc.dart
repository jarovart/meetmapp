import 'package:casttime/app/presentation/util/load_status.dart';
import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/core/result/paged_result.dart';
import 'package:casttime/features/map/presentation/util/debouncer.dart';
import 'package:casttime/features/profile/domain/model/user_profile.dart';
import 'package:casttime/features/profile/domain/repository/user_profile_repository.dart';
import 'package:casttime/features/profile/presentation/bloc/user_search_event.dart';
import 'package:casttime/features/profile/presentation/bloc/user_search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserSearchBloc extends Bloc<UserSearchEvent, UserSearchState> {
  UserSearchBloc(this._repository) : super(const UserSearchState()) {
    on<UserSearchQueryChanged>(_onQueryChanged);
    on<UserSearchSubmitted>(_onSubmitted);
    on<UserSearchLoadMoreRequested>(_onLoadMoreRequested);
    on<UserSearchCleared>(_onCleared);
  }

  final UserProfileRepository _repository;
  final Debouncer _debouncer = Debouncer(
    delay: const Duration(milliseconds: 700),
  );

  void _onQueryChanged(
    UserSearchQueryChanged event,
    Emitter<UserSearchState> emit,
  ) {
    emit(state.copyWith(query: event.query));

    if (state.queryTooShort) {
      _debouncer.cancel();
      emit(
        state.copyWith(users: [], status: LoadStatus.initial, failure: null),
      );
      return;
    }
    _debouncer.run(() => add(UserSearchSubmitted()));
  }

  Future<void> _onSubmitted(
    UserSearchSubmitted event,
    Emitter<UserSearchState> emit,
  ) async {
    if (state.queryTooShort) return;

    emit(state.copyWith(status: LoadStatus.loading, failure: null));

    final result = await _repository.search(query: state.query.trim(), page: 0);
    switch (result) {
      case Success<PagedResult<UserProfile>>(:final data):
        emit(
          state.copyWith(
            status: LoadStatus.success,
            users: data.items,
            page: 0,
            hasMore: data.hasMore,
          ),
        );
      case Failure<PagedResult<UserProfile>>(:final failure):
        emit(
          state.copyWith(
            status: LoadStatus.failure,
            failure: failure,
            users: [],
          ),
        );
    }
  }

  Future<void> _onLoadMoreRequested(
    UserSearchLoadMoreRequested event,
    Emitter<UserSearchState> emit,
  ) async {
    if (state.isLoadingMore || !state.hasMore || state.queryTooShort) return;

    emit(state.copyWith(isLoadingMore: true));
    final nextPage = state.page + 1;

    final result = await _repository.search(
      query: state.query.trim(),
      page: nextPage,
    );
    switch (result) {
      case Success<PagedResult<UserProfile>>(:final data):
        emit(
          state.copyWith(
            users: [...state.users, ...data.items],
            page: nextPage,
            hasMore: data.hasMore,
            isLoadingMore: false,
          ),
        );
      case Failure<PagedResult<UserProfile>>(:final failure):
        emit(state.copyWith(isLoadingMore: false, failure: failure));
    }
  }

  void _onCleared(UserSearchCleared event, Emitter<UserSearchState> emit) {
    _debouncer.cancel();
    emit(const UserSearchState());
  }

  @override
  Future<void> close() {
    _debouncer.cancel();
    return super.close();
  }
}
