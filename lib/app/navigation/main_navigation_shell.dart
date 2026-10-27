import 'package:casttime/app/navigation/widgets/app_bottom_bar.dart';
import 'package:casttime/app/presentation/banner/appbottom_banner.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainNavigationShell extends StatelessWidget {
  const MainNavigationShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final width = MediaQuery.of(context).size.width;
    final dockWidth = width >= 700 ? 520.0 : width - 24;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Stack(children: [navigationShell]),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: dockWidth,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
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
                key: null,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const AppBottomBanner(),
                  AppBottomBar(navigationShell: navigationShell),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
