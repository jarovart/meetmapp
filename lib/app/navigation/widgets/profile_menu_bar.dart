import 'package:casttime/app/navigation/util/route_config.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileMenuBar extends StatelessWidget {
  const ProfileMenuBar({super.key, required this.visible});

  final bool visible;

  @override
  Widget build(BuildContext context) {
    return /*AnimatedSize(
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOutCubic,
      alignment: Alignment.bottomCenter,
      child: visible
          ? _MenuRow(key: const ValueKey('profile_menu'))
          : const SizedBox(width: double.infinity, height: 0),*/ visible
        ? _MenuRow(key: const ValueKey('profile_menu'))
        : const SizedBox(width: double.infinity, height: 0);
  }
}

class _MenuRow extends StatelessWidget {
  const _MenuRow({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 8),
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            Expanded(
              child: _MenuItem(
                icon: Icons.info_outline,
                label: 'Info',
                onTap: () => context.push(RouteConfig.infoUrl),
              ),
            ),
            Expanded(
              child: _MenuItem(
                icon: Icons.support_agent_outlined,
                label: 'Support',
                onTap: () => context.push(RouteConfig.supportUrl),
              ),
            ),
            Expanded(
              child: _MenuItem(
                icon: Icons.people_outline,
                label: 'Freunde',
                onTap: () => context.push(RouteConfig.userListUrl),
              ),
            ),
            Expanded(
              child: _MenuItem(
                icon: Icons.settings_outlined,
                label: 'Einstellungen',
                onTap: () => context.push(RouteConfig.settingsUrl),
              ),
            ),
            Expanded(
              child: _MenuItem(
                icon: Icons.edit_outlined,
                label: 'Bearbeiten',
                onTap: () =>
                    context.push(RouteConfig.getProfileEditUrl("todo")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Tooltip(
      message: label,
      waitDuration: const Duration(milliseconds: 400),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(icon, color: colors.onSurfaceVariant, size: 20),
            ),
          ),
        ),
      ),
    );
  }
}
