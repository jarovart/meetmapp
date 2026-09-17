import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:casttime/features/image/presentation/widgets/thumbnail_image_util.dart';
import 'package:casttime/features/profile/domain/model/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HeaderSection extends StatelessWidget {
  final UserProfile profile;
  final DateFormat dateFormat;

  HeaderSection({super.key, required this.profile, required this.dateFormat});

  @override
  Widget build(BuildContext context) {
    String? profileUrl = profile.profileImage?.imageUrl;
    final initials = ThumbnailImage.buildInitials(
      firstName: profile.firstName,
      lastName: profile.lastName,
      username: profile.username,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 55,
          backgroundImage: (profileUrl != null && profileUrl.isNotEmpty)
              ? NetworkImage(profileUrl)
              : null,
          child: (profileUrl == null || profileUrl.isEmpty)
              ? Text(initials, style: const TextStyle(fontSize: 26))
              : null,
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${profile.firstName} ${profile.lastName}".trim(),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 6),
              Text(
                profile.username,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              if (profile.email != null && profile.email!.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  profile.email!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
              if (profile.createdAt != null) ...[
                const SizedBox(height: 6),
                Text(
                  context.l10n.memberSince(
                    dateFormat.format(profile.createdAt!),
                  ),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
