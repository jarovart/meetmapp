import 'package:flutter/material.dart';

class CenterOnUserButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CenterOnUserButton({super.key, required this.onPressed});

  // Abstand vom Bildschirmrand
  static const double padding = 20.0;

  @override
  Widget build(BuildContext context) {
    return _buildFloatingButton(context);
  }

  Widget _buildFloatingButton(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return FloatingActionButton(
      mini: true,
      backgroundColor: colors.secondary.withValues(alpha: 0.18),
      foregroundColor: colors.secondary,
      onPressed: onPressed,
      child: _buildIcon(context),
    );
  }

  Widget _buildIcon(BuildContext context) {
    return Icon(
      Icons.my_location,
      color: Theme.of(context).colorScheme.primary,
    );
  }
}
