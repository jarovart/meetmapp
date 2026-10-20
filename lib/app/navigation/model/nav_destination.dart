import 'package:flutter/material.dart';

typedef NavAction = void Function(BuildContext context);

class NavContext {
  const NavContext({required this.location, required this.isLoggedIn});

  final String location;
  final bool isLoggedIn;
}

class NavDestination {
  const NavDestination({
    required this.id,
    required this.label,
    required this.icon,
    this.selectedIcon,
    this.customIcon,
    this.routePath,
    this.extraMatchPaths = const [],
    this.branchIndex,
    this.requiresAuth = false,
    this.visibleWhen,
    this.replacesBar = false,
    this.onSelected,
    this.onReselected,
    this.extraContent,
    this.children = const [],
  });

  final String id;
  final String label;
  final IconData icon;
  final IconData? selectedIcon;
  final Widget Function(bool selected)? customIcon;

  /// Zielseite. null = reiner Aktions-Button (Reset, Speichern).
  final String? routePath;

  /// Weitere Pfade, bei denen dieser Punkt als aktiv gilt.
  final List<String> extraMatchPaths;

  /// Nur Top-Level: zugehöriger go_router-Branch.
  final int? branchIndex;

  /// Seite ist login-pflichtig — durchgesetzt im Router, nicht in der Leiste.
  final bool requiresAuth;

  /// Wann der Punkt in der Leiste erscheint. null = immer.
  final bool Function(NavContext)? visibleWhen;

  final bool replacesBar;
  final NavAction? onSelected;
  final NavAction? onReselected;
  final WidgetBuilder? extraContent;
  final List<NavDestination> children;

  bool get hasChildren => children.isNotEmpty;

  bool isVisible(NavContext ctx) => visibleWhen?.call(ctx) ?? true;

  bool matches(String location) {
    final candidates = [if (routePath != null) routePath!, ...extraMatchPaths];
    return candidates.any((p) => location == p || location.startsWith('$p/'));
  }
}
