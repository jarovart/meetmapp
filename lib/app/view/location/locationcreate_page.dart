import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:meetmaap/app/controller/auth_controller.dart';
import 'package:meetmaap/app/controller/locationcreate_controller.dart';
import 'package:meetmaap/app/model/exception/exception_message.dart';

class LocationCreatePage extends StatelessWidget {
  final LocationCreateController locationCreateController;
  final AuthController authController;

  const LocationCreatePage({
    super.key,
    required this.locationCreateController,
    required this.authController,
  });

  @override
  Widget build(BuildContext context) {
    if (!locationCreateController.loggedIn) {
      return Scaffold(
        appBar: AppBar(title: const Text("Location erstellen")),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
              "Location erstellen als ${locationCreateController.myProfile!.username}",
            ),
          ),

          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: locationCreateController.formKey,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- TITLE ---
                  TextFormField(
                    controller: locationCreateController.titleController,
                    decoration: const InputDecoration(
                      labelText: "Titel eingeben",
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) => v == null || v.isEmpty
                        ? "Titel darf nicht leer sein"
                        : null,
                  ),
                  const SizedBox(height: 16),

                  // --- DESCRIPTION ---
                  TextFormField(
                    controller: locationCreateController.descriptionController,
                    decoration: const InputDecoration(
                      labelText: "Beschreibung eingeben",
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) =>
                        v == null || v.isEmpty ? "Beschreibung fehlt" : null,
                  ),
                  const SizedBox(height: 16),

                  // --- ADDRESS ---
                  TextFormField(
                    controller: locationCreateController.addressController,
                    decoration: InputDecoration(
                      labelText: "Adresse eingeben",
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        tooltip: "Adresse zurücksetzen",
                        icon: const Icon(Icons.undo),
                        onPressed: () =>
                            locationCreateController.addressController.text =
                                locationCreateController.initialAddress!,
                      ),
                    ),
                    validator: (v) =>
                        v == null || v.isEmpty ? "Adresse fehlt" : null,
                  ),
                  const SizedBox(height: 16),

                  // --- StartDATE ---
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          locationCreateController.selectedStartDateTime == null
                              ? "Kein Startdatum gewählt"
                              : locationCreateController.getDatumAsString(
                                  locationCreateController
                                      .selectedStartDateTime!,
                                ),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => _pickDateTime(
                          locationCreateController.selectedStartDateTime,
                          (dt) =>
                              locationCreateController.selectedStartDateTime =
                                  dt,
                          context,
                        ),
                        child: const Text("Startdatum wählen"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // --- StartDATE ---
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          locationCreateController.selectedEndDateTime == null
                              ? "Kein Enddatum gewählt"
                              : locationCreateController.getDatumAsString(
                                  locationCreateController.selectedEndDateTime!,
                                ),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => _pickDateTime(
                          locationCreateController.selectedEndDateTime,
                          (dt) =>
                              locationCreateController.selectedEndDateTime = dt,
                          context,
                        ),
                        child: const Text("Enddatum wählen"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  if (locationCreateController.hasError)
                    Center(
                      child: Text(
                        locationCreateController.error,
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ),
                  // --- IMAGE URL ---
                  const SizedBox(height: 16),
                  Text(
                    "Bilder",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),

                  ReorderableListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: locationCreateController.images.length,
                    onReorder: locationCreateController.reorderImages,
                    itemBuilder: (context, index) {
                      return Card(
                        key: ValueKey(locationCreateController.images[index]),
                        child: ListTile(
                          onTap: () => "",
                          leading: Image.memory(
                            locationCreateController.images[index],
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                          title: Text("Bild ${index + 1}"),
                          subtitle: index == 0 ? Text("Thumbnail") : null,
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () =>
                                locationCreateController.removeImage(index),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 8),

                  OutlinedButton.icon(
                    onPressed: locationCreateController.addImage,
                    icon: const Icon(Icons.add_a_photo),
                    label: const Text("Bild hinzufügen"),
                  ),

                  const SizedBox(height: 16),
                  // --- LOCATION PREVIEW ---
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(
                        ClipboardData(
                          text: locationCreateController
                              .getPositionForCopyClipboard(),
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
                        locationCreateController.getPositionAsString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // --- SAVE BUTTON ---
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => save(context),
                      child: const Text("Location speichern"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // 🔥 Overlay Loading Layer
        if (locationCreateController.uploading)
          Positioned.fill(
            child: AbsorbPointer(
              absorbing: true,
              child: Container(
                color: Colors.black.withValues(alpha: 0.35),
                child: const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Loading...",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 16),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  // DATE PICKER artem end
  Future<void> _pickDateTime(
    DateTime? initialDate,
    ValueChanged<DateTime> onSelected,
    BuildContext context,
  ) async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: initialDate ?? now,
      firstDate: DateTime(now.year - 2),
      lastDate: DateTime(now.year + 5),
    );

    if (date == null || !context.mounted) return;

    // 2️⃣ Uhrzeit wählen
    final time = await showTimePicker(
      context: context,
      initialTime: initialDate != null
          ? TimeOfDay.fromDateTime(initialDate)
          : TimeOfDay.fromDateTime(now),
    );

    if (time == null) return;
    onSelected(
      DateTime(date.year, date.month, date.day, time.hour, time.minute),
    );
  }

  void save(BuildContext context) async {
    final saved = await locationCreateController.saveLocation();
    if (saved) {
      final locationBase = locationCreateController.locationBase!;
      if (context.mounted) context.pop(locationBase);
    }
  }
}
