import 'dart:typed_data';

sealed class ProfileEditEvent {}

class ProfileEditStarted extends ProfileEditEvent {}

class ProfileEditFirstNameChanged extends ProfileEditEvent {
  ProfileEditFirstNameChanged(this.value);
  final String value;
}

class ProfileEditLastNameChanged extends ProfileEditEvent {
  ProfileEditLastNameChanged(this.value);
  final String value;
}

class ProfileEditAboutMeChanged extends ProfileEditEvent {
  ProfileEditAboutMeChanged(this.value);
  final String value;
}

class ProfileEditImageSelected extends ProfileEditEvent {
  ProfileEditImageSelected(this.bytes);
  final Uint8List bytes;
}

class ProfileEditImageRemoved extends ProfileEditEvent {}

class ProfileEditSubmitted extends ProfileEditEvent {}

class ProfileEditReset extends ProfileEditEvent {}
