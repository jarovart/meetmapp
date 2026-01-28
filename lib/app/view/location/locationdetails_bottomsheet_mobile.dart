import 'package:flutter/material.dart';
import 'package:meetmaap/app/model/responses/locationfull_response.dart';
import 'package:meetmaap/app/service/location_service.dart';
import 'package:meetmaap/app/model/responses/locationbase_response.dart';
import 'package:meetmaap/app/view/location/locationdetails_content.dart';

class LocationDetailsBottomSheet extends StatefulWidget {
  final LocationBaseResponse locationBase;

  const LocationDetailsBottomSheet({super.key, required this.locationBase});

  // 🔹 Imperativ: öffnet das Sheet
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
      builder: (_) => LocationDetailsBottomSheet(locationBase: locationBase),
    );
  }

  @override
  State<LocationDetailsBottomSheet> createState() =>
      _LocationDetailsBottomSheetState();
}

class _LocationDetailsBottomSheetState
    extends State<LocationDetailsBottomSheet> {
  late final Future<LocationFullResponse>? _future;

  @override
  void initState() {
    super.initState();
    _future = widget.locationBase is LocationFullResponse
        ? Future.value(widget.locationBase as LocationFullResponse)
        : LocationService.fetchFullLocation(widget.locationBase.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LocationFullResponse>(
      future: _future,
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

        return DraggableScrollableSheet(
          snap: true,
          snapSizes: const [0.55, 1.0],
          expand: false,
          initialChildSize: 0.55, // 40% Höhe beim Öffnen
          minChildSize: 0.25, // minimal (nach unten ziehen)
          maxChildSize: 1.0, // 🔥 volle Höhe beim Hochziehen
          builder: (_, scrollController) {
            return LocationDetailsContent(
              location: location,
              scrollController: scrollController,
              dragHandle: true,
            );
          },
        );
      },
    );
  }
}
