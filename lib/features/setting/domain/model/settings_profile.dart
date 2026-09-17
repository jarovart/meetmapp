import 'dart:ui';

import 'package:casttime/app/theme/appdesign.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_profile.freezed.dart';

@freezed
abstract class SettingsProfile with _$SettingsProfile {
  const factory SettingsProfile({
    required int id,
    required Locale? locale,
    required AppDesign design,
    required DateTime updatedAt,
  }) = _SettingsProfile;
}
