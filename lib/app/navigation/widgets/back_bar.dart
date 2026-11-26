import 'package:casttime/app/navigation/widgets/dock_container.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BackBarRow extends StatelessWidget {
  const BackBarRow({
    super.key,
    required this.title,
    this.trailing,
    this.onBack,
  });

  final String title;
  final Widget? trailing;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Row(
        children: [
          SizedBox(
            width: 48,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              tooltip: MaterialLocalizations.of(context).backButtonTooltip,
              onPressed: onBack ?? () => context.pop(),
            ),
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(width: 48, child: trailing),
        ],
      ),
    );
  }
}

/// Behält die bisherige Signatur für Seiten ohne Zusatzzeile.
class BackBar extends StatelessWidget {
  const BackBar({super.key, required this.title, this.trailing, this.onBack});

  final String title;
  final Widget? trailing;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return DockContainer(
      child: BackBarRow(title: title, trailing: trailing, onBack: onBack),
    );
  }
}
