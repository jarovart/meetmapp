import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:casttime/features/profile/domain/model/user_profile.dart';
import 'package:casttime/features/profile/presentation/widgets/stat_card.dart';
import 'package:flutter/material.dart';

class StatsSection extends StatelessWidget {
  final UserProfile profile;
  final bool isMyProfile;

  StatsSection({super.key, required this.profile, this.isMyProfile = false});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final items = <Widget>[
      if (isMyProfile)
        StatCard(
          title: l10n.created,
          locationsCount: profile.createdLocationCount ?? 0,
          icon: Icons.create,
        ),
      StatCard(
        title: l10n.joined,
        locationsCount: profile.joinedLocationCount,
        icon: Icons.group,
      ),
      StatCard(
        title: l10n.liked,
        locationsCount: profile.likedLocationCount,
        icon: Icons.favorite,
      ),
    ];

    return Row(
      children: items
          .map(
            (w) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: w,
              ),
            ),
          )
          .toList(),
    );
  }
}
