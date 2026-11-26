import 'package:casttime/app/presentation/cubit/app_busy_cubit.dart';
import 'package:casttime/app/presentation/util/load_status.dart';
import 'package:casttime/core/failure/app_failure.dart';
import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/features/image/domain/service/image_compressor_service.dart';
import 'package:casttime/features/profile/domain/model/profile_image_change.dart';
import 'package:casttime/features/profile/domain/model/profile_update.dart';
import 'package:casttime/features/profile/domain/model/user_profile.dart';
import 'package:casttime/features/profile/domain/repository/user_profile_repository.dart';
import 'package:casttime/features/profile/presentation/bloc/profile_edit_event.dart';
import 'package:casttime/features/profile/presentation/bloc/profile_edit_state.dart';
import 'package:casttime/features/profile/presentation/cubit/my_profile_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileEditBloc extends Bloc<ProfileEditEvent, ProfileEditState> {
  ProfileEditBloc(
    this._repository,
    this._compressor,
    this._myProfileCubit,
    this._appBusyCubit,
  ) : super(const ProfileEditState()) {
    on<ProfileEditStarted>(_onStarted);
    on<ProfileEditFirstNameChanged>(
      (e, emit) => emit(state.copyWith(firstName: e.value)),
    );
    on<ProfileEditLastNameChanged>(
      (e, emit) => emit(state.copyWith(lastName: e.value)),
    );
    on<ProfileEditAboutMeChanged>(
      (e, emit) => emit(state.copyWith(aboutMe: e.value)),
    );
    on<ProfileEditImageSelected>(_onImageSelected);
    on<ProfileEditImageRemoved>(
      (e, emit) => emit(state.copyWith(imageChange: const RemoveImage())),
    );
    on<ProfileEditSubmitted>(_onSubmitted);
    on<ProfileEditReset>(_onReset);
  }

  final UserProfileRepository _repository;
  final ImageCompressorService _compressor;
  final MyProfileCubit _myProfileCubit;
  final AppBusyCubit _appBusyCubit;

  Future<void> _onStarted(
    ProfileEditStarted event,
    Emitter<ProfileEditState> emit,
  ) async {
    final cached = _myProfileCubit.state.profile;
    if (cached != null) {
      emit(_fromProfile(cached));
      return;
    }

    emit(state.copyWith(status: LoadStatus.loading, failure: null));

    final result = await _repository.fetchMyProfile();
    switch (result) {
      case Success<UserProfile>(:final data):
        _myProfileCubit.apply(data);
        emit(_fromProfile(data));
      case Failure<UserProfile>(:final failure):
        emit(state.copyWith(status: LoadStatus.failure, failure: failure));
    }
  }

  ProfileEditState _fromProfile(UserProfile profile) {
    return ProfileEditState(
      original: profile,
      status: LoadStatus.success,
      firstName: profile.firstName,
      lastName: profile.lastName,
      aboutMe: profile.aboutMe ?? '',
    );
  }

  void _onReset(ProfileEditReset event, Emitter<ProfileEditState> emit) {
    final original = state.original;
    if (original == null) return;
    emit(_fromProfile(original));
  }

  Future<void> _onImageSelected(
    ProfileEditImageSelected event,
    Emitter<ProfileEditState> emit,
  ) async {
    emit(state.copyWith(isProcessingImage: true, failure: null));
    _appBusyCubit.start(this);

    try {
      final compressed = await _compressor.compress(event.bytes);
      emit(
        state.copyWith(
          imageChange: ReplaceImage(compressed),
          isProcessingImage: false,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          isProcessingImage: false,
          failure: const ImageProcessingFailed(),
        ),
      );
    } finally {
      _appBusyCubit.finish(this);
    }
  }

  Future<void> _onSubmitted(
    ProfileEditSubmitted event,
    Emitter<ProfileEditState> emit,
  ) async {
    emit(state.copyWith(isSaving: true, failure: null));
    _appBusyCubit.start(this, messageKey: 'savingProfile');

    try {
      final result = await _repository.updateMyProfile(
        ProfileUpdate(
          firstName: state.firstName,
          lastName: state.lastName,
          aboutMe: state.aboutMe,
          imageChange: state.imageChange,
        ),
      );

      switch (result) {
        case Success<UserProfile>(:final data):
          _myProfileCubit.apply(data);
          emit(state.copyWith(isSaving: false, isSaved: true, original: data));
        case Failure<UserProfile>(:final failure):
          emit(state.copyWith(isSaving: false, failure: failure));
      }
    } finally {
      _appBusyCubit.finish(this);
    }
  }
}
