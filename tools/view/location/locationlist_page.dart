import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:casttime/app/controller/locationlist_controller.dart';
import 'package:casttime/app/model/response/place_response.dart';
import 'package:casttime/app/service/place_service.dart';
import 'package:casttime/app/view/util/app_errormessage_mapper.dart';
import 'package:casttime/app/view/util/filterbutton_widget.dart';
import 'package:casttime/app/view/util/locationcard_widget.dart';
import 'package:casttime/extensions/l10n_extension.dart';
import 'package:provider/provider.dart';

class LocationsListPage extends StatelessWidget {
  const LocationsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final locationListController = context.watch<LocationListController>();
    final locations = locationListController.locations;
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.locations), centerTitle: true),
      body: Stack(
        children: [
          if (locationListController.isLoading)
            const Center(child: CircularProgressIndicator()),

          if (!locationListController.isLoading &&
              locationListController.hasError)
            Center(
              child: Text(
                AppErrorMapper.toUserMessage(
                  locationListController.error!,
                  context.l10n,
                  fallback: l10n.errorCallLocations,
                ),
              ),
            ),

          if (!locationListController.isLoading && locations.isEmpty)
            RefreshIndicator(
              onRefresh: () => locationListController.reloadLocations(),
              child: ListView(
                children: [
                  SizedBox(height: 200),
                  Center(
                    child: Text(
                      (locationListController.searchCtrl.text.length <= 3)
                          ? l10n.useSearch
                          : l10n.noLocationsFound,
                    ),
                  ),
                ],
              ),
            ),

          if (!locationListController.isLoading && locations.isNotEmpty)
            LayoutBuilder(
              builder: (context, constraints) {
                const double headerHeight = 60;
                final int crossAxisCount = max(1, constraints.maxWidth ~/ 400);

                return RefreshIndicator(
                  onRefresh: () => locationListController.reloadLocations(),
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (notification) => locationListController
                        .handleScrollNotification(context, notification),
                    child: GridView.builder(
                      padding: const EdgeInsets.fromLTRB(
                        16,
                        16 + headerHeight,
                        16,
                        16,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        mainAxisExtent: 300,
                      ),
                      itemCount:
                          locations.length +
                          (locationListController.isLoadingMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index >= locations.length) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        final loc = locations[index];
                        return LocationCard(locationbase: loc);
                      },
                    ),
                  ),
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
    final l10n = context.l10n;

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
                onSubmitted: (_) => locationListController.reloadLocations(),
                decoration: InputDecoration(
                  hintText: l10n.searching,
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Material(
              color: Theme.of(context).cardTheme.color,
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
    LatLng? tempFilterCenter = locationListController.filterCenter;
    double tempRadius = locationListController.filterRadiusKm;

    final dateTimeformatter = DateFormat('dd.MM.yyyy HH:mm');
    final placeController = TextEditingController(text: tempPlace);

    List<PlaceResponse> suggestions = [];
    bool isLoadingSuggestions = false;
    String? suggestionsError;
    Timer? debounce;
    final l10n = context.l10n;

    await showDialog(
      context: context,
      barrierDismissible: true,
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

              Future<void> loadSuggestions(String value) async {
                debounce?.cancel();

                final trimmed = value.trim();

                if (trimmed.length < 3) {
                  setLocalState(() {
                    suggestions = [];
                    suggestionsError = null;
                    isLoadingSuggestions = false;
                    tempFilterCenter = null;
                  });
                  return;
                }

                debounce = Timer(const Duration(milliseconds: 400), () async {
                  setLocalState(() {
                    isLoadingSuggestions = true;
                    suggestionsError = null;
                  });

                  try {
                    final result = await PlaceService.suggestPlaces(trimmed);
                    if (!ctx.mounted) return;

                    setLocalState(() {
                      suggestions = result;
                    });
                  } catch (e) {
                    if (!ctx.mounted) return;

                    setLocalState(() {
                      suggestions = [];
                      suggestionsError = l10n.locationCouldNotBeLoaded;
                    });
                  } finally {
                    setLocalState(() {
                      isLoadingSuggestions = false;
                    });
                  }
                });
              }

              return ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              l10n.filter,
                              style: Theme.of(ctx).textTheme.titleLarge,
                            ),
                          ),
                          IconButton(
                            tooltip: l10n.close,
                            onPressed: () {
                              debounce?.cancel();
                              Navigator.of(dialogCtx).pop();
                            },
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Flexible(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: FilterButton(
                                      label: l10n.chooseStartdate,
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
                                      label: l10n.chooseEnddate,
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

                              TextField(
                                controller: placeController,
                                decoration: InputDecoration(
                                  labelText: l10n.places,
                                  border: const OutlineInputBorder(),
                                  suffixIcon: isLoadingSuggestions
                                      ? const Padding(
                                          padding: EdgeInsets.all(12),
                                          child: SizedBox(
                                            width: 18,
                                            height: 18,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                            ),
                                          ),
                                        )
                                      : placeController.text.isNotEmpty
                                      ? IconButton(
                                          icon: const Icon(Icons.close),
                                          onPressed: () {
                                            setLocalState(() {
                                              placeController.clear();
                                              tempPlace = '';
                                              tempFilterCenter = null;
                                              suggestions = [];
                                              suggestionsError = null;
                                            });
                                          },
                                        )
                                      : null,
                                ),
                                onChanged: (v) {
                                  setLocalState(() {
                                    tempPlace = v;
                                    tempFilterCenter = null;
                                  });
                                  loadSuggestions(v);
                                },
                              ),

                              if (suggestionsError != null) ...[
                                const SizedBox(height: 8),
                                Text(
                                  suggestionsError!,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ],

                              if (suggestions.isNotEmpty) ...[
                                const SizedBox(height: 8),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: suggestions.length,
                                    separatorBuilder: (_, _) =>
                                        const Divider(height: 1),
                                    itemBuilder: (context, index) {
                                      final suggestion = suggestions[index];

                                      return ListTile(
                                        leading: Icon(
                                          suggestion.existedPlace
                                              ? Icons.location_city
                                              : Icons.public,
                                        ),
                                        title: Text(suggestion.name),
                                        onTap: () {
                                          setLocalState(() {
                                            tempPlace = suggestion.name;
                                            tempFilterCenter =
                                                suggestion.position;
                                            placeController.text =
                                                suggestion.name;
                                            suggestions = [];
                                            suggestionsError = null;
                                          });
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],

                              const SizedBox(height: 16),

                              Text(
                                l10n.radiusInput(tempRadius.toStringAsFixed(0)),
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
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              setLocalState(() {
                                tempStart = locationListController.resetStart;
                                tempEnd = locationListController.resetEnd;
                                tempPlace = '';
                                tempFilterCenter = null;
                                tempRadius = 10;
                                suggestions = [];
                                suggestionsError = null;
                                placeController.clear();
                              });
                            },
                            child: Text(l10n.reset),
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () async {
                              locationListController.setFilterSettings(
                                tempStart,
                                tempEnd,
                                tempPlace.trim().isEmpty
                                    ? null
                                    : tempFilterCenter,
                                tempPlace.trim().isEmpty
                                    ? null
                                    : tempPlace.trim(),
                                tempRadius,
                              );

                              debounce?.cancel();
                              Navigator.of(dialogCtx).pop();
                              await locationListController.reloadLocations();
                            },
                            child: Text(l10n.apply),
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
    if (date == null || !context.mounted) return null;

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
