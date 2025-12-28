import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:meetmaap/app/repositories/authentication_repository.dart';
import 'package:meetmaap/app/repositories/location_repository.dart';
import 'package:meetmaap/app/model/exceptions/exception_message.dart';
import 'package:meetmaap/app/model/location_base.dart';
import 'package:meetmaap/app/model/location_full.dart';

class LocationCreatePage extends StatefulWidget {
  final LatLng point;

  const LocationCreatePage({super.key, required this.point});

  @override
  State<LocationCreatePage> createState() => _LocationCreatePageState();
}

class _LocationCreatePageState extends State<LocationCreatePage> {
  final _formKey = GlobalKey<FormState>();
  bool _checkingAuth = true;

  // Controllers
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController thumbnailController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController userController = TextEditingController();

  DateTime? selectedDateTime;

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final loggedIn = await AuthRepository.isLoggedIn();

    if (!mounted) return;

    if (!loggedIn) {
      final ok = await context.push<bool>('/loginpage');

      if (ok != true) {
        // User hat Login abgebrochen → Seite schließen
        if (mounted) context.pop();
        return;
      }
    }

    // User ist jetzt sicher eingeloggt
    setState(() => _checkingAuth = false);
  }

  // DATE PICKER
  Future<void> _pickDate() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDateTime ?? now,
      firstDate: DateTime(now.year - 2),
      lastDate: DateTime(now.year + 5),
    );

    if (date == null || !mounted) return;

    // 2️⃣ Uhrzeit wählen
    final time = await showTimePicker(
      context: context,
      initialTime: selectedDateTime != null
          ? TimeOfDay.fromDateTime(selectedDateTime!)
          : TimeOfDay.fromDateTime(now),
    );

    if (time == null) return;
    setState(
      () => selectedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      ),
    );
  }

  // SAVE LOCATION
  void _save() async {
    if (!_formKey.currentState!.validate()) return;

    if (selectedDateTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Bitte ein Datum auswählen")),
      );
      return;
    }

    // 👇 HIER erstellst du das Objekt (LocationFull)
    final createdLocation = LocationFull(
      id: 0, // ID wird vom Server vergeben
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      creationDateTime: selectedDateTime!,
      startDateTime: selectedDateTime!,
      endDateTime: selectedDateTime!,
      position: LatLng(widget.point.latitude, widget.point.longitude),
      thumbnailUrl: [imageController.text.trim()].single,
      imageUrl: [imageController.text.trim()].single,
      createdUserId: 0,
      createdUsername: '',
      joinedUserCount: 0,
      likedUserCount: 0,
    );

    // Rückgabe an vorherige Seite
    try {
      final LocationBase locationBase = await LocationService.uploadLocation(
        createdLocation,
      );
      if (!mounted) return;
      context.pop(locationBase);
    } catch (e) {
      debugPrint("Fehler beim Hochladen der Location: $e");
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Fehler beim Hochladen der Location: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_checkingAuth) {
      return Scaffold(
        appBar: AppBar(title: const Text("Location erstellen")),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Location erstellen")),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- TITLE ---
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Titel",
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v == null || v.isEmpty
                    ? "Titel darf nicht leer sein"
                    : null,
              ),
              const SizedBox(height: 16),

              // --- DESCRIPTION ---
              TextFormField(
                controller: descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Beschreibung",
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? "Beschreibung fehlt" : null,
              ),
              const SizedBox(height: 16),

              // --- DATE ---
              Row(
                children: [
                  Expanded(
                    child: Text(
                      selectedDateTime == null
                          ? "Kein Datum gewählt"
                          : "Datum: ${selectedDateTime!.day}.${selectedDateTime!.month}.${selectedDateTime!.year} ${selectedDateTime!.hour}:${selectedDateTime!.minute}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _pickDate,
                    child: const Text("Datum wählen"),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // --- THUMBNAIL URL ---
              TextFormField(
                controller: thumbnailController,
                decoration: const InputDecoration(
                  labelText: "Thumbnail URL",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // --- IMAGE URL ---
              TextFormField(
                controller: imageController,
                decoration: const InputDecoration(
                  labelText: "Image URL",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // --- USER ---
              TextFormField(
                controller: userController,
                decoration: const InputDecoration(
                  labelText: "Benutzername",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // --- LOCATION PREVIEW ---
              GestureDetector(
                onTap: () {
                  Clipboard.setData(
                    ClipboardData(
                      text:
                          "${widget.point.latitude}, ${widget.point.longitude}",
                    ),
                  );
                  ExceptionMessage.showInfo(
                    context,
                    "Position has been copied!",
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "Position:\nLatitude: ${widget.point.latitude}\nLongitude: ${widget.point.longitude}",
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // --- SAVE BUTTON ---
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _save,
                  child: const Text("Location speichern"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
