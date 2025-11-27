import 'package:flutter/material.dart';

class CenterOnUserButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CenterOnUserButton({super.key, required this.onPressed});

  // Abstand vom Bildschirmrand
  static const double _padding = 20.0;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: _padding,
      right: _padding,
      child: _buildFloatingButton(),
    );
  }

  Widget _buildFloatingButton() {
    return FloatingActionButton(
      mini: true,
      backgroundColor: Colors.blue.withValues(alpha: 0.3),
      onPressed: onPressed,
      child: _buildIcon(),
    );
  }

  Widget _buildIcon() {
    return const Icon(
      Icons.my_location,
      color: Colors.blue,
    );
  }
}
