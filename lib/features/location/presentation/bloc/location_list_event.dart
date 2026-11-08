import 'package:casttime/features/location/domain/model/location_filter.dart';

sealed class LocationSearchEvent {}

class LocationSearchStarted extends LocationSearchEvent {}

class LocationSearchQueryChanged extends LocationSearchEvent {
  LocationSearchQueryChanged(this.query);
  final String query;
}

class LocationSearchSubmitted extends LocationSearchEvent {}

class LocationSearchLoadMoreRequested extends LocationSearchEvent {}

class LocationSearchFilterApplied extends LocationSearchEvent {
  LocationSearchFilterApplied(this.filter);
  final LocationFilter filter;
}

class LocationSearchCleared extends LocationSearchEvent {}
