import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meetmaap/app/config/app_config.dart';
import 'package:meetmaap/app/config/route_config.dart';
import 'package:meetmaap/app/controller/auth_controller.dart';
import 'package:meetmaap/app/controller/home_controller.dart';
import 'package:meetmaap/app/model/exception/exception_message.dart';
import 'package:meetmaap/app/view/map_page.dart';

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
    authController.refreshIfStale();
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Stack(
        children: [
          MapPage(),
          if (homeController.isMenuOpen) _buildMenuScrim(),
          _buildSlidingMenu(),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(AppConfig.appName),
      leading: IconButton(
        icon: Icon(homeController.isMenuOpen ? Icons.close : Icons.menu),
        onPressed: homeController.toggleMenu,
      ),
      actions: [_buildProfileAvatar(context)],
    );
  }

  Widget _buildSlidingMenu() {
    final loggedIn = homeController.loggedIn;
    final items = [
      if (!loggedIn) "Login",
      "Locations",
      if (loggedIn) "Benutzer",
      "Freunde",
      "Favoriten",
      "Test-ShowModal",
      "Test-SliderGPS",
      "Einstellungen",
      if (loggedIn) "Logout",
    ];

    return _buildMenuWithItems(items);
  }

  Widget _buildMenuWithItems(List<String> items) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      top: 0,
      bottom: 0,
      left: homeController.isMenuOpen ? 0 : -HomeController.menuWidth,
      width: HomeController.menuWidth,
      child: Material(
        elevation: 8,
        color: Colors.white,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Menue",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: items.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final label = items[index];
                    return ListTile(
                      title: Text(label),
                      leading: const Icon(Icons.arrow_right),
                      onTap: () async {
                        // handle navigation for special entries
                        if (label == 'Login') {
                          homeController.toggleMenu();
                          await context.push(RouteConfig.loginUrl);
                          return;
                        } else if (label == 'Locations') {
                          homeController.toggleMenu();
                          context.push(RouteConfig.locationListUrl);
                          return;
                        } else if (label == 'Benutzer') {
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
                        } else if (label == "Einstellungen") {
                          homeController.toggleMenu();
                          context.push(RouteConfig.settingsUrl);
                          return;
                        } else if (label == "Logout") {
                          homeController.toggleMenu();
                          authController.logout();
                          return;
                        }
                        ExceptionMessage.showError(
                          context,
                          "Ausgewaehlt: $label",
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
    authController.refreshIfStale();

    if (homeController.loggedIn) {
      context.push(RouteConfig.myProfileUrl, extra: homeController.myProfile);
    } else {
      context.push(
        RouteConfig.getLoginUrlWithRedirect(RouteConfig.myProfileUrl),
      );
    }
  }
}
