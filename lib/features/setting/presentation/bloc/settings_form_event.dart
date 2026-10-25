import 'package:casttime/app/theme/appdesign.dart';

sealed class SettingsFormEvent {}

class SettingsFormStarted extends SettingsFormEvent {}

class SettingsDesignChanged extends SettingsFormEvent {
  SettingsDesignChanged(this.design);
  final AppDesign design;
}

class SettingsLanguageChanged extends SettingsFormEvent {
  SettingsLanguageChanged(this.languageCode);
  final String? languageCode;
}

class SettingsSubmitted extends SettingsFormEvent {}
