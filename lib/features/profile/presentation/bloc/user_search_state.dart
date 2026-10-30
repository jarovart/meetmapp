import 'package:casttime/app/presentation/util/load_status.dart';
import 'package:casttime/core/failure/app_failure.dart';
import 'package:casttime/features/profile/domain/model/user_profile.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_search_state.freezed.dart';

@freezed
abstract class UserSearchState with _$UserSearchState {
  const factory UserSearchState({
    @Default(LoadStatus.initial) LoadStatus status,
    @Default('') String query,
    @Default([]) List<UserProfile> users,
    @Default(0) int page,
    @Default(true) bool hasMore,
    @Default(false) bool isLoadingMore,
    AppFailure? failure,
  }) = _UserSearchState;

  const UserSearchState._();

  bool get queryTooShort => query.trim().length < minQueryLength;

  static const minQueryLength = 3;
}
