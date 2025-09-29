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

  static const String _defaultImage =
      "https://via.placeholder.com/150"; // Konstante statt Magic String

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      final newLocation = LocationData(
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        imageUrl: _imageController.text.trim().isNotEmpty
            ? _imageController.text.trim()
            : _defaultImage,
        position: widget.point,
      );
      Navigator.pop(context, newLocation);
    }
  }

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
              _buildTextField(
                controller: _nameController,
                label: "Name",
                validator: (v) =>
                v == null || v.isEmpty ? "Bitte eingeben" : null,
              ),
              _buildTextField(
                controller: _descriptionController,
                label: "Beschreibung",
              ),
              _buildTextField(
                controller: _imageController,
                label: "Bild-URL (optional)",
              ),
              const SizedBox(height: 20),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  /// Wiederverwendbares Textfeld
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      validator: validator,
    );
  }

  /// Buttons am Ende
  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Abbrechen"),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: _onSave,
          child: const Text("Speichern"),
        ),
      ],
    );
  }
}
