sealed class LocationEvent {}

class MapStarted extends LocationEvent {}

class LocationRequested extends LocationEvent {
  final int id;

  LocationRequested({required this.id});
}

class LocationLikeToggled extends LocationEvent {
  final int id;

  LocationLikeToggled({required this.id});
}

class LocationJoinToggled extends LocationEvent {
  final int id;

  LocationJoinToggled({required this.id});
}

class LocationLikeSynced extends LocationEvent {
  LocationLikeSynced({required this.liked});
  final bool liked;
}

class LocationJoinSynced extends LocationEvent {
  LocationJoinSynced({required this.joined});
  final bool joined;
}
