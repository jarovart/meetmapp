import 'dart:math';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:meetmaap/app/model/exceptions/geolocationpermission_exception.dart';
import 'package:meetmaap/app/model/responses/locationbase_response.dart';
import 'package:meetmaap/app/service/location_service.dart';
import 'package:meetmaap/app/view/util/locationcard_widget.dart';

class LocationsListPage extends StatefulWidget {
  const LocationsListPage({super.key});

  @override
  State<LocationsListPage> createState() => _LocationsListPageState();
}

class _LocationsListPageState extends State<LocationsListPage> {
  late Future<List<LocationBaseResponse>> _futureLocations;
  final TextEditingController _searchCtrl = TextEditingController();
  LatLng? _currentLocation;
  DateTime? _filterStart;
  DateTime? _filterEnd;

  String? _filterPlaceText; // z.B. "Bremen"
  double _filterRadiusKm = 10;

  // optional: falls du Koordinaten statt Text nutzen willst
  LatLng? _filterCenter;

  @override
  void initState() {
    super.initState();
    _loadLocations();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _loadLocations() {
    _determinePosition();
    _futureLocations = _fetchLocations();
  }

  Future<void> _determinePosition() async {
    final result = await LocationService.getCurrentLocation();

    if (!mounted) return; // Ist das Widget noch im Baum?
    switch (result) {
      case LocationSuccess(:final position):
        _currentLocation = position;
      case LocationServiceDisabled():
        debugPrint("Standortdienste sind deaktiviert");
      case LocationPermissionDenied():
        debugPrint("Standort-Berechtigung verweigert");
      case LocationError(:final message):
        debugPrint("Fehler: $message");
    }
  }

  Future<List<LocationBaseResponse>> _fetchLocations() async {
    try {
      return await LocationService.fetchLocations();
      /* TODO: Filter search einbauen
      return await LocationService.fetchAllLocationsByFilter(
        "searchText",
        _currentLocation!,
        DateTime.now(),
        DateTime.now().add(const Duration(days: 7)),
      );*/
    } catch (e) {
      debugPrint('Error fetching all locations: $e');
      // Beispiel-Daten – später ersetzt durch Backend
      return List.generate(
        20,
        (i) => LocationBaseResponse(
          id: i,
          title: "Coole Location #$i",
          description: "Beschreibung $i, Bremen",
          address: "Adresse $i, Bremen",
          creationDateTime: DateTime.now(),
          startDateTime: DateTime.now().add(const Duration(days: 1)),
          endDateTime: DateTime.now().add(const Duration(days: 2)),
          position: LatLng(52.0 + i, 8.0 + i),
          thumbnailUrl:
              "https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800",
          createdUserId: i,
          createdUsername: "test123",
          joinedUserCount: 123,
          likedUserCount: 11,
        ),
      );
      //throw Exception('Failed to load locations');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Locations"), centerTitle: true),
      backgroundColor: Colors.grey.shade200,
      body: Stack(
        children: [
          FutureBuilder<List<LocationBaseResponse>>(
            future: _futureLocations,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Fehler: ${snapshot.error}'));
              }

              final locations = snapshot.data ?? [];

              // ⬇️ Optional: wenn keine Locations vorhanden sind
              if (locations.isEmpty) {
                return RefreshIndicator(
                  onRefresh: () async => _loadLocations(),
                  child: ListView(
                    children: const [
                      SizedBox(height: 200),
                      Center(child: Text("Keine Locations gefunden.")),
                    ],
                  ),
                );
              }

              return LayoutBuilder(
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
                      setState(() {
                        _loadLocations();
                      });
                    },
                    child: grid,
                  );
                },
              );
            },
          ),
          _buildSearchAndFilterBar(context),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilterBar(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchCtrl,
                textInputAction: TextInputAction.search,
                onSubmitted: (_) => _applyFilters(),
                decoration: InputDecoration(
                  hintText: "Suchen...",
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchCtrl.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            _searchCtrl.clear();
                            _applyFilters();
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
                onChanged: (_) {
                  // Optional: debounce, sonst zu viele reloads
                  // erstmal simpel:
                  setState(() {}); // damit suffixIcon korrekt reagiert
                },
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
                onTap: () => _openFilterDialog(context),
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

  Future<void> _openFilterDialog(BuildContext context) async {
    DateTime? tempStart = _filterStart;
    DateTime? tempEnd = _filterEnd;
    String tempPlace = _filterPlaceText ?? '';
    double tempRadius = _filterRadiusKm;

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
                                    child: _FilterButton(
                                      label: "Start",
                                      value:
                                          tempStart?.toString() ??
                                          "nicht gesetzt",
                                      onTap: pickStart,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: _FilterButton(
                                      label: "Ende",
                                      value:
                                          tempEnd?.toString() ??
                                          "nicht gesetzt",
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
                                tempStart = null;
                                tempEnd = null;
                                tempPlace = '';
                                tempRadius = 10;
                              });
                            },
                            child: const Text("Zurücksetzen"),
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _filterStart = tempStart;
                                _filterEnd = tempEnd;
                                _filterPlaceText = tempPlace.trim().isEmpty
                                    ? null
                                    : tempPlace.trim();
                                _filterRadiusKm = tempRadius;
                              });

                              Navigator.of(dialogCtx).pop();
                              _applyFilters();
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

  void _applyFilters() {
    setState(() {
      _futureLocations = _fetchLocationsFiltered();
    });
  }

  Future<List<LocationBaseResponse>> _fetchLocationsFiltered() async {
    final query = _searchCtrl.text.trim();

    // TODO: hier später Backend Call, z.B.
    // return LocationService.fetchAllLocationsByFilter(
    //   query,
    //   center: _filterCenter ?? _currentLocation,
    //   radiusKm: _filterRadiusKm,
    //   start: _filterStart,
    //   end: _filterEnd,
    // );

    // Bis Backend fertig ist: fallback auf normale fetch und client-side filtern:
    final list = await LocationService.fetchLocations();

    return list.where((loc) {
      final matchesText =
          query.isEmpty ||
          loc.title.toLowerCase().contains(query.toLowerCase()) ||
          loc.description.toLowerCase().contains(query.toLowerCase());

      final matchesTime =
          (_filterStart == null || !loc.endDateTime.isBefore(_filterStart!)) &&
          (_filterEnd == null || !loc.startDateTime.isAfter(_filterEnd!));

      return matchesText && matchesTime;
    }).toList();
  }
}

class _FilterButton extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;

  const _FilterButton({
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(value, maxLines: 1, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}
