import 'package:casttime/features/location/domain/model/app_image.dart';
import 'package:casttime/features/setting/domain/model/settings_profile.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';

@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    required int id,
    required String username,
    required String firstName,
    required String lastName,
    String? aboutMe,
    String? email, // nur bei eigenem Profil vom Backend geliefert
    DateTime? createdAt, // nur bei eigenem Profil
    AppImage? profileImage,
    required int joinedLocationCount,
    required int likedLocationCount,
    int? createdLocationCount, // nur bei eigenem Profil sichtbar
    SettingsProfile? settings,
  }) = _UserProfile;
}
