import 'package:casttime/app/presentation/util/load_status.dart';
import 'package:casttime/core/failure/app_failure.dart';
import 'package:casttime/features/profile/domain/model/user_profile.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_profile_state.freezed.dart';

@freezed
abstract class MyProfileState with _$MyProfileState {
  const factory MyProfileState({
    @Default(LoadStatus.initial) LoadStatus status,
    UserProfile? profile,
    AppFailure? failure,
  }) = _MyProfileState;
}
