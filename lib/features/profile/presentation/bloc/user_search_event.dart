sealed class UserSearchEvent {}

class UserSearchQueryChanged extends UserSearchEvent {
  UserSearchQueryChanged(this.query);
  final String query;
}

class UserSearchSubmitted extends UserSearchEvent {}

class UserSearchLoadMoreRequested extends UserSearchEvent {}

class UserSearchCleared extends UserSearchEvent {}
