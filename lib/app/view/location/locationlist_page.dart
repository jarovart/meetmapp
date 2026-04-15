import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meetmaap/app/controller/locationlist_controller.dart';
import 'package:meetmaap/app/model/response/locationbase_response.dart';
import 'package:meetmaap/app/view/util/filterbutton_widget.dart';
import 'package:meetmaap/app/view/util/locationcard_widget.dart';
import 'package:provider/provider.dart';

class LocationsListPage extends StatelessWidget {
  const LocationsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final locationListController = context.watch<LocationListController>();
    final locations = locationListController.locations;

    return Scaffold(
      appBar: AppBar(title: const Text("Locations"), centerTitle: true),
      backgroundColor: Colors.grey.shade200,
      body: Stack(
        children: [
          if (locationListController.isLoading)
            const Center(child: CircularProgressIndicator()),

          if (locationListController.hasError)
            Center(
              child: Text('Fehler: ${locationListController.errorMessage}'),
            ),

          // ⬇️ Optional: wenn keine Locations vorhanden sind
          if (locations.isEmpty)
            RefreshIndicator(
              onRefresh: () async => locationListController.reloadLocations(),
              child: ListView(
                children: const [
                  SizedBox(height: 200),
                  Center(child: Text("Keine Locations gefunden.")),
                ],
              ),
            ),

          if (locations.isNotEmpty)
            LayoutBuilder(
              builder: (context, constraints) {
                const double headerHeight = 60;
                int crossAxisCount = max(1, constraints.maxWidth ~/ 400);

                final grid = GridView.builder(
                  padding: const EdgeInsets.fromLTRB(
                    16,
                    16 + headerHeight, // ✅ startet unter der Suchleiste
                    16,
                    16,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    //childAspectRatio: 4 / 3,
                    mainAxisExtent: 300,
                  ),
                  itemCount: locations.length,
                  itemBuilder: (context, index) {
                    final loc = locations[index];

                    return LocationCard(locationbase: loc);
                  },
                );

                // ⬇️ Pull-to-refresh, damit du manuell neu laden kannst
                return RefreshIndicator(
                  onRefresh: () async {
                    locationListController.reloadLocations();
                  },
                  child: grid,
                );
              },
            ),
          _buildSearchAndFilterBar(context, locationListController),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilterBar(
    BuildContext context,
    LocationListController locationListController,
  ) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: locationListController.searchCtrl,
                onChanged: locationListController.onSearchChanged,
                textInputAction: TextInputAction.search,
                onSubmitted: (_) => locationListController
                    .reloadLocations(), //gibt es nicht bei mappage
                decoration: InputDecoration(
                  hintText: "Suchen...",
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: locationListController.searchCtrl.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            locationListController.clearSearchResults();
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: const Color.fromARGB(
                    255,
                    223,
                    222,
                    222,
                  ).withValues(alpha: 0.8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Material(
              color: const Color.fromARGB(
                255,
                223,
                222,
                222,
              ).withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(16),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => _openFilterDialog(context, locationListController),
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Icon(Icons.tune),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openFilterDialog(
    BuildContext context,
    LocationListController locationListController,
  ) async {
    DateTime? tempStart = locationListController.filterStart;
    DateTime? tempEnd = locationListController.filterEnd;
    String tempPlace = locationListController.filterPlaceText ?? '';
    double tempRadius = locationListController.filterRadiusKm;
    final dateTimeformatter = DateFormat('dd.MM.yyyy HH:mm');

    await showDialog(
      context: context,
      barrierDismissible: true, // ✅ klick außerhalb schließt
      builder: (dialogCtx) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: StatefulBuilder(
            builder: (ctx, setLocalState) {
              Future<void> pickStart() async {
                final picked = await _pickDateTime(ctx, initial: tempStart);
                if (picked == null) return;
                setLocalState(() => tempStart = picked);
              }

              Future<void> pickEnd() async {
                final picked = await _pickDateTime(ctx, initial: tempEnd);
                if (picked == null) return;
                setLocalState(() => tempEnd = picked);
              }

              return ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header mit Titel + X
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Filter",
                              style: Theme.of(ctx).textTheme.titleLarge,
                            ),
                          ),
                          IconButton(
                            tooltip: "Schließen",
                            onPressed: () => Navigator.of(dialogCtx).pop(),
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Inhalt scrollbar (falls klein)
                      Flexible(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Start / Ende
                              Row(
                                children: [
                                  Expanded(
                                    child: FilterButton(
                                      label: "Startzeit",
                                      value: dateTimeformatter.format(
                                        tempStart ??
                                            locationListController.resetStart,
                                      ),
                                      onTap: pickStart,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: FilterButton(
                                      label: "Ende",
                                      value: dateTimeformatter.format(
                                        tempEnd ??
                                            locationListController.resetEnd,
                                      ),
                                      onTap: pickEnd,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 16),

                              // Ort
                              TextField(
                                controller: TextEditingController(
                                  text: tempPlace,
                                ),
                                decoration: const InputDecoration(
                                  labelText: "Ort (z.B. Bremen)",
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (v) => tempPlace = v,
                              ),

                              const SizedBox(height: 16),

                              // Radius
                              Text(
                                "Radius: ${tempRadius.toStringAsFixed(0)} km",
                              ),
                              Slider(
                                value: tempRadius,
                                min: 1,
                                max: 200,
                                divisions: 199,
                                label: "${tempRadius.toStringAsFixed(0)} km",
                                onChanged: (v) =>
                                    setLocalState(() => tempRadius = v),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Buttons unten
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              setLocalState(() {
                                tempStart = locationListController.resetStart;
                                tempEnd = locationListController.resetEnd;
                                tempPlace = '';
                                tempRadius = 10;
                              });
                            },
                            child: const Text("Zurücksetzen"),
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () {
                              locationListController.setFilterSettings(
                                tempStart,
                                tempEnd,
                                tempPlace.trim().isEmpty
                                    ? null
                                    : tempPlace.trim(),
                                tempRadius,
                              );
                              Navigator.of(dialogCtx).pop();
                              locationListController.reloadLocations();
                            },
                            child: const Text("Anwenden"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<DateTime?> _pickDateTime(
    BuildContext context, {
    DateTime? initial,
  }) async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: initial ?? now,
      firstDate: DateTime(now.year - 2),
      lastDate: DateTime(now.year + 5),
    );
    if (date == null) return null;

    final time = await showTimePicker(
      context: context,
      initialTime: initial != null
          ? TimeOfDay.fromDateTime(initial)
          : TimeOfDay.fromDateTime(now),
    );
    if (time == null) return null;

    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }
}
