import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:meetmaap/features/locations/data/location_base.dart';
import 'package:meetmaap/features/locations/data/location_full.dart';

class LocationCreatePage extends StatefulWidget {
  final LatLng point;

  const LocationCreatePage({super.key, required this.point});

  @override
  State<LocationCreatePage> createState() => _LocationCreatePageState();
}

class _LocationCreatePageState extends State<LocationCreatePage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController thumbnailController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController userController = TextEditingController();

  DateTime? selectedDate;

  // DATE PICKER
  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: DateTime(now.year - 2),
      lastDate: DateTime(now.year + 5),
    );

    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  // SAVE LOCATION
  void _save() {
    if (!_formKey.currentState!.validate()) return;

    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Bitte ein Datum auswählen")),
      );
      return;
    }

    // 👇 HIER erstellst du das Objekt (LocationFull)
    final createdLocation = LocationFull(
      id: 'tmp-${DateTime.now().millisecondsSinceEpoch}',
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      date: "_pickDate().toString()",
      address: "${descriptionController.text.trim()}222",
      position: LatLng(widget.point.latitude, widget.point.longitude),
      thumbnailUrl: [imageController.text.trim()].single,
      imageUrl: [imageController.text.trim()].single,
      user: userController.text.trim(),
    );

    // Rückgabe an vorherige Seite
    final LocationBase locationBase = LocationBase(
      id: createdLocation.id,
      title: createdLocation.title,
      description: createdLocation.description,
      date: createdLocation.date,
      position: createdLocation.position,
      thumbnailUrl: createdLocation.thumbnailUrl,
    );
    Navigator.pop(context, locationBase);
  }

  @override
  Widget build(BuildContext context) {
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
                      selectedDate == null
                          ? "Kein Datum gewählt"
                          : "Datum: ${selectedDate!.day}.${selectedDate!.month}.${selectedDate!.year}",
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
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Position:\nLatitude: ${widget.point.latitude}\nLongitude: ${widget.point.longitude}",
                  style: const TextStyle(fontSize: 16),
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
