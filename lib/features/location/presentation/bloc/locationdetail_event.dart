import 'package:casttime/features/location/domain/model/location.dart';

sealed class LocationDetailEvent {}

class MapStarted extends LocationDetailEvent {}

class LocationDetailRequested extends LocationDetailEvent {
  final Location location;

  LocationDetailRequested({required this.location});
}

class LocationLikeToggled extends LocationDetailEvent {
  final int id;

  LocationLikeToggled({required this.id});
}

class LocationJoinToggled extends LocationDetailEvent {
  final int id;

  LocationJoinToggled({required this.id});
}

class LocationLikeSynced extends LocationDetailEvent {}
