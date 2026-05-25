import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final Widget child;
  final String? title;

  const InfoCard({required this.child, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Text(
              title!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          child,
        ],
      ),
    );
  }
}
