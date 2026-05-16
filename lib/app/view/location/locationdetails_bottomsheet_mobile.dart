import 'package:flutter/material.dart';
import 'package:meetmaap/app/controller/locationdetails_controller.dart';
import 'package:meetmaap/app/model/response/locationbase_response.dart';
import 'package:meetmaap/app/view/location/locationdetails_content.dart';
import 'package:provider/provider.dart';

class LocationDetailsBottomSheet extends StatelessWidget {
  const LocationDetailsBottomSheet({super.key});

  static Future<void> show(
    BuildContext context, {
    required LocationBaseResponse locationBase,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      enableDrag: true,
      //showDragHandle: true,
      constraints: BoxConstraints(
        maxWidth: double.infinity,
        maxHeight: MediaQuery.of(context).size.height - 110,
      ),
      builder: (_) {
        return ChangeNotifierProvider(
          create: (_) => LocationDetailsController()..load(locationBase),
          child: const LocationDetailsBottomSheet(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<LocationDetailsController>();

    if (controller.isLoading) {
      return const Padding(
        padding: EdgeInsets.all(32),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return DraggableScrollableSheet(
      snap: true,
      snapSizes: const [0.55, 1.0],
      expand: false,
      initialChildSize: 0.55, // 40% Höhe beim Öffnen
      minChildSize: 0.25, // minimal (nach unten ziehen)
      maxChildSize: 1.0, // 🔥 volle Höhe beim Hochziehen
      builder: (_, scrollController) {
        return LocationDetailsContent(
          controller: controller,
          scrollController: scrollController,
          dragHandle: true,
        );
      },
    );
  }
}
