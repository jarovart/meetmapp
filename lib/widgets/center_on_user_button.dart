import 'package:flutter/material.dart';

class CenterOnUserButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CenterOnUserButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      right: 20,
      child: FloatingActionButton(
        mini: true,
        backgroundColor: Colors.blue.withValues(alpha: 0.3),
        onPressed: onPressed,
        child: const Icon(Icons.my_location, color: Colors.blue),
      ),
    );
  }
}
