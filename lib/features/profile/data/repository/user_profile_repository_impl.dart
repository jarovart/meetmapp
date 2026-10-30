import 'package:casttime/core/failure/api_failure_mapper.dart';
import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/core/result/paged_result.dart';
import 'package:casttime/features/location/data/mapper/location_slice_dto_mapper.dart';
import 'package:casttime/features/location/domain/model/location.dart';
import 'package:casttime/features/profile/data/api/user_profile_api.dart';
import 'package:casttime/features/profile/data/dto/mapper/my_profile_dto_mapper.dart';
import 'package:casttime/features/profile/data/dto/mapper/profile_dto_mapper.dart';
import 'package:casttime/features/profile/data/dto/mapper/user_slice_dto_mapper.dart';
import 'package:casttime/features/profile/domain/model/user_profile.dart';
import 'package:casttime/features/profile/domain/repository/user_profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserProfileRepository)
class UserProfileRepositoryImpl implements UserProfileRepository {
  const UserProfileRepositoryImpl(this._api, this._failureMapper);

  static const int pageSize = 10;
  final UserProfileApi _api;
  final ApiFailureMapper _failureMapper;

  @override
  Future<AppResult<UserProfile>> fetchMyProfile() {
    return _execute(
      request: () => _api.fetchMyProfile(),
      map: (dto) => dto.toDomain(),
    );
  }

  @override
  Future<AppResult<UserProfile>> fetchProfile(String username) {
    return _execute(
      request: () => _api.fetchProfile(username),
      map: (dto) => dto.toDomain(),
    );
  }

  @override
  Future<AppResult<PagedResult<Location>>> fetchCreatedLocations(
    String username, {
    required int page,
    int pageSize = pageSize,
  }) {
    return _execute(
      request: () => _api.fetchCreatedLocations(username, page, pageSize),
      map: (dto) => dto.toDomain(),
    );
  }

  @override
  Future<AppResult<PagedResult<Location>>> fetchJoinedLocations(
    String username, {
    required int page,
    int pageSize = pageSize,
  }) {
    return _execute(
      request: () => _api.fetchJoinedLocations(username, page, pageSize),
      map: (dto) => dto.toDomain(),
    );
  }

  @override
  Future<AppResult<PagedResult<Location>>> fetchLikedLocations(
    String username, {
    required int page,
    int pageSize = pageSize,
  }) {
    return _execute(
      request: () => _api.fetchLikedLocations(username, page, pageSize),
      map: (dto) => dto.toDomain(),
    );
  }

  @override
  Future<AppResult<PagedResult<UserProfile>>> search({
    required String query,
    required int page,
    int pageSize = 10,
  }) async {
    return _execute(
      request: () => _api.searchUsers(query, page, pageSize),
      map: (dto) => dto.toDomain(),
    );
  }

  Future<AppResult<Domain>> _execute<Dto, Domain>({
    required Future<Dto> Function() request,
    required Domain Function(Dto dto) map,
  }) async {
    try {
      final dto = await request();
      return Success(map(dto));
    } catch (error, stackTrace) {
      debugPrint('profile repository error: $error');
      return Failure(_failureMapper.map(error, stackTrace));
    }
  }
}
