import 'package:casttime/app/navigation/app_navigation.dart';
import 'package:casttime/app/navigation/model/nav_destination.dart';
import 'package:casttime/app/navigation/widgets/nav_row.dart';
import 'package:casttime/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppBottomBar extends StatelessWidget {
  const AppBottomBar({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final isLoggedIn = context.select<AuthCubit, bool>(
      (c) => c.state.isLoggedIn,
    );
    final ctx = NavContext(location: location, isLoggedIn: isLoggedIn);

    final chain = AppNavigation.chainForLocation(
      location,
      fallbackBranchIndex: navigationShell.currentIndex,
    );
    final replacing = chain
        .where((d) => d.replacesBar && d.hasChildren)
        .lastOrNull;

    final rows = <Widget>[];

    if (replacing != null) {
      rows.add(
        NavRow(
          key: ValueKey('row_${replacing.id}'),
          destinations: replacing.children
              .where((d) => d.isVisible(ctx))
              .toList(),
          activeChain: chain,
          isRoot: false,
          navigationShell: navigationShell,
        ),
      );
    } else {
      final extra = chain.first.extraContent;
      if (extra != null) {
        rows.add(extra(context));
        rows.add(const _RowDivider());
      }

      for (final node in chain) {
        final visible = node.children.where((d) => d.isVisible(ctx)).toList();
        if (visible.isEmpty) continue;
        rows.add(
          NavRow(
            key: ValueKey('row_${node.id}'),
            destinations: visible,
            activeChain: chain,
            isRoot: false,
            navigationShell: navigationShell,
          ),
        );
        rows.add(const _RowDivider());
      }

      rows.add(
        NavRow(
          key: const ValueKey('row_root'),
          destinations: AppNavigation.destinations
              .where((d) => d.isVisible(ctx))
              .toList(),
          activeChain: chain,
          isRoot: true,
          navigationShell: navigationShell,
        ),
      );
    }

    return AnimatedSize(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
      alignment: Alignment.bottomCenter,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: Column(
          key: ValueKey(chain.map((d) => d.id).join('/')),
          mainAxisSize: MainAxisSize.min,
          children: rows,
        ),
      ),
    );
  }
}

class _RowDivider extends StatelessWidget {
  const _RowDivider();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.5,
        child: Divider(
          height: 1,
          thickness: 1,
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
    );
  }
}
