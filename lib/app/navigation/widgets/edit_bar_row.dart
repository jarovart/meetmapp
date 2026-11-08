import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:casttime/app/navigation/handler/edit_bar_handler.dart';
import 'package:casttime/app/presentation/cubit/app_busy_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditBarRow extends StatelessWidget {
  const EditBarRow({super.key, required this.handler});

  final EditBarHandler handler;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isBusy = context.watch<AppBusyCubit>().state.isBusy;
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      height: 64,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _EditAction(
            icon: Icons.arrow_back_ios_new,
            label: l10n.returnTitle,
            onPressed: isBusy ? null : handler.onCancel,
          ),
          _EditAction(
            icon: Icons.restart_alt,
            label: l10n.reset,
            onPressed: (isBusy || !handler.canReset) ? null : handler.onReset,
          ),
          _EditAction(
            icon: Icons.check,
            label: l10n.save,
            emphasized: true,
            onPressed: (isBusy || !handler.canSave) ? null : handler.onSave,
          ),
        ],
      ),
    );
  }
}

class _EditAction extends StatelessWidget {
  const _EditAction({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.emphasized = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final enabled = onPressed != null;

    final color = !enabled
        ? colors.onSurfaceVariant.withValues(alpha: 0.38)
        : emphasized
        ? colors.primary
        : colors.onSurface;

    return Expanded(
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 2),
            Text(label, style: TextStyle(fontSize: 11, color: color)),
          ],
        ),
      ),
    );
  }
}
