import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../models/location_data.dart';

class LocationFormPage extends StatefulWidget {
  final LatLng point;

  const LocationFormPage({super.key, required this.point});

  @override
  State<LocationFormPage> createState() => _LocationFormPageState();
}

class _LocationFormPageState extends State<LocationFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Neue Location")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Name"),
                validator: (value) =>
                value == null || value.isEmpty ? "Bitte eingeben" : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: "Beschreibung"),
              ),
              TextFormField(
                controller: _imageController,
                decoration: const InputDecoration(
                    labelText: "Bild-URL (optional)"),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Abbrechen"),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final newLocation = LocationData(
                          name: _nameController.text,
                          description: _descriptionController.text,
                          imageUrl: _imageController.text.isNotEmpty
                              ? _imageController.text
                              : "https://via.placeholder.com/150",
                          position: widget.point,
                        );
                        Navigator.pop(context, newLocation);
                      }
                    },
                    child: const Text("Speichern"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
