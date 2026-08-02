// Reine Deko, kennt weder Bloc noch TextField-Details.
import 'package:flutter/material.dart';

class AnimatedSearchDecoration extends StatelessWidget {
  const AnimatedSearchDecoration({
    required this.isFocused,
    required this.dockWidth,
    required this.child,
  });

  final bool isFocused;
  final double dockWidth;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    debugPrint("map search deco");

    return AnimatedContainer(
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
          child: child,
        ),
      ),
    );
  }
}
