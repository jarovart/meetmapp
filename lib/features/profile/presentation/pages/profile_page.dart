import 'package:casttime/app/di/injection.dart';
import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:casttime/app/presentation/util/load_status.dart';
import 'package:casttime/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:casttime/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:casttime/features/profile/presentation/bloc/profile_event.dart';
import 'package:casttime/features/profile/presentation/bloc/profile_state.dart';
import 'package:casttime/features/profile/presentation/widgets/profile_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  final String? username;

  const ProfilePage({super.key, this.username});

  @override
  Widget build(BuildContext context) {
    debugPrint("profilesite: $username");
    return BlocProvider(
      create: (_) => getIt<ProfileBloc>()..add(ProfileRequested(username)),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state.status == LoadStatus.loading ||
            state.status == LoadStatus.initial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final profile = state.profile;
        if (profile == null) {
          return Scaffold(
            appBar: AppBar(title: Text(context.l10n.users)),
            body: Center(child: Text(context.l10n.profileCouldNotBeLoaded)),
          );
        }

        final isMyProfile = context.select<AuthCubit, bool>(
          (cubit) => cubit.state.userId == profile.id,
        );

        return ProfileScaffold(profile: profile, isMyProfile: isMyProfile);
      },
    );
  }
}
