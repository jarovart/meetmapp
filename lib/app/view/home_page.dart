import 'package:casttime/app/config/api_config.dart';
import 'package:casttime/app/config/dev_config.dart';
import 'package:casttime/app/controller/login_controller.dart';
import 'package:casttime/app/controller/map_controller.dart';
import 'package:casttime/app/controller/setting_controller.dart';
import 'package:casttime/app/view/authentication/loginpage.dart';
import 'package:casttime/app/view/location/locationcreate_page.dart';
import 'package:casttime/app/view/location/locationlist_page.dart';
import 'package:casttime/app/view/setting/setting_page.dart';
import 'package:casttime/app/view/user/profile_page.dart';
import 'package:casttime/app/view/user/userlist_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:casttime/app/config/app_config.dart';
import 'package:casttime/app/config/route_config.dart';
import 'package:casttime/app/controller/auth_controller.dart';
import 'package:casttime/app/controller/home_controller.dart';
import 'package:casttime/app/model/exception/exception_message.dart';
import 'package:casttime/app/view/map_page.dart';
import 'package:casttime/extensions/l10n_extension.dart';
import 'package:provider/provider.dart';

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
    final width = MediaQuery.of(context).size.width;
    final colors = Theme.of(context).colorScheme;
    final theme = Theme.of(context);
    final authController = context.watch<AuthController>();
    final mapViewController = context.watch<MapViewController>();
    final isLoggedIn = authController.isLoggedIn;

    final isWide = width >= 430;
    final dockWidth = width >= 700 ? 520.0 : width - 24;
    final pages = [
      const MapPage(),
      const LocationsListPage(), // mylocation später ersetzen
      const LocationsListPage(),
      const UserListPage(), // search/discover
      authController.isLoggedIn
          ? const UserProfilePage()
          : LoginPage(
              loginController: LoginController(),
              authController: authController,
            ),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Stack(
        children: [
          pages[homeController.index],
          _buildSearchBar(context, mapViewController, dockWidth),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: dockWidth,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: colors.surface.withValues(alpha: 0.66),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: colors.outlineVariant),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.16),
                        blurRadius: 24,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 4,
                        ),
                        child: SizedBox(
                          height: 24,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    mapViewController.setDayOptionsText(
                                      mapViewController.selectedRange.start,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    mapViewController.setDayOptionsText(
                                      mapViewController.selectedRange.end,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                AppConfig.appName,
                                style: Theme.of(context).textTheme.titleSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      slider(context),
                      NavigationBar(
                        selectedIndex: homeController.index,
                        onDestinationSelected: homeController.changeValue,
                        height: isWide ? 68 : 62,
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        indicatorColor: colors.primary.withValues(alpha: 0.16),
                        labelBehavior: isWide
                            ? NavigationDestinationLabelBehavior.alwaysShow
                            : NavigationDestinationLabelBehavior
                                  .onlyShowSelected,
                        destinations: [
                          const NavigationDestination(
                            icon: Icon(Icons.map_outlined),
                            selectedIcon: Icon(Icons.map),
                            label: 'Map',
                          ),
                          const NavigationDestination(
                            icon: Icon(Icons.my_location_outlined),
                            selectedIcon: Icon(Icons.my_location),
                            label: 'Me',
                          ),
                          const NavigationDestination(
                            icon: Icon(Icons.add_circle_outline),
                            selectedIcon: Icon(Icons.add_circle),
                            label: 'Create',
                          ),
                          const NavigationDestination(
                            icon: Icon(Icons.search_outlined),
                            selectedIcon: Icon(Icons.search),
                            label: 'Search',
                          ),
                          NavigationDestination(
                            icon: Icon(
                              isLoggedIn ? Icons.person_outline : Icons.login,
                            ),
                            selectedIcon: Icon(
                              isLoggedIn ? Icons.person : Icons.login,
                            ),
                            label: isLoggedIn ? 'Profile' : 'Login',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(
    BuildContext context,
    MapViewController mapViewController,
    double dockWidth,
  ) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final sidePadding = screenWidth * 0.15;
    final topOffset = 15.0;
    final searchController = mapViewController.searchController;
    final isFocused = mapViewController.searchFocusNode.hasFocus;

    return SafeArea(
      bottom: false,
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: dockWidth,
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: AnimatedContainer(
              width: dockWidth,
              duration: const Duration(milliseconds: 150),
              decoration: BoxDecoration(
                color: isFocused
                    ? colors.surface.withValues(alpha: 0.95)
                    : colors.surfaceContainerHighest.withValues(alpha: 0.75),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isFocused
                      ? colors.primary
                      : colors.outline.withValues(alpha: 0.25),
                  width: 1.5,
                ),
                boxShadow: isFocused
                    ? [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.12),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : [],
              ),
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(24),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: TextField(
                    focusNode: mapViewController.searchFocusNode,
                    controller: searchController,
                    onChanged: mapViewController.onSearchChanged,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: context.l10n.searching,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: colors.onSurfaceVariant,
                      ),
                      suffixIcon: searchController.text.isNotEmpty
                          ? IconButton(
                              icon: Icon(
                                Icons.close,
                                color: colors.onSurfaceVariant,
                              ),
                              onPressed: mapViewController.closeSearch,
                            )
                          : null,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                      ),
                    ),
                    style: TextStyle(color: colors.onSurface),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget slider(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final theme = Theme.of(context);
    final mapViewController = context.watch<MapViewController>();

    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        showValueIndicator: ShowValueIndicator.never,
        activeTrackColor: theme.iconTheme.color,
        inactiveTrackColor: colors.secondary.withValues(alpha: 0.3),
        thumbColor: colors.primary,
        overlayColor: colors.primary.withValues(alpha: 0.15),
        valueIndicatorColor: theme.cardTheme.color!.withValues(alpha: 0.2),
        valueIndicatorTextStyle: TextStyle(color: colors.primary),
        trackHeight: 2,
        rangeThumbShape: const RoundRangeSliderThumbShape(
          enabledThumbRadius: 8,
        ),
      ),
      child: RangeSlider(
        values: mapViewController.selectedRange,
        min: 0,
        max: (mapViewController.dayOptions.length - 1).toDouble(),
        divisions: mapViewController.dayOptions.length - 1,
        labels: RangeLabels(
          mapViewController.setDayOptionsText(
            mapViewController.selectedRange.start,
          ),
          mapViewController.setDayOptionsText(
            mapViewController.selectedRange.end,
          ),
        ),
        onChanged: (values) {
          // snap to discrete steps
          final start = values.start.roundToDouble();
          final end = values.end.roundToDouble();
          mapViewController.setDateRange(RangeValues(start, end));

          mapViewController.debouncer.run(
            () => mapViewController.fetchLocations(),
          );
        },
      ),
    );
  }

  @override
  Widget build1(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final pages = const [
      MapPage(),
      LocationsListPage(),
      //LocationCreatePage(),
      UserListPage(),
      UserListPage(),
      SettingsPage(),
    ];

    return Scaffold(
      extendBody: true,
      body: pages[homeController.index],
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: colors.surface.withValues(alpha: 0.92),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: colors.outlineVariant),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.14),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: NavigationBar(
            selectedIndex: homeController.index,
            onDestinationSelected: (value) {
              debugPrint("$value");
              homeController.changeValue(value);
              //setState(() => _index = value);
            },
            backgroundColor: Colors.transparent,
            elevation: 0,
            height: 64,
            indicatorColor: colors.primary.withValues(alpha: 0.16),
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.map_outlined),
                selectedIcon: Icon(Icons.map),
                label: 'Map',
              ),
              NavigationDestination(
                icon: Icon(Icons.event_outlined),
                selectedIcon: Icon(Icons.event),
                label: 'Events',
              ),
              NavigationDestination(
                icon: Icon(Icons.add_circle_outline),
                selectedIcon: Icon(Icons.add_circle),
                label: 'Create',
              ),
              NavigationDestination(
                icon: Icon(Icons.people_outline),
                selectedIcon: Icon(Icons.people),
                label: 'Users',
              ),
              NavigationDestination(
                icon: Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        ),
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
      actions: [
        if (DevConfig.isDev)
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
      //context.l10n.favourites,
      //"Test-ShowModal",
      //"Test-SliderGPS",
      context.l10n.settings,
      context.l10n.support,
      context.l10n.info,
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
        color: theme.cardTheme.color ?? theme.colorScheme.surface,
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
                        color: theme.colorScheme.secondary,
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
                        } else if (label == context.l10n.support) {
                          homeController.toggleMenu();
                          context.push(RouteConfig.supportUrl);
                          return;
                        } else if (label == context.l10n.info) {
                          homeController.toggleMenu();
                          context.push(RouteConfig.infoUrl);
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
    return Consumer<AuthController>(
      builder: (context, authController, _) {
        final myProfile = authController.myProfile;

        if (!authController.isLoggedIn) {
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
      },
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
