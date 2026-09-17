import 'package:casttime/app/presentation/util/load_status.dart';
import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/features/profile/domain/model/user_profile.dart';
import 'package:casttime/features/profile/domain/service/profile_service.dart';
import 'package:casttime/features/profile/presentation/bloc/profile_event.dart';
import 'package:casttime/features/profile/presentation/bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this._profileService) : super(const ProfileState()) {
    on<ProfileRequested>(_onRequested);
  }

  final ProfileService _profileService;

  Future<void> _onRequested(
    ProfileRequested event,
    Emitter<ProfileState> emit,
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
        emit(state.copyWith(status: LoadStatus.failure, failure: failure));
    }
  }
}
