import 'package:casttime/app/view/util/thumbnail_util.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:casttime/app/config/route_config.dart';
import 'package:casttime/app/model/response/userbase_response.dart';

class UserCard extends StatelessWidget {
  final UserBaseResponse userbase;

  const UserCard({required this.userbase});

  @override
  Widget build(BuildContext context) {
    final initials = ThumbnailImage.buildInitials(
      firstName: userbase.firstName,
      lastName: userbase.lastName,
      username: userbase.username,
    );

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => context.push(
        RouteConfig.getProfileUrl(userbase.username),
        extra: userbase,
      ),
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
              backgroundImage: userbase.profileImage?.imageUrl != null
                  ? NetworkImage(userbase.profileImage!.imageUrl)
                  : null,
              child: userbase.profileImage?.imageUrl == null
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
                    userbase.username,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    "${userbase.firstName} ${userbase.lastName}",
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
