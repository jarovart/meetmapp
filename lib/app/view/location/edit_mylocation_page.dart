import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:meetmaap/app/config/route_config.dart';
import 'package:meetmaap/app/controller/edit_mylocation_controller.dart';
import 'package:meetmaap/app/view/util/editrow.dart';
import 'package:meetmaap/app/view/util/infocard.dart';
import 'package:meetmaap/app/view/util/inforow.dart';
import 'package:provider/provider.dart';

class EditMyLocationPage extends StatelessWidget {
  const EditMyLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final editController = context.watch<EditMyLocationController>();

    if (!editController.isOwnerOfProfile) {
      return Scaffold(
        appBar: AppBar(title: const Text("Location bearbeiten")),
        body: Center(
          child: Text('Du hast keine Berechtigung für diese Aktion.'),
        ),
      );
    }

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text("Location bearbeiten"),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: OutlinedButton.icon(
                  onPressed: editController.isSaving
                      ? null
                      : () async {
                          await editController.saveLocation();

                          if (context.mounted && !editController.hasError) {
                            GoRouter.of(context).pop(true);
                          }
                        },
                  label: editController.isSaving
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text("Speichern"),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: editController.formKey,
              child: ListView(
                children: [
                  if (editController.hasError) ...[
                    Center(
                      child: Text(
                        editController.errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],

                  //buildProfileImageSection(context, editController),
                  InfoCard(
                    child: Column(
                      children: [
                        EditRow(
                          icon: Icons.title_outlined,
                          child: TextFormField(
                            controller: editController.titleCtrl,
                            decoration: const InputDecoration(
                              labelText: "Title",
                            ),
                          ),
                        ),
                        const Divider(height: 24),
                        EditRow(
                          icon: Icons.description_outlined,
                          child: TextFormField(
                            controller: editController.descriptionCtrl,
                            decoration: const InputDecoration(
                              labelText: "Description",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  InfoCard(
                    child: Column(
                      children: [
                        InfoRow(
                          icon: Icons.event_available_outlined,
                          label: 'Start',
                          value: DateFormat(
                            'dd.MM.yyyy HH:mm',
                          ).format(editController.selectedStartDateTime!),
                          onTap: () => _pickDateTime(
                            editController.selectedStartDateTime,
                            (dt) => editController.selectedStartDateTime = dt,
                            context,
                          ),
                        ),
                        const Divider(height: 24),
                        InfoRow(
                          icon: Icons.event_busy_outlined,
                          label: 'Ende',
                          value: DateFormat(
                            'dd.MM.yyyy HH:mm',
                          ).format(editController.selectedEndDateTime!),
                          onTap: () => _pickDateTime(
                            editController.selectedEndDateTime,
                            (dt) => editController.selectedEndDateTime = dt,
                            context,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  InfoCard(
                    child: Column(
                      children: [
                        EditRow(
                          icon: Icons.location_on_outlined,
                          child: TextFormField(
                            controller: editController.addressCtrl,
                            decoration: InputDecoration(
                              labelText: "Adresse",
                              suffixIcon: IconButton(
                                tooltip: "Adresse zurücksetzen",
                                icon: Icon(Icons.undo),
                                onPressed: editController.resetAddress,
                              ),
                            ),
                          ),
                        ),
                        const Divider(height: 24),
                        InfoRow(
                          icon: Icons.location_on_outlined,
                          label: "Position (lat, lng)",
                          value: editController.positionAsString,
                          onTap: () async {
                            final LatLng? position = await context.push(
                              RouteConfig.mapUrl,
                              extra: editController.location,
                            );
                            if (position != null) {
                              editController.selectedPosition = position;
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  InfoCard(
                    title: "Bilder",
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        ReorderableListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: editController.images.length,
                          onReorder: editController.reorderImages,
                          itemBuilder: (context, index) {
                            return Card(
                              key: ValueKey(editController.images[index]),
                              child: ListTile(
                                onTap: () => "",
                                leading: Image.memory(
                                  editController.images[index].bytes,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                                title: Text("Bild ${index + 1}"),
                                subtitle: index == 0 ? Text("Thumbnail") : null,
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () =>
                                      editController.removeImage(index),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        OutlinedButton.icon(
                          onPressed: editController.addImage,
                          icon: const Icon(Icons.add_a_photo),
                          label: const Text("Bild hinzufügen"),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (editController.isUploading || editController.isLoading)
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

  void save(
    BuildContext context,
    EditMyLocationController editController,
  ) async {
    final saved = await editController.saveLocation();
    if (saved && context.mounted && !editController.hasError) {
      GoRouter.of(context).pop(true);
    }
  }
}
