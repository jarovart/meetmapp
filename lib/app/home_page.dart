import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meetmaap/common/utils/exception_message.dart';
import 'package:meetmaap/pages/map_page.dart';
import '../features/profile/profile_page.dart';
import '../features/locations/presentation/locations_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool _isMenuOpen = false;
  static const double _menuWidth = 260;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          MapPage(),
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
      "Karte",
      "Locations",
      "Freunde",
      "Favoriten",
      "Einstellungen",
    ];

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
                      onTap: () {
                        // handle navigation for special entries
                        if (label == 'Locations') {
                          _toggleMenu();
                          context.push('/location/124');
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        );
      },
      child: const Padding(
        padding: EdgeInsets.only(right: 12.0),
        child: CircleAvatar(
          backgroundImage: NetworkImage(
            "https://ui-avatars.com/api/?name=Artem&background=0D8ABC&color=fff",
          ),
        ),
      ),
    );
  }
}
