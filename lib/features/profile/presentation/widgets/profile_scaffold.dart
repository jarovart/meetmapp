import 'package:casttime/app/di/injection.dart';
import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:casttime/app/navigation/util/route_config.dart';
import 'package:casttime/features/profile/domain/model/location_list_type.dart';
import 'package:casttime/features/profile/domain/model/user_profile.dart';
import 'package:casttime/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:casttime/features/profile/presentation/bloc/profile_event.dart';
import 'package:casttime/features/profile/presentation/cubit/created_locations_cubit.dart';
import 'package:casttime/features/profile/presentation/cubit/joined_locations_cubit.dart';
import 'package:casttime/features/profile/presentation/cubit/liked_locations_cubit.dart';
import 'package:casttime/features/profile/presentation/widgets/profile_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileScaffold extends StatelessWidget {
  const ProfileScaffold({required this.profile, required this.isMyProfile});

  final UserProfile profile;
  final bool isMyProfile;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final tabCount = isMyProfile ? 3 : 2;

    return DefaultTabController(
      length: tabCount,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => getIt<CreatedLocationsCubit>(
              param1: profile.username,
              param2: LocationListType.created,
            )..load(),
          ),
          BlocProvider(
            create: (_) => getIt<JoinedLocationsCubit>(
              param1: profile.username,
              param2: LocationListType.joined,
            )..load(),
          ),
          if (isMyProfile)
            BlocProvider(
              create: (_) => getIt<LikedLocationsCubit>(
                param1: profile.username,
                param2: LocationListType.liked,
              )..load(),
            ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: Text(l10n.profileOf(profile.username)),
            actions: [
              if (isMyProfile)
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      final result = await context.push<bool>(
                        RouteConfig.getProfileEditUrl(profile.username),
                        extra: profile,
                      );
                      if (result == true && context.mounted) {
                        context.read<ProfileBloc>().add(
                          ProfileRequested(profile.username),
                        );
                      }
                    },
                    icon: const Icon(Icons.edit_attributes_outlined),
                    label: Text(l10n.edit),
                  ),
                ),
            ],
          ),
          body: ProfileBody(profile: profile, isMyProfile: isMyProfile),
        ),
      ),
    );
  }
}
