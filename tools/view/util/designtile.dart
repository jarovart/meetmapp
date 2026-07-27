import 'package:flutter/material.dart';
import 'package:casttime/app/view/model/designoption.dart';

class DesignTile extends StatelessWidget {
  final DesignOption option;
  final bool selected;
  final VoidCallback onTap;

  const DesignTile({
    required this.option,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 150,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected
                ? colors.primary
                : colors.secondary.withValues(alpha: 0.3),
            width: selected ? 2 : 1,
          ),
          color: selected
              ? colors.primary.withValues(alpha: 0.12)
              : Colors.transparent,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              selected ? Icons.check_circle_outline : option.icon,
              color: selected ? colors.primary : colors.secondary,
            ),
            const SizedBox(height: 8),
            Text(
              option.label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: selected ? colors.primary : colors.secondary,
                fontWeight: selected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
