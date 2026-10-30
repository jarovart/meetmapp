import 'package:casttime/app/presentation/util/load_status.dart';
import 'package:casttime/core/failure/app_failure.dart';
import 'package:casttime/features/profile/domain/model/user_profile.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_state.freezed.dart';

@freezed
abstract class UserProfileState with _$UserProfileState {
  const factory UserProfileState({
    @Default(LoadStatus.initial) LoadStatus status,
    UserProfile? profile,
    AppFailure? failure,
  }) = _UserProfileState;
}
