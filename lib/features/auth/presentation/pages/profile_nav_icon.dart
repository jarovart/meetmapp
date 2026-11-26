import 'package:casttime/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:casttime/features/auth/presentation/cubit/auth_state.dart';
import 'package:casttime/features/image/data/mapper/util/image_utils.dart';
import 'package:casttime/features/image/presentation/widgets/thumbnail_image_util.dart';
import 'package:casttime/features/profile/presentation/cubit/my_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileNavIcon extends StatelessWidget {
  const ProfileNavIcon({super.key, this.selected = false});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isLoggedIn = context.select<AuthCubit, bool>(
      (cubit) => cubit.state.isLoggedIn,
    );

    if (!isLoggedIn) {
      return Icon(
        selected ? Icons.person : Icons.person_outline,
        color: colors.primary,
      );
    }

    final avatar = context
        .select<MyProfileCubit, ({String? url, String initials})>((cubit) {
          final profile = cubit.state.profile;
          return (
            url: profile?.profileImage?.imageUrl,
            initials: ThumbnailImage.buildInitials(
              firstName: profile?.firstName ?? '',
              lastName: profile?.lastName ?? '',
              username: profile?.username ?? '?',
            ),
          );
        });

    final imageUrl = avatar.url;

    return CircleAvatar(
      radius: 14,
      backgroundColor: selected ? colors.primary : Colors.transparent,
      child: CircleAvatar(
        radius: selected ? 12 : 14,
        backgroundColor: colors.surfaceContainerHighest,
        backgroundImage: imageUrl == null || imageUrl.isEmpty
            ? null
            : NetworkImage(ImageUtils.toAbsolute(imageUrl)),
        child: imageUrl == null || imageUrl.isEmpty
            ? Text(
                avatar.initials,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: colors.onSurfaceVariant,
                ),
              )
            : null,
      ),
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
