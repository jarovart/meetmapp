import 'package:casttime/app/navigation/widgets/profile_menu_bar.dart';
import 'package:casttime/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:casttime/features/map/presentation/widgets/mapslider/map_slider_collapsible_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomBarExtension extends StatelessWidget {
  const BottomBarExtension({super.key, required this.currentIndex});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    Widget? content;
    bool showDivider = false;

    if (currentIndex == 0) {
      content = CollapsibleFilterBar(key: ValueKey('filter'));
    } else if (currentIndex == 4) {
      bool isLoggedIn = context.read<AuthCubit>().state.isLoggedIn;
      content = ProfileMenuBar(visible: isLoggedIn);
      if (isLoggedIn) showDivider = true;
    }

    return AnimatedSize(
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOutCubic,
      alignment: Alignment.bottomCenter,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 1000),
        child: content == null
            ? const SizedBox(
                width: double.infinity,
                height: 0,
                key: ValueKey('empty'),
              )
            : Column(
                key: ValueKey('content_$currentIndex'),
                mainAxisSize: MainAxisSize.min,
                children: [
                  content,
                  if (showDivider)
                    Center(
                      child: FractionallySizedBox(
                        widthFactor: 0.5, // 👈 50% der verfügbaren Breite
                        child: Divider(
                          height: 1,
                          thickness: 1,
                          color: Theme.of(context).colorScheme.outlineVariant,
                        ),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
