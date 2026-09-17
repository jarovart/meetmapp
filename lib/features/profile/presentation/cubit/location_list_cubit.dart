// features/profile/presentation/cubit/location_list_cubit.dart
import 'package:casttime/app/presentation/util/load_status.dart';
import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/core/result/paged_result.dart';
import 'package:casttime/features/location/domain/model/location.dart';
import 'package:casttime/features/profile/domain/model/location_list_type.dart';
import 'package:casttime/features/profile/domain/service/profile_service.dart';
import 'package:casttime/features/profile/presentation/cubit/location_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LocationListCubit extends Cubit<LocationListState> {
  LocationListCubit(
    this._profileService,
    @factoryParam this.username,
    @factoryParam this.listType,
  ) : super(const LocationListState());

  final ProfileService _profileService;
  final String username;
  final LocationListType listType;

  Future<void> load() async {
    emit(state.copyWith(status: LoadStatus.loading));
    final result = await _fetch(page: 0);

    switch (result) {
      case Success<PagedResult<Location>>(:final data):
        emit(
          state.copyWith(
            status: LoadStatus.success,
            locations: data.items,
            page: 0,
            hasMore: data.hasMore,
          ),
        );
      case Failure<PagedResult<Location>>(:final failure):
        emit(state.copyWith(status: LoadStatus.failure, failure: failure));
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) return;

    emit(state.copyWith(isLoadingMore: true));
    final nextPage = state.page + 1;
    final result = await _fetch(page: nextPage);

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

  Future<AppResult<PagedResult<Location>>> _fetch({required int page}) {
    return switch (listType) {
      LocationListType.created => _profileService.fetchCreatedLocations(
        username,
        page: page,
      ),
      LocationListType.joined => _profileService.fetchJoinedLocations(
        username,
        page: page,
      ),
      LocationListType.liked => _profileService.fetchLikedLocations(
        username,
        page: page,
      ),
    };
  }
}
