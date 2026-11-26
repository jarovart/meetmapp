sealed class MyLocationsEvent {}

class MyLocationsRequested extends MyLocationsEvent {}

class MyLocationsLoadMoreRequested extends MyLocationsEvent {}

class MyLocationLikeToggled extends MyLocationsEvent {
  MyLocationLikeToggled(this.locationId);
  final int locationId;
}

class MyLocationJoinToggled extends MyLocationsEvent {
  MyLocationJoinToggled(this.locationId);
  final int locationId;
}

class MyLocationLikeSynced extends MyLocationsEvent {
  MyLocationLikeSynced(this.locationId, this.liked);
  final int locationId;
  final bool liked;
}

class MyLocationJoinSynced extends MyLocationsEvent {
  MyLocationJoinSynced(this.locationId, this.joined);
  final int locationId;
  final bool joined;
}
