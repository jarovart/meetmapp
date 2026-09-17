import 'package:casttime/core/failure/app_failure.dart';
import 'package:casttime/features/location/domain/model/place.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'place_suggestion_state.freezed.dart';

@freezed
abstract class PlaceSuggestionState with _$PlaceSuggestionState {
  const factory PlaceSuggestionState({
    @Default([]) List<Place> suggestions,
    @Default(false) bool isLoading,
    AppFailure? failure,
  }) = _PlaceSuggestionState;
}
