import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/features/location/domain/model/place.dart';
import 'package:casttime/features/location/domain/serviceinterface/place_service.dart';
import 'package:casttime/features/location/presentation/bloc/place_suggestion_state.dart';
import 'package:casttime/features/map/presentation/util/debouncer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class PlaceSuggestionCubit extends Cubit<PlaceSuggestionState> {
  PlaceSuggestionCubit(this._placeService)
    : super(const PlaceSuggestionState());

  final PlaceService _placeService;
  final Debouncer _debouncer = Debouncer(
    delay: const Duration(milliseconds: 400),
  );

  void onQueryChanged(String query) {
    final trimmed = query.trim();
    if (trimmed.length < 3) {
      _debouncer.cancel();
      emit(state.copyWith(suggestions: [], isLoading: false, failure: null));
      return;
    }

    emit(state.copyWith(isLoading: true));
    _debouncer.run(() => _search(trimmed));
  }

  Future<void> _search(String query) async {
    final result = await _placeService.suggestPlaces(query);
    switch (result) {
      case Success<List<Place>>(:final data):
        emit(
          state.copyWith(suggestions: data, isLoading: false, failure: null),
        );
      case Failure<List<Place>>(:final failure):
        emit(
          state.copyWith(suggestions: [], isLoading: false, failure: failure),
        );
    }
  }

  void clear() {
    _debouncer.cancel();
    emit(const PlaceSuggestionState());
  }

  @override
  Future<void> close() {
    _debouncer.cancel();
    return super.close();
  }
}
