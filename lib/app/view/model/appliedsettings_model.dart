import 'dart:ui';
import 'package:casttime/app/model/enums/appdesign.dart';

import 'package:flutter/material.dart';

class AppliedAppSettings {
  final Locale? locale;
  final AppDesign design;

  const AppliedAppSettings({this.locale, required this.design});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppliedAppSettings &&
          other.locale == locale &&
          other.design == design;

  @override
  int get hashCode => Object.hash(locale, design);
}
