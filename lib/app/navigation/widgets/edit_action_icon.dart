import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:casttime/app/navigation/util/route_config.dart';
import 'package:casttime/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:casttime/features/location/presentation/bloc/location_bloc.dart';
import 'package:casttime/features/location/presentation/bloc/location_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EditAction extends StatelessWidget {
  const EditAction();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = context.watch<LocationBloc>().state;
    final currentUserId = context.select<AuthCubit, int?>(
      (c) => c.state.userId,
    );

    final canEdit =
        currentUserId != null && currentUserId == state.location?.createdUserId;

    if (!canEdit) return const SizedBox.shrink();

    return IconButton(
      icon: const Icon(Icons.edit_outlined),
      tooltip: l10n.edit,
      onPressed: () async {
        final changed = await context.push<bool>(
          RouteConfig.getLocationEditUrl(state.location!.id),
        );
        if (changed == true && context.mounted) {
          context.read<LocationBloc>().add(
            LocationRequested(id: state.location!.id),
          );
        }
      },
    );
  }
}
