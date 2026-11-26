import 'package:casttime/features/image/presentation/widgets/thumbnail_image_util.dart';
import 'package:casttime/features/location/domain/model/location.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyLocationCard extends StatelessWidget {
  const MyLocationCard({
    super.key,
    required this.location,
    required this.isLeaving,
    required this.onTap,
    required this.onLikeTap,
    required this.onJoinTap,
  });

  final Location location;
  final bool isLeaving;
  final VoidCallback onTap;
  final VoidCallback onLikeTap;
  final VoidCallback onJoinTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Opacity(
      opacity: isLeaving ? 0.45 : 1.0,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    width: 64,
                    height: 64,
                    child: ThumbnailImage(
                      imageUrl: location.thumbnailImage?.imageUrl,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        location.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 14,
                            color: colors.onSurfaceVariant,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              _formatRange(location),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13,
                                color: colors.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 14,
                            color: colors.onSurfaceVariant,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              location.address,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13,
                                color: colors.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _CountAction(
                      icon: (location.likedByCurrentUser ?? false)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: (location.likedByCurrentUser ?? false)
                          ? colors.error
                          : colors.onSurfaceVariant,
                      count: location.likedUserCount,
                      onTap: onLikeTap,
                    ),
                    const SizedBox(height: 8),
                    _CountAction(
                      icon: (location.joinedByCurrentUser ?? false)
                          ? Icons.how_to_reg
                          : Icons.person_add_alt_1_outlined,
                      color: (location.joinedByCurrentUser ?? false)
                          ? colors.primary
                          : colors.onSurfaceVariant,
                      count: location.joinedUserCount,
                      onTap: onJoinTap,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatRange(Location location) {
    final day = DateFormat('dd.MM.yyyy');
    final time = DateFormat('HH:mm');
    final start = location.startDateTime;
    final end = location.endDateTime;

    if (day.format(start) == day.format(end)) {
      return '${day.format(start)}, ${time.format(start)}–${time.format(end)}';
    }
    return '${day.format(start)} ${time.format(start)} – '
        '${day.format(end)} ${time.format(end)}';
  }
}

class _CountAction extends StatelessWidget {
  const _CountAction({
    required this.icon,
    required this.color,
    required this.count,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 4),
            Text('$count', style: TextStyle(fontSize: 13, color: color)),
          ],
        ),
      ),
    );
  }
}
