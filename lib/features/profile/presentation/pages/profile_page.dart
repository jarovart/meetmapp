import 'package:casttime/app/di/injection.dart';
import 'package:casttime/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:casttime/features/profile/presentation/bloc/user_profile_bloc.dart';
import 'package:casttime/features/profile/presentation/bloc/user_profile_event.dart';
import 'package:casttime/features/profile/presentation/bloc/user_profile_state.dart';
import 'package:casttime/features/profile/presentation/widgets/user_profile_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  final String username;

  const ProfilePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    debugPrint("profilesite: $username");
    return BlocProvider(
      create: (_) =>
          getIt<UserProfileBloc>()..add(UserProfileRequested(username)),
      child: _ProfileView(username: username),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView({required this.username});

  final String username;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        final profileId = state.profile?.id;
        final isMyProfile = context.select<AuthCubit, bool>(
          (cubit) => profileId != null && cubit.state.userId == profileId,
        );

        return ProfileBody(
          status: state.status,
          profile: state.profile,
          isMyProfile: isMyProfile,
          onRetry: () => context.read<UserProfileBloc>().add(
            UserProfileRequested(username),
          ),
        );
      },
    );
  }
}
