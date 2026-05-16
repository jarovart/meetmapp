import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String? label;
  final String value;
  final VoidCallback? onTap;

  const InfoRow({
    required this.icon,
    this.label,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return buildOnTap(
      childWidgets: [
        Icon(icon, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 12),
        buildContent(),
      ],
    );
  }

  Widget buildContent() {
    if (label == null) {
      return Expanded(child: Text(value, style: const TextStyle(fontSize: 16)));
    }

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label ?? '',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget buildOnTap({required List<Widget> childWidgets}) {
    if (onTap != null) {
      return InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [...childWidgets, const Icon(Icons.chevron_right)],
          ),
        ),
      );
    }
    return Row(children: childWidgets);
  }
}
