import 'package:flutter/material.dart';
import 'package:meetmaap/app/view/util/actionbutton.dart';
import 'package:meetmaap/app/view/util/infocard.dart';

class ActionStatsCard extends StatelessWidget {
  final int likedCount;
  final int joinedCount;
  final bool isLiked;
  final bool isJoined;
  final VoidCallback onLike;
  final VoidCallback onJoin;

  const ActionStatsCard({
    required this.likedCount,
    required this.joinedCount,
    required this.isLiked,
    required this.isJoined,
    required this.onLike,
    required this.onJoin,
  });

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      child: Row(
        children: [
          Expanded(
            child: ActionButton(
              icon: isLiked ? Icons.favorite : Icons.favorite_border,
              label: '$likedCount Likes',
              active: isLiked,
              onTap: onLike,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ActionButton(
              icon: isJoined ? Icons.check_circle : Icons.group_add_outlined,
              label: '$joinedCount Joins',
              active: isJoined,
              onTap: onJoin,
            ),
          ),
        ],
      ),
    );
  }
}
