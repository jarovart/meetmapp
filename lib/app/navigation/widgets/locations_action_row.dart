import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:flutter/material.dart';

class LocationActionsRow extends StatelessWidget {
  const LocationActionsRow({
    super.key,
    required this.enabled,
    required this.isLiked,
    required this.isJoined,
    required this.likeCount,
    required this.joinCount,
    required this.onLikeTap,
    required this.onJoinTap,
  });

  final bool enabled;
  final bool isLiked;
  final bool isJoined;
  final int likeCount;
  final int joinCount;
  final VoidCallback onLikeTap;
  final VoidCallback onJoinTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: enabled ? onLikeTap : null,
              icon: Icon(
                isLiked ? Icons.favorite : Icons.favorite_border,
                color: isLiked ? colors.error : null,
              ),
              label: Text(l10n.likesCount(likeCount)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: enabled ? onJoinTap : null,
              icon: Icon(
                isJoined ? Icons.check_circle : Icons.group_add_outlined,
                color: isLiked ? colors.error : null,
              ),
              label: Text(l10n.joinsCount(joinCount)),
            ),
          ),
        ],
      ),
    );
  }
}
