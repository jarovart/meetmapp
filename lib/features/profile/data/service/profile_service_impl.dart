import 'package:casttime/core/failure/geolocation_failure_mapper.dart';
import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/core/result/paged_result.dart';
import 'package:casttime/features/location/domain/model/location.dart';
import 'package:casttime/features/profile/domain/model/user_profile.dart';
import 'package:casttime/features/profile/domain/repository/profile_repository.dart';
import 'package:casttime/features/profile/domain/service/profile_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProfileService)
class ProfileServiceImpl implements ProfileService {
  final ProfileRepository repository;
  final LocationFailureMapper failureMapper;

  ProfileServiceImpl(this.repository, this.failureMapper);

  @override
  Future<AppResult<UserProfile>> fetchProfile(String? username) async {
    if (username != null) {
      return await repository.fetchProfile(username);
    }
    return await repository.fetchMyProfile();
  }

  @override
  Future<AppResult<PagedResult<Location>>> fetchCreatedLocations(
    String username, {
    required int page,
  }) async {
    return await repository.fetchCreatedLocations(username, page: page);
  }

  @override
  Future<AppResult<PagedResult<Location>>> fetchJoinedLocations(
    String username, {
    required int page,
  }) async {
    return await repository.fetchJoinedLocations(username, page: page);
  }

  @override
  Future<AppResult<PagedResult<Location>>> fetchLikedLocations(
    String username, {
    required int page,
  }) async {
    return await repository.fetchLikedLocations(username, page: page);
  }
}
