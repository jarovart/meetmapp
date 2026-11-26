import 'dart:async';

import 'package:casttime/app/presentation/util/load_status.dart';
import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:casttime/features/auth/presentation/cubit/auth_state.dart';
import 'package:casttime/features/profile/domain/model/user_profile.dart';
import 'package:casttime/features/profile/domain/repository/user_profile_repository.dart';
import 'package:casttime/features/profile/presentation/cubit/my_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class MyProfileCubit extends Cubit<MyProfileState> {
  MyProfileCubit(this._repository, AuthCubit authCubit)
    : super(const MyProfileState()) {
    _authSubscription = authCubit.stream.listen((auth) {
      if (!auth.isLoggedIn) emit(const MyProfileState());
    });
  }

  final UserProfileRepository _repository;
  late final StreamSubscription<AuthState> _authSubscription;

  Future<void> load() async {
    if (state.status == LoadStatus.loading) return;
    emit(state.copyWith(status: LoadStatus.loading, failure: null));

    final result = await _repository.fetchMyProfile();
    switch (result) {
      case Success<UserProfile>(:final data):
        emit(state.copyWith(status: LoadStatus.success, profile: data));
      case Failure<UserProfile>(:final failure):
        emit(state.copyWith(status: LoadStatus.failure, failure: failure));
    }
  }

  /// Nach einer erfolgreichen Änderung — ohne zweiten Request.
  void apply(UserProfile profile) {
    emit(MyProfileState(status: LoadStatus.success, profile: profile));
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}
