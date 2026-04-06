import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:meetmaap/app/model/response/image_response.dart';
import 'package:meetmaap/app/repository/authentication_repository.dart';
import 'package:meetmaap/app/service/image_service.dart';
import 'package:meetmaap/app/service/location_service.dart';
import 'package:meetmaap/app/model/exception/exception_message.dart';
import 'package:meetmaap/app/model/response/locationbase_response.dart';
import 'package:meetmaap/app/model/request/createlocation_request.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;

class LocationCreatePage extends StatefulWidget {
  final LatLng point;
  final String? geoAddress;

  const LocationCreatePage({super.key, required this.point, this.geoAddress});

  @override
  State<LocationCreatePage> createState() => _LocationCreatePageState();
}

class _LocationCreatePageState extends State<LocationCreatePage> {
  final _formKey = GlobalKey<FormState>();
  bool _checkingAuth = true;

  // Controllers
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController thumbnailController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController userController = TextEditingController();
  final picker = ImagePicker();
  final List<Uint8List> _images = [];
  bool _uploading = false;
  DateTime? selectedStartDateTime;
  DateTime? selectedEndDateTime;
  String? _userName;
  String? _initialAddress;

  @override
  void initState() {
    super.initState();
    _checkAuth();
    _initialAddress = widget.geoAddress ?? '';
    addressController.text = _initialAddress!;
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
    final userName = await AuthRepository.getUsername();
    // User ist jetzt sicher eingeloggt
    setState(() => _checkingAuth = false);
    setState(() => _userName = userName);
  }

  // DATE PICKER
  Future<void> _pickDateTime({
    required DateTime? initial,
    required ValueChanged<DateTime> onSelected,
  }) async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: initial ?? now,
      firstDate: DateTime(now.year - 2),
      lastDate: DateTime(now.year + 5),
    );

    if (date == null || !mounted) return;

    // 2️⃣ Uhrzeit wählen
    final time = await showTimePicker(
      context: context,
      initialTime: initial != null
          ? TimeOfDay.fromDateTime(initial)
          : TimeOfDay.fromDateTime(now),
    );

    if (time == null) return;
    onSelected(
      DateTime(date.year, date.month, date.day, time.hour, time.minute),
    );
  }

  // SAVE LOCATION
  void _save() async {
    if (!_formKey.currentState!.validate()) return;

    if (selectedStartDateTime == null ||
        selectedEndDateTime == null ||
        selectedEndDateTime!.isBefore(selectedStartDateTime!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Bitte ein Start- und ein Enddatum auswählen und Enddatum darf nicht vor Startdatum sein.",
          ),
        ),
      );
      return;
    }

    setState(() => _uploading = true);
    // Rückgabe an vorherige Seite
    try {
      // 👇 HIER erstellst du das Objekt (LocationFull)
      final createdLocation = CreateLocationRequest(
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        address: addressController.text.trim(),
        creationDateTime: DateTime.now(),
        startDateTime: selectedStartDateTime!,
        endDateTime: selectedEndDateTime!,
        position: LatLng(widget.point.latitude, widget.point.longitude),
        createdUsername: _userName!,
      );

      LocationBaseResponse locationBase = await LocationService.uploadLocation(
        createdLocation,
      );

      List<ImageResponse> imageResponses = [];

      if (_images.isNotEmpty) {
        imageResponses = await ImageService.uploadImages(
          _images.toList(),
          locationBase.id,
        );
        ImageResponse thumbnail = imageResponses.first;
        locationBase = await ImageService.patchLocationThumbnail(
          locationBase.id,
          thumbnail.id,
        );
      }

      if (!mounted) return;
      context.pop(locationBase);
    } catch (e) {
      debugPrint("Fehler beim Hochladen der Location: $e");
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Fehler beim Hochladen der Location: $e")),
      );
    } finally {
      if (mounted) setState(() => _uploading = false);
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

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(title: Text("Location erstellen als $_userName")),

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
                    controller: descriptionController,
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
                    controller: addressController,
                    decoration: InputDecoration(
                      labelText: "Adresse eingeben",
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        tooltip: "Adresse zurücksetzen",
                        icon: const Icon(Icons.undo),
                        onPressed: () {
                          addressController.text = _initialAddress!;
                        },
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
                          selectedStartDateTime == null
                              ? "Kein Startdatum gewählt"
                              : "Datum: ${selectedStartDateTime!.day}.${selectedStartDateTime!.month}.${selectedStartDateTime!.year} ${selectedStartDateTime!.hour}:${selectedStartDateTime!.minute}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => _pickDateTime(
                          initial: selectedStartDateTime,
                          onSelected: (dt) {
                            setState(() => selectedStartDateTime = dt);
                          },
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
                          selectedEndDateTime == null
                              ? "Kein Enddatum gewählt"
                              : "Datum: ${selectedEndDateTime!.day}.${selectedEndDateTime!.month}.${selectedEndDateTime!.year} ${selectedEndDateTime!.hour}:${selectedEndDateTime!.minute}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => _pickDateTime(
                          initial: selectedEndDateTime,
                          onSelected: (dt) {
                            setState(() => selectedEndDateTime = dt);
                          },
                        ),
                        child: const Text("Enddatum wählen"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

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
                    itemCount: _images.length,
                    onReorder: _reorderImages,
                    itemBuilder: (context, index) {
                      return Card(
                        key: ValueKey(_images[index]),
                        child: ListTile(
                          onTap: () => "",
                          leading: Image.memory(
                            _images[index],
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                          title: Text("Bild ${index + 1}"),
                          subtitle: index == 0 ? Text("Thumbnail") : null,
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() => _images.removeAt(index));
                            },
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 8),

                  OutlinedButton.icon(
                    onPressed: _addImage,
                    icon: const Icon(Icons.add_a_photo),
                    label: const Text("Bild hinzufügen"),
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
        ),
        // 🔥 Overlay Loading Layer
        if (_uploading)
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

  void _reorderImages(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex--;
      final img = _images.removeAt(oldIndex);
      _images.insert(newIndex, img);
    });
  }

  Future<void> _addImage() async {
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    if (picked == null) return;

    setState(() => _uploading = true);
    try {
      //final original = File(picked.path);
      //final compressed = await compressImage(original);
      final bytes = await picked.readAsBytes();
      final compressed = await compute(_compressImage, bytes);

      if (!mounted) return;
      setState(() => _images.add(compressed));
    } catch (e) {
      debugPrint("Add image failed: $e");
    } finally {
      if (mounted) setState(() => _uploading = false);
    }
  }

  Future<File?> pickImage() async {
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100, // wir komprimieren selbst
    );

    if (picked == null) return null;
    return File(picked.path);
  }

  Future<XFile> compressImage(File file) async {
    final dir = await getTemporaryDirectory();
    final targetPath =
        '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

    final compressed = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 80, // 70–85 = optimal
      minWidth: 1280, // mobile-friendly
      format: CompressFormat.jpeg,
    );

    return compressed!;
  }

  static Uint8List _compressImage(Uint8List bytes) {
    final image = img.decodeImage(bytes);
    if (image == null) return bytes;

    final resized = img.copyResize(
      image,
      width: image.width > 1280 ? 1280 : image.width,
    );

    return Uint8List.fromList(img.encodeJpg(resized, quality: 80));
  }

  String addressLabel(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Adresse eingeben';
    }
    return value;
  }
}
