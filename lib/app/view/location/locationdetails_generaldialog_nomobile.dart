import 'package:flutter/material.dart';
import 'package:meetmaap/app/model/responses/locationbase_response.dart';
import 'package:meetmaap/app/model/responses/locationfull_response.dart';
import 'package:meetmaap/app/service/location_service.dart';
import 'package:meetmaap/app/view/location/locationdetails_content.dart';

class LocationDetailsGeneralDialog extends StatelessWidget {
  final LocationBaseResponse locationBase;

  const LocationDetailsGeneralDialog({super.key, required this.locationBase});

  static Future<void> show(
    BuildContext context, {
    required LocationBaseResponse locationBase,
  }) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Location details',
      barrierColor: Colors.black.withValues(alpha: 0.25),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, _, _) {
        return SafeArea(
          left: false,
          right: true,
          bottom: false,
          top: true,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Material(
              elevation: 16,
              borderRadius: const BorderRadius.horizontal(
                right: Radius.circular(16),
              ),
              clipBehavior: Clip.antiAlias,
              child: SizedBox(
                width: 420,
                height: MediaQuery.of(context).size.height,
                child: SafeArea(
                  left: true,
                  child: LocationDetailsGeneralDialog(
                    locationBase: locationBase,
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, animation, _, child) {
        final slideAnimation =
            Tween<Offset>(
              begin: const Offset(-1, 0), // 👈 von links
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
            );

        return SlideTransition(position: slideAnimation, child: child);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LocationFullResponse>(
      future: LocationService.fetchFullLocation(locationBase.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(32),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return const Padding(
            padding: EdgeInsets.all(32),
            child: Text('Fehler beim Laden der Location'),
          );
        }

        final location = snapshot.data!;

        return LocationDetailsContent(location: location);
      },
    );
  }
}
