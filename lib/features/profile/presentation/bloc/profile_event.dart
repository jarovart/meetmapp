sealed class ProfileEvent {}

class ProfileRequested extends ProfileEvent {
  final String? username;
  ProfileRequested(this.username);
}
