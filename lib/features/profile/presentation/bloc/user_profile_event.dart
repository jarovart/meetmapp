sealed class UserProfileEvent {}

class UserProfileRequested extends UserProfileEvent {
  final String? username;
  UserProfileRequested(this.username);
}
