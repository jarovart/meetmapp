import 'package:casttime/app/view/util/thumbnail_util.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:casttime/app/config/route_config.dart';
import 'package:casttime/app/model/response/locationbase_response.dart';
import 'package:casttime/extensions/l10n_extension.dart';

class LocationCard extends StatelessWidget {
  final LocationBaseResponse locationbase;

  const LocationCard({required this.locationbase});

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('dd.MM.yyyy HH:mm');
    final l10n = context.l10n;
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => context.push(
        RouteConfig.getLocationUrl(locationbase.id),
        extra: locationbase,
      ),
      child: Container(
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
        child: Column(
          children: [
            ThumbnailImage(
              imageUrl: locationbase.thumbnailImage?.imageUrl,
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
                    locationbase.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),
                  Text(
                    locationbase.description,
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
                        child: Wrap(
                          spacing: 22,
                          runSpacing: 8,
                          children: [
                            Text(
                              locationbase.address,
                              style: TextStyle(
                                color: theme.colorScheme.secondary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
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
                                formatter.format(locationbase.startDateTime),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: theme.colorScheme.secondary,
                              ),
                            ),
                            Text(
                              l10n.displayEnddate(
                                formatter.format(locationbase.endDateTime),
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
