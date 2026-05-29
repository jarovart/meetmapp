import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:meetmaap/app/controller/auth_controller.dart';
import 'package:meetmaap/app/controller/locationcreate_controller.dart';
import 'package:meetmaap/app/model/exception/exception_message.dart';
import 'package:meetmaap/app/view/util/app_errormessage_mapper.dart';
import 'package:meetmaap/extensions/l10n_extension.dart';

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
    final formatter = DateFormat('dd.MM.yyyy HH:mm');
    final l10n = context.l10n;

    if (!locationCreateController.loggedIn) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.createLocation)),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
              l10n.createLocationAs(
                locationCreateController.myProfile!.username,
              ),
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
                    decoration: InputDecoration(
                      labelText: l10n.enterTitle,
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) =>
                        v == null || v.isEmpty ? l10n.titleNotEmpty : null,
                  ),
                  const SizedBox(height: 16),

                  // --- DESCRIPTION ---
                  TextFormField(
                    controller: locationCreateController.descriptionController,
                    decoration: InputDecoration(
                      labelText: l10n.enterDescription,
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) =>
                        v == null || v.isEmpty ? l10n.missingDescription : null,
                  ),
                  const SizedBox(height: 16),

                  // --- ADDRESS ---
                  TextFormField(
                    controller: locationCreateController.addressController,
                    decoration: InputDecoration(
                      labelText: l10n.enterAddress,
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        tooltip: l10n.resetAddress,
                        icon: const Icon(Icons.undo),
                        onPressed: () =>
                            locationCreateController.addressController.text =
                                locationCreateController.initialAddress!,
                      ),
                    ),
                    validator: (v) =>
                        v == null || v.isEmpty ? l10n.missingAddress : null,
                  ),
                  const SizedBox(height: 16),

                  // --- StartDATE ---
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          locationCreateController.selectedStartDateTime == null
                              ? l10n.noChosedStartdate
                              : l10n.displayStartdate(
                                  formatter.format(
                                    locationCreateController
                                        .selectedStartDateTime!,
                                  ),
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
                        child: Text(l10n.chooseStartdate),
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
                              ? l10n.noChosedEnddate
                              : l10n.displayEnddate(
                                  formatter.format(
                                    locationCreateController
                                        .selectedEndDateTime!,
                                  ),
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
                        child: Text(l10n.chooseEnddate),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  if (locationCreateController.hasError)
                    Center(
                      child: Text(
                        AppErrorMapper.toUserMessage(
                          locationCreateController.error!,
                          l10n,
                          fallback: l10n.errorCreateLocation,
                        ),
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
                          leading: Image.memory(
                            locationCreateController.images[index],
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                          title: Text(l10n.imageNumber(index + 1)),
                          subtitle: index == 0 ? Text(l10n.thumbnail) : null,
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
                    label: Text(l10n.addImage),
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
                      ExceptionMessage.showInfo(context, l10n.positionCopied);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        getPositionAsString(context, locationCreateController),
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
                      child: Text(l10n.saveLocation),
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
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        l10n.loading,
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

  String getPositionAsString(
    BuildContext context,
    LocationCreateController controller,
  ) {
    final point = controller.point;
    return context.l10n.positionWithCoordinates(
      point.latitude,
      point.longitude,
    );
  }
}
