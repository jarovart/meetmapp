import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meetmaap/app/config/app_config.dart';
import 'package:meetmaap/app/config/route_config.dart';
import 'package:meetmaap/app/controller/auth_controller.dart';
import 'package:meetmaap/app/controller/home_controller.dart';
import 'package:meetmaap/app/model/exception/exception_message.dart';
import 'package:meetmaap/app/view/map_page.dart';
import 'package:meetmaap/extensions/l10n_extension.dart';

class HomePage extends StatelessWidget {
  final HomeController homeController;
  final AuthController authController;

  const HomePage({
    super.key,
    required this.homeController,
    required this.authController,
  });

  @override
  Widget build(BuildContext context) {
    authController.refreshLogin("(homepage start)");
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Stack(
        children: [
          MapPage(),
          if (homeController.isMenuOpen) _buildMenuScrim(),
          _buildSlidingMenu(context),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(AppConfig.appName),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,

            colors: [
              Theme.of(context).colorScheme.surface,

              Theme.of(context).colorScheme.surfaceContainerHighest,
            ],
          ),
        ),
      ),
      leading: IconButton(
        icon: Icon(homeController.isMenuOpen ? Icons.close : Icons.menu),
        onPressed: homeController.toggleMenu,
      ),

      actions: [
        IconButton(
          icon: Icon(authController.hasToken ? Icons.close : Icons.token),
          onPressed: () => authController.refreshLogin("appbarbutton"),
        ),
        _buildProfileAvatar(context),
      ],
    );
  }

  Widget _buildSlidingMenu(BuildContext context) {
    final loggedIn = homeController.loggedIn;
    final items = [
      if (!loggedIn) context.l10n.login,
      context.l10n.locations,
      if (loggedIn) context.l10n.users,
      context.l10n.friends,
      context.l10n.favourites,
      "Test-ShowModal",
      "Test-SliderGPS",
      context.l10n.settings,
      if (loggedIn) context.l10n.logout,
    ];

    return _buildMenuWithItems(context, items);
  }

  Widget _buildMenuWithItems(BuildContext context, List<String> items) {
    final theme = Theme.of(context);

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      top: 0,
      bottom: 0,
      left: homeController.isMenuOpen ? 0 : -HomeController.menuWidth,
      width: HomeController.menuWidth,
      child: Material(
        elevation: 8,
        color: theme.drawerTheme.backgroundColor ?? theme.colorScheme.surface,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  context.l10n.menu,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: items.length,
                  separatorBuilder: (_, _) =>
                      Divider(height: 1, color: theme.dividerColor),
                  itemBuilder: (context, index) {
                    final label = items[index];
                    return ListTile(
                      title: Text(label),
                      leading: Icon(
                        Icons.arrow_right,
                        color: theme.primaryColor,
                      ),
                      textColor: theme.textTheme.bodyLarge?.color,
                      iconColor: theme.primaryColor,
                      onTap: () async {
                        // handle navigation for special entries
                        if (label == context.l10n.login) {
                          homeController.toggleMenu();
                          await context.push(RouteConfig.loginUrl);
                          return;
                        } else if (label == context.l10n.locations) {
                          homeController.toggleMenu();
                          context.push(RouteConfig.locationListUrl);
                          return;
                        } else if (label == context.l10n.users) {
                          homeController.toggleMenu();
                          context.push(RouteConfig.userListUrl);
                          return;
                        } else if (label == "Test-ShowModal") {
                          homeController.toggleMenu();
                          context.push(RouteConfig.testShowModalUrl);
                          return;
                        } else if (label == "Test-SliderGPS") {
                          homeController.toggleMenu();
                          context.push(RouteConfig.testSliderGps);
                          return;
                        } else if (label == context.l10n.settings) {
                          homeController.toggleMenu();
                          context.push(RouteConfig.settingsUrl);
                          return;
                        } else if (label == context.l10n.logout) {
                          homeController.toggleMenu();
                          authController.logout();
                          return;
                        }
                        ExceptionMessage.showError(
                          context,
                          context.l10n.choosedLabel(label),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuScrim() {
    return Positioned.fill(
      left: HomeController.menuWidth,
      child: GestureDetector(
        onTap: homeController.toggleMenu,
        child: Container(color: Colors.black26),
      ),
    );
  }

  Widget _buildProfileAvatar(BuildContext context) {
    final myProfile = authController.myProfile;

    if (!homeController.loggedIn) {
      return Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: OutlinedButton.icon(
          onPressed: () async => _navigateToProfile(context),
          label: const Text("Login"),
        ),
      );
    }
    final initials = myProfile?.getInitials ?? "MM";
    return GestureDetector(
      onTap: () async => _navigateToProfile(context),
      child: Padding(
        padding: EdgeInsets.only(right: 12.0),
        child: CircleAvatar(
          radius: 25,
          backgroundImage:
              myProfile?.profileImage != null &&
                  myProfile!.profileImage!.imageUrl.isNotEmpty
              ? NetworkImage(myProfile.profileImage!.imageUrl)
              : null,
          child:
              (myProfile?.profileImage?.imageUrl == null ||
                  myProfile!.profileImage!.imageUrl.isEmpty)
              ? Text(initials, style: const TextStyle(fontSize: 24))
              : null,
        ),
      ),
    );
  }

  void _navigateToProfile(BuildContext context) async {
    authController.refreshLogin("(homepage navigateToProfile)");

    if (homeController.loggedIn) {
      context.push(RouteConfig.myProfileUrl, extra: homeController.myProfile);
    } else {
      context.push(
        RouteConfig.getLoginUrlWithRedirect(RouteConfig.myProfileUrl),
      );
    }
  }
}
