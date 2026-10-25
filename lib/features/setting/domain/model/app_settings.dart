import 'dart:ui';

import 'package:casttime/app/theme/appdesign.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings.freezed.dart';

@freezed
abstract class AppSettings with _$AppSettings {
  const factory AppSettings({
    Locale? locale,
    @Default(AppDesign.system) AppDesign design,
    required DateTime updatedAt,
  }) = _AppSettings;
}
