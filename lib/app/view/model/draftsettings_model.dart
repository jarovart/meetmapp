import 'package:flutter/material.dart';
import 'package:meetmaap/app/model/enums/appdesign.dart';

class DraftAppSettings {
  final Locale? locale;
  final AppDesign design;

  const DraftAppSettings({this.locale, required this.design});

  DraftAppSettings copyWith({Locale? locale, AppDesign? design}) {
    return DraftAppSettings(
      locale: locale ?? this.locale,
      design: design ?? this.design,
    );
  }
}
