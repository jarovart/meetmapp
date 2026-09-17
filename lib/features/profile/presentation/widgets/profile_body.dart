import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:casttime/features/profile/domain/model/location_list_type.dart';
import 'package:casttime/features/profile/domain/model/user_profile.dart';
import 'package:casttime/features/profile/presentation/cubit/created_locations_cubit.dart';
import 'package:casttime/features/profile/presentation/cubit/joined_locations_cubit.dart';
import 'package:casttime/features/profile/presentation/cubit/liked_locations_cubit.dart';
import 'package:casttime/features/profile/presentation/widgets/info_section.dart';
import 'package:casttime/features/profile/presentation/widgets/location_tab.dart';
import 'package:casttime/features/profile/presentation/widgets/header_section.dart';
import 'package:casttime/features/profile/presentation/widgets/stats_section.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({required this.profile, required this.isMyProfile});

  final UserProfile profile;
  final bool isMyProfile;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final dateFormat = DateFormat('dd.MM.yyyy');

    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                HeaderSection(profile: profile, dateFormat: dateFormat),
                const SizedBox(height: 24),
                InfoSection(aboutMe: profile.aboutMe),
                const SizedBox(height: 24),
                StatsSection(profile: profile, isMyProfile: isMyProfile),
              ],
            ),
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: _TabBarSliverDelegate(
            TabBar(
              tabs: [
                Tab(text: l10n.created),
                Tab(text: l10n.joined),
                if (isMyProfile) Tab(text: l10n.liked),
              ],
            ),
          ),
        ),
      ],
      body: TabBarView(
        children: [
          LocationTab<CreatedLocationsCubit>(title: l10n.createdLocations),
          LocationTab<JoinedLocationsCubit>(title: l10n.joinedLocations),
          if (isMyProfile)
            LocationTab<LikedLocationsCubit>(title: l10n.likedLocations),
        ],
      ),
    );
  }
}

class _TabBarSliverDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _TabBarSliverDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      elevation: overlapsContent ? 2 : 0,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_TabBarSliverDelegate oldDelegate) {
    return oldDelegate.tabBar != tabBar;
  }
}
