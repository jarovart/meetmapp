import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:meetmaap/app/config/route_config.dart';
import 'package:meetmaap/app/repository/authentication_repository.dart';
import 'package:meetmaap/app/view/util/app_errormessage_mapper.dart';
import 'package:meetmaap/extensions/l10n_extension.dart';
import 'package:provider/provider.dart';
import 'package:meetmaap/app/controller/profile_controller.dart';
import 'package:meetmaap/app/view/util/locationlisttab_widget.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = context.watch<UserProfileController>();
    final l10n = context.l10n;

    if (!profileController.hasUserProfile) {
      return Scaffold(
        appBar: AppBar(
          title: Text(l10n.profileOf(profileController.displayUsername)),
        ),
        body: Center(child: Text(l10n.profileCouldNotBeLoaded)),
      );
    }

    return DefaultTabController(
      length: (profileController.isMyProfile) ? 3 : 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.profileOf(profileController.displayUsername)),
          centerTitle: true,
          actions: [
            if (profileController.isMyProfile)
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: OutlinedButton.icon(
                  onPressed: () async {
                    final myUserId = await AuthRepository.getUserId();
                    if (!context.mounted || myUserId == null) return;

                    final result = await context.push<bool>(
                      RouteConfig.getProfileEditUrl(
                        profileController.myProfile!.username,
                      ),
                      extra: profileController.myProfile,
                    );
                    if (result == true) {
                      profileController.reload();
                    }
                  },
                  label: Text(l10n.edit),
                  icon: const Icon(Icons.edit_attributes_outlined),
                ),
              ),
          ],
        ),
        body: _buildBody(context, profileController),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    UserProfileController profileController,
  ) {
    final l10n = context.l10n;

    if (profileController.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (profileController.hasError && profileController.userData == null) {
      return Center(
        child: Text(
          AppErrorMapper.toUserMessage(
            profileController.error!,
            l10n,
            fallback: l10n.unknownError,
          ),
        ),
      );
    }

    final user = profileController.userData;
    if (user == null) {
      return Center(child: Text(l10n.profileCouldNotBeLoaded));
    }

    final me = profileController.myProfile;
    final dateFormat = DateFormat("dd.MM.yyyy");

    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  if (profileController.hasError) ...[
                    Center(
                      child: Text(
                        AppErrorMapper.toUserMessage(
                          profileController.error!,
                          l10n,
                          fallback: l10n.unknownError,
                        ),
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                  _buildHeader(
                    context,
                    profileUrl: user.profileImage?.imageUrl ?? '',
                    firstName: user.firstName,
                    lastName: user.lastName,
                    username: user.username,
                    email: me?.email,
                    createdAt: me?.createdAt,
                    dateFormat: dateFormat,
                  ),
                  const SizedBox(height: 24),
                  _buildInfoSection(context, aboutMe: user.aboutMe),
                  const SizedBox(height: 24),
                  _buildStatsSection(
                    context,
                    createdLocations: me?.createdLocations,
                    joinedLocations: user.joinedLocationCount,
                    likedLocations: user.likedLocationCount,
                  ),
                ],
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _TabBarSliverDelegate(
              TabBar(
                onTap: (index) {
                  final c = context.read<UserProfileController>();
                  if (index == 0) {
                    c.loadCreatedLocations();
                  } else if (index == 1) {
                    c.loadJoinedLocations();
                  } else if (index == 2) {
                    c.loadLikedLocations();
                  }
                },
                tabs: [
                  Tab(text: l10n.created),
                  Tab(text: l10n.joined),
                  if (profileController.isMyProfile) Tab(text: l10n.liked),
                ],
              ),
            ),
          ),
        ];
      },
      body: TabBarView(
        children: [
          LocationListTab(
            title: l10n.createdLocations,
            locations: profileController.createdLocations,
            isLoading: profileController.isLoadingCreated,
            onRetry: () => profileController.loadCreatedLocations(),
            onLoadMore: () {
              debugPrint("loaded more created");
              return profileController.loadMoreCreatedLocations();
            },
            isLoadingMore: profileController.isLoadingMoreCreated,
            hasMore: profileController.hasMoreCreated,
          ),
          LocationListTab(
            title: l10n.joinedLocations,
            locations: profileController.joinedLocations,
            isLoading: profileController.isLoadingJoined,
            onRetry: () =>
                context.read<UserProfileController>().loadJoinedLocations(),
            onLoadMore: () {
              debugPrint("loaded more joined");
              return profileController.loadMoreJoinedLocations();
            },
          ),
          if (profileController.isMyProfile)
            LocationListTab(
              title: l10n.likedLocations,
              locations: profileController.likedLocations,
              isLoading: profileController.isLoadingLiked,
              onRetry: () =>
                  context.read<UserProfileController>().loadLikedLocations(),
              onLoadMore: () {
                debugPrint("loaded more liked");
                return profileController.loadMoreLikedLocations();
              },
            ),
        ],
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context, {
    required String? profileUrl,
    required String firstName,
    required String lastName,
    required String username,
    required DateFormat dateFormat,
    String? email,
    DateTime? createdAt,
  }) {
    final initials = _buildInitials(
      firstName: firstName,
      lastName: lastName,
      username: username,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 55,
          backgroundImage: (profileUrl != null && profileUrl.isNotEmpty)
              ? NetworkImage(profileUrl)
              : null,
          child: (profileUrl == null || profileUrl.isEmpty)
              ? Text(initials, style: const TextStyle(fontSize: 26))
              : null,
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$firstName $lastName".trim(),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 6),
              Text("@$username", style: Theme.of(context).textTheme.bodyMedium),
              if (email != null && email.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  email,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
                ),
              ],
              if (createdAt != null) ...[
                const SizedBox(height: 6),
                Text(
                  "Mitglied seit ${dateFormat.format(createdAt)}",
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey.shade500),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSection(BuildContext context, {required String? aboutMe}) {
    final l10n = context.l10n;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.aboutMe, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              aboutMe?.isNotEmpty == true
                  ? aboutMe!
                  : l10n.noDescriptionAvailable,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection(
    BuildContext context, {
    required int? createdLocations,
    required int joinedLocations,
    required int likedLocations,
  }) {
    final l10n = context.l10n;
    final items = <Widget>[
      if (createdLocations != null)
        _buildStatCard(l10n.created, createdLocations, Icons.create),
      _buildStatCard(l10n.joined, joinedLocations, Icons.group),
      _buildStatCard(l10n.liked, likedLocations, Icons.favorite),
    ];

    return Row(
      children: items
          .map(
            (w) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: w,
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildStatCard(String title, int value, IconData icon) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Icon(icon, size: 28),
            const SizedBox(height: 8),
            Text(
              value.toString(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(title),
          ],
        ),
      ),
    );
  }

  String _buildInitials({
    required String? firstName,
    required String? lastName,
    required String? username,
  }) {
    String result = '';

    if (firstName != null && firstName.trim().isNotEmpty) {
      result += firstName.trim()[0];
    }
    if (lastName != null && lastName.trim().isNotEmpty) {
      result += lastName.trim()[0];
    }

    if (result.isEmpty && username != null && username.trim().isNotEmpty) {
      final trimmed = username.trim();
      result = trimmed.length >= 2 ? trimmed.substring(0, 2) : trimmed[0];
    }

    return result.toUpperCase();
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
