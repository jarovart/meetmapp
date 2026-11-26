// app/navigation/widgets/dock_divider.dart
import 'package:flutter/material.dart';

class DockDivider extends StatelessWidget {
  const DockDivider({super.key});

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
