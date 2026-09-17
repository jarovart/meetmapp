import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:casttime/app/navigation/util/route_config.dart';
import 'package:casttime/features/image/presentation/widgets/thumbnail_image_util.dart';
import 'package:casttime/features/location/domain/model/location.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({super.key, required this.location});

  final Location location;

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('dd.MM.yyyy HH:mm');
    final l10n = context.l10n;
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => context.push(
        RouteConfig.getLocationUrl(location.id),
        extra: location,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
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
        child: Column(
          children: [
            ThumbnailImage(
              imageUrl: location.thumbnailImage?.imageUrl,
              height: 130,
              width: double.infinity,
              iconSize: 56,
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    location.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: theme.colorScheme.secondary),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 20),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          location.address,
                          style: TextStyle(color: theme.colorScheme.secondary),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 16),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Wrap(
                          spacing: 22,
                          runSpacing: 8,
                          children: [
                            Text(
                              l10n.displayStartdate(
                                formatter.format(location.startDateTime),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: theme.colorScheme.secondary,
                              ),
                            ),
                            Text(
                              l10n.displayEnddate(
                                formatter.format(location.endDateTime),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: theme.colorScheme.secondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
