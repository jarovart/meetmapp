import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:meetmaap/app/repository/authentication_repository.dart';
import 'package:provider/provider.dart';
import 'package:meetmaap/app/controller/profile_controller.dart';
import 'package:meetmaap/app/view/util/locationlisttab_widget.dart';

class UserProfilePage extends StatefulWidget {
  final int? userId;

  const UserProfilePage({super.key, this.userId});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  void initState() {
    super.initState();
    if (widget.userId == null) {
      _checkAuth();
    }
  }

  Future<void> _checkAuth() async {
    final loggedIn = await AuthRepository.isLoggedIn();

    if (!mounted) return;

    if (!loggedIn) {
      final ok = await context.push<bool>('/loginpage');

      if (ok != true) {
        // User hat Login abgebrochen → Seite schließen
        if (mounted) context.pop();
        return;
      }
    }
    final userId = await AuthRepository.getUserId();
    if (!mounted) return;
    context.read<UserProfileController>().load(userId: userId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<UserProfileController>();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profil"),
          centerTitle: true,
          actions: [
            if (controller.canEdit)
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: OutlinedButton.icon(
                  onPressed: () async {
                    final myUserId = await AuthRepository.getUserId();
                    if (!context.mounted || myUserId == null) return;

                    final result = await context.push<bool>(
                      "/editmyprofilepage",
                      extra: controller.myProfile?.id,
                    );
                    if (result == true) {
                      controller.reload();
                    }
                  },
                  label: const Text("Edit"),
                  icon: const Icon(Icons.edit_attributes_outlined),
                ),
              ),
          ],
        ),
        body: _buildBody(context, controller),
      ),
    );
  }

  Widget _buildBody(BuildContext context, UserProfileController controller) {
    if (controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.hasError && controller.userData == null) {
      return Center(
        child: Text(controller.errorMessage ?? "Unbekannter Fehler"),
      );
    }

    final user = controller.userData;
    if (user == null) {
      return const Center(child: Text("Kein User geladen."));
    }

    final me = controller.myProfile;
    final dateFormat = DateFormat("dd.MM.yyyy");

    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildHeader(
                    context,
                    profileUrl: user.profileUrl,
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
                tabs: const [
                  Tab(text: 'Erstellt'),
                  Tab(text: 'Beigetreten'),
                  Tab(text: 'Geliked'),
                ],
              ),
            ),
          ),
        ];
      },
      body: TabBarView(
        children: [
          LocationListTab(
            title: "Erstellte Locations",
            locations: controller.createdLocations,
            isLoading: controller.isLoadingCreated,
            onRetry: () =>
                context.read<UserProfileController>().loadCreatedLocations(),
            onLoadMore: () {
              debugPrint("loaded more");
              return context
                  .read<UserProfileController>()
                  .loadCreatedLocations(); //context.read<UserProfileController>().loadMoreCreatedLocations(),
            },
            isLoadingMore: false, //controller.isLoadingMoreCreated,
            hasMore: true, //controller.hasMoreCreated,
          ),
          LocationListTab(
            title: "Beigetretene Locations",
            locations: controller.joinedLocations,
            isLoading: controller.isLoadingJoined,
            onRetry: () =>
                context.read<UserProfileController>().loadJoinedLocations(),
          ),
          LocationListTab(
            title: "Gelikte Locations",
            locations: controller.likedLocations,
            isLoading: controller.isLoadingLiked,
            onRetry: () =>
                context.read<UserProfileController>().loadLikedLocations(),
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
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Über mich", style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              aboutMe?.isNotEmpty == true
                  ? aboutMe!
                  : "Keine Beschreibung vorhanden.",
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
    final items = <Widget>[
      if (createdLocations != null)
        _buildStatCard("Erstellt", createdLocations, Icons.create),
      _buildStatCard("Beigetreten", joinedLocations, Icons.group),
      _buildStatCard("Geliked", likedLocations, Icons.favorite),
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
