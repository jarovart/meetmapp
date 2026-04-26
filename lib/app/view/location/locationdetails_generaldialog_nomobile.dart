import 'package:flutter/material.dart';
import 'package:meetmaap/app/controller/locationdetails_controller.dart';
import 'package:meetmaap/app/model/response/locationbase_response.dart';
import 'package:meetmaap/app/view/location/locationdetails_content.dart';
import 'package:provider/provider.dart';

class LocationDetailsGeneralDialog extends StatelessWidget {
  const LocationDetailsGeneralDialog({super.key});

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
        return ChangeNotifierProvider(
          create: (_) => LocationDetailsController(locationBase)..load(),
          child: SafeArea(
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
                    child: LocationDetailsGeneralDialog(),
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
    final controller = context.watch<LocationDetailsController>();
    debugPrint("super rebuild");

    if (controller.isLoading) {
      return const Padding(
        padding: EdgeInsets.all(32),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return LocationDetailsContent(controller: controller);
  }
}
