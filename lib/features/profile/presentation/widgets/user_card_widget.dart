import 'package:casttime/app/navigation/util/route_config.dart';
import 'package:casttime/features/image/presentation/widgets/thumbnail_image_util.dart';
import 'package:casttime/features/profile/domain/model/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserCard extends StatelessWidget {
  final UserProfile user;

  const UserCard({required this.user});

  @override
  Widget build(BuildContext context) {
    final initials = ThumbnailImage.buildInitials(
      firstName: user.firstName,
      lastName: user.lastName,
      username: user.username,
    );

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () =>
          context.push(RouteConfig.getProfileUrl(user.username), extra: user),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(2, 3),
              color: Colors.black.withValues(alpha: 0.06),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest,
              backgroundImage: user.profileImage?.imageUrl != null
                  ? NetworkImage(user.profileImage!.imageUrl)
                  : null,
              child: user.profileImage?.imageUrl == null
                  ? Text(initials)
                  : null,
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    user.username,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    "${user.firstName} ${user.lastName}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
