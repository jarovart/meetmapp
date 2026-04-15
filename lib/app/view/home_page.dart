import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meetmaap/app/model/exception/exception_message.dart';
import 'package:meetmaap/app/model/response/usermyprofile_response.dart';
import 'package:meetmaap/app/service/authentication_service.dart';
import 'package:meetmaap/app/view/map_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool _loggedIn = false;
  bool _isMenuOpen = false;
  static const double _menuWidth = 260;

  @override
  void initState() {
    super.initState();
    _refreshAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          MapPage(() async => await _refreshAuth()),
          if (_isMenuOpen) _buildMenuScrim(),
          _buildSlidingMenu(),
        ],
      ),
    );
  }

  /// ---------- UI-Aufteilung ----------

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("Meetmaap"),
      leading: IconButton(
        icon: Icon(_isMenuOpen ? Icons.close : Icons.menu),
        onPressed: _toggleMenu,
      ),
      actions: [_buildProfileAvatar()],
    );
  }

  void _toggleMenu() {
    setState(() => _isMenuOpen = !_isMenuOpen);
  }

  Widget _buildSlidingMenu() {
    final items = [
      if (!_loggedIn) "Login",
      "Locations",
      if (_loggedIn) "Benutzer",
      "Freunde",
      "Favoriten",
      "Test-ShowModal",
      "Test-SliderGPS",
      "Einstellungen",
      if (_loggedIn) "Logout",
    ];

    return _buildMenuWithItems(items);
  }

  Widget _buildMenuWithItems(List<String> items) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      top: 0,
      bottom: 0,
      left: _isMenuOpen ? 0 : -_menuWidth,
      width: _menuWidth,
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
                          _toggleMenu();
                          await context.push('/login', extra: false);
                          _refreshAuth();
                          return;
                        } else if (label == 'Locations') {
                          _toggleMenu();
                          context.push('/locationlist');
                          return;
                        } else if (label == 'Benutzer') {
                          _toggleMenu();
                          context.push('/userlist');
                          return;
                        } else if (label == "Test-ShowModal") {
                          _toggleMenu();
                          context.push('/test-showmodal');
                          return;
                        } else if (label == "Test-SliderGPS") {
                          _toggleMenu();
                          context.push('/test-slidergps');
                          return;
                        } else if (label == "Einstellungen") {
                          _toggleMenu();
                          context.push('/settingspage');
                          return;
                        } else if (label == "Logout") {
                          _toggleMenu();
                          AuthService.logout();
                          _refreshAuth();
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
      left: _menuWidth,
      child: GestureDetector(
        onTap: _toggleMenu,
        child: Container(color: Colors.black26),
      ),
    );
  }

  Widget _buildProfileAvatar() {
    if (!_loggedIn) {
      return Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: OutlinedButton.icon(
          onPressed: () async => _navigateToProfile(context),
          label: const Text("Login"),
        ),
      );
    }
    return FutureBuilder<UserMyProfileResponse?>(
      future: AuthService.getMyUserProfile(),
      builder: (context, snapshot) {
        final myProfile = snapshot.data;
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

  Future<void> _refreshAuth() async {
    final loggedIn = await AuthService.isLoggedIn();
    debugPrint("refreshAuth");
    setState(() => _loggedIn = loggedIn);
  }

  void _navigateToProfile(BuildContext context) async {
    var loggedIn = await AuthService.isLoggedIn();

    if (!context.mounted) return;

    if (!loggedIn) {
      final loginOk = await context.push<bool>('/login', extra: true);
      debugPrint("loginOk");
      if (!context.mounted) return;

      if (loginOk != true) {
        await _refreshAuth();
        return;
      }
    }

    final username = await AuthService.getUsername();
    final myProfile = await AuthService.getMyUserProfile();

    if (!context.mounted || username == null) {
      await _refreshAuth();
      return;
    }

    await context.push('/profile/$username', extra: myProfile);

    await _refreshAuth();
  }
}
