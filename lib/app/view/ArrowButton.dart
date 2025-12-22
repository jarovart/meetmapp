import 'package:flutter/material.dart';

class ArrowButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const ArrowButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: onPressed != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: IconButton(
        iconSize: 48,
        splashRadius: 28,
        icon: Icon(
          icon,
          color: onPressed != null
              ? Colors.white
              : Colors.white.withOpacity(0.3),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
