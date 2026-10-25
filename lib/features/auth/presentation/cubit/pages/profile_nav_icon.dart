import 'package:casttime/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:casttime/features/auth/presentation/cubit/auth_state.dart';
import 'package:casttime/features/image/data/mapper/util/image_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileNavIcon extends StatelessWidget {
  const ProfileNavIcon({super.key, this.selected = false});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.username != current.username,
      builder: (context, state) {
        final colors = Theme.of(context).colorScheme;
        if (!state.isLoggedIn) {
          return Icon(
            selected ? Icons.person : Icons.person_outline,
            color: colors.primary,
          );
        }

        final initials = _initialsFrom(state.username);

        return CircleAvatar(
          radius: 14,
          backgroundColor: selected
              ? colors.primary
              : colors.surfaceContainerHighest,
          child: CircleAvatar(
            radius: 25,
            backgroundImage: state.myProfileUrl != null
                ? NetworkImage(ImageUtils.toAbsolute(state.myProfileUrl!))
                : null,
            child: (state.myProfileUrl == null)
                ? Text(
                    initials,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: selected
                          ? colors.onPrimary
                          : colors.onSurfaceVariant,
                    ),
                  )
                : null,
          ),
        );
      },
    );
  }

  String _initialsFrom(String? username) {
    if (username == null || username.isEmpty) return '?';
    final parts = username.trim().split(RegExp(r'\s+'));
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }
}
