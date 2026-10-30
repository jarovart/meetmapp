import 'package:casttime/app/presentation/util/load_status.dart';
import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/features/profile/domain/model/user_profile.dart';
import 'package:casttime/features/profile/domain/service/user_profile_service.dart';
import 'package:casttime/features/profile/presentation/bloc/user_profile_event.dart';
import 'package:casttime/features/profile/presentation/bloc/user_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc(this._profileService) : super(const UserProfileState()) {
    on<UserProfileRequested>(_onRequested);
  }

  final UserProfileService _profileService;

  Future<void> _onRequested(
    UserProfileRequested event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(state.copyWith(status: LoadStatus.loading));

    final result = await _profileService.fetchProfile(event.username);
    switch (result) {
      case Success<UserProfile>(:final data):
        emit(
          state.copyWith(
            status: LoadStatus.success,
            profile: data,
            failure: null,
          ),
        );
      case Failure<UserProfile>(:final failure):
        debugPrint("error profile: $failure");
        emit(state.copyWith(status: LoadStatus.failure, failure: failure));
    }
  }
}
