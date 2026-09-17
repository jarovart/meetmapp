import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/core/result/paged_result.dart';
import 'package:casttime/features/location/domain/model/location.dart';
import 'package:casttime/features/profile/domain/model/user_profile.dart';

abstract interface class ProfileRepository {
  Future<AppResult<UserProfile>> fetchProfile(String username);
  Future<AppResult<UserProfile>> fetchMyProfile();
  Future<AppResult<PagedResult<Location>>> fetchCreatedLocations(
    String username, {
    required int page,
  });
  Future<AppResult<PagedResult<Location>>> fetchJoinedLocations(
    String username, {
    required int page,
  });
  Future<AppResult<PagedResult<Location>>> fetchLikedLocations(
    String username, {
    required int page,
  });
}
