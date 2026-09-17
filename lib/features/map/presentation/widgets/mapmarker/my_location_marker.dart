// features/map/presentation/widgets/my_location_marker.dart
import 'package:flutter/material.dart';

class MyLocationMarker extends StatefulWidget {
  const MyLocationMarker({super.key});

  @override
  State<MyLocationMarker> createState() => _MyLocationMarkerState();
}

class _MyLocationMarkerState extends State<MyLocationMarker>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const dotColor = Color(0xFF1A73E8);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = Curves.easeOut.transform(_controller.value);

        return Stack(
          alignment: Alignment.center,
          children: [
            // Pulsierender Ring
            Container(
              width: 20 + (44 * t),
              height: 20 + (44 * t),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: dotColor.withValues(alpha: (1 - t) * 0.28),
              ),
            ),
            child!,
          ],
        );
      },
      child: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: dotColor,
          border: Border.all(color: Colors.white, width: 3),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      ),
    );
  }
}
