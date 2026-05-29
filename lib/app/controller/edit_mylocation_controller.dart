import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:meetmaap/app/controller/auth_controller.dart';
import 'package:meetmaap/app/model/exception/app_exception.dart';
import 'package:meetmaap/app/model/request/updatemylocation_request.dart';
import 'package:meetmaap/app/model/request/image_request.dart';
import 'package:meetmaap/app/model/response/locationfull_response.dart';
import 'package:meetmaap/app/model/response/usermyprofile_response.dart';
import 'package:meetmaap/app/service/location_service.dart';

class EditMyLocationController extends ChangeNotifier {
  final AuthController authController;

  EditMyLocationController({required this.authController});

  final picker = ImagePicker();
  bool _isLoading = false;
  bool _uploading = false;
  Object? _error;
  bool _isSaving = false;
  UserMyProfileResponse? _myProfile;
  LocationFullResponse? _location;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _descriptionCtrl = TextEditingController();

  DateTime? _selectedStartDateTime;
  DateTime? _selectedEndDateTime;

  final TextEditingController _addressCtrl = TextEditingController();
  LatLng? _position;

  List<ImageRequest> _images = [];

  // ─────────────────────────────────────────────
  // STATE
  // ─────────────────────────────────────────────
  bool get isLoading => _isLoading;
  bool get isOwnerOfProfile => true;

  bool get isSaving => _isSaving;

  bool get hasError => _error != null;

  bool get isUploading => _uploading;

  Object? get error => _error;

  LocationFullResponse get location => _location!;

  GlobalKey<FormState> get formKey => _formKey;

  TextEditingController get titleCtrl => _titleCtrl;
  TextEditingController get descriptionCtrl => _descriptionCtrl;

  DateTime? get selectedStartDateTime => _selectedStartDateTime;
  DateTime? get selectedEndDateTime => _selectedEndDateTime;

  TextEditingController get addressCtrl => _addressCtrl;
  LatLng get position => _position!;
  String get positionAsString => _position != null
      ? 'lat: ${_position!.latitude}, lng: ${_position!.longitude}'
      : '';

  List<ImageRequest> get images => _images;

  // ─────────────────────────────────────────────
  // STATE MUTATION
  // ─────────────────────────────────────────────
  set selectedStartDateTime(DateTime? value) {
    _error = null;
    _selectedStartDateTime = value;
    notifyListeners();
  }

  set selectedEndDateTime(DateTime? value) {
    _error = null;
    _selectedEndDateTime = value;
    notifyListeners();
  }

  set selectedPosition(LatLng value) {
    _error = null;
    _position = value;
    notifyListeners();
  }

  // ─────────────────────────────────────────────
  // FUNCTIONS
  // ─────────────────────────────────────────────
  Future<void> load(String? locationId, LocationFullResponse? location) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      if (!(authController.isLoggedIn)) throw NotLoggedInException();
      if (location == null) {
        final id = int.tryParse(locationId ?? '');
        if (id == null) throw InvalidLocationIdException();

        _location = await LocationService.fetchFullLocation(id);
      } else {
        _location = location;
      }
      _myProfile = authController.myProfile;
      if (_myProfile?.username != _location?.createdUsername) {
        throw NotLocationOwnerNoEditException();
      }

      await _initEditFields();
    } catch (e, st) {
      debugPrint('load editprofile failed: $e');
      debugPrintStack(stackTrace: st);

      _error = e;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    super.dispose();
  }

  Future<void> _initEditFields() async {
    _titleCtrl.text = _location?.title ?? '';
    _descriptionCtrl.text = _location?.description ?? '';
    _selectedStartDateTime = location.startDateTime;
    _selectedEndDateTime = location.endDateTime;
    _addressCtrl.text = location.address;
    _position = location.position;
    await _loadImages();
    //_lastNameCtrl.text = _myProfile?.lastName ?? '';
    //_aboutMeCtrl.text = _myProfile?.aboutMe ?? '';
  }

  Future<void> _loadImages() async {
    _images.clear();
    int sortIndex = 0;
    for (final image in location.images) {
      final response = await http.get(Uri.parse(image.imageUrl));

      if (response.statusCode == 200) {
        _images.add(
          ImageRequest.existing(
            id: image.id,
            bytes: response.bodyBytes,
            sortIndex: sortIndex++,
          ),
        );
      }
    }
  }

  void resetAddress() {
    _addressCtrl.text = location.address;
    notifyListeners();
  }

  Future<void> addImage() async {
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    if (picked == null) return;

    _uploading = true;
    notifyListeners();
    try {
      final bytes = await picked.readAsBytes();
      final compressed = await compute(_compressImage, bytes);

      _images.add(
        ImageRequest.newImage(bytes: compressed, sortIndex: _images.length),
      );
    } catch (e) {
      debugPrint("Add image failed: $e");

      _error = e;
    } finally {
      _uploading = false;
      notifyListeners();
    }
  }

  void reorderImages(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;
    final img = _images.removeAt(oldIndex);
    _images.insert(newIndex, img);
    notifyListeners();
  }

  void removeImage(int index) {
    _images.removeAt(index);
    notifyListeners();
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

  List<ImageRequest> _imagesWithUpdatedSortIndex() {
    return _images.asMap().entries.map((entry) {
      return entry.value.copyWithSortIndex(entry.key);
    }).toList();
  }

  // ─────────────────────────────────────────────
  // API CALL BEHAVIOR
  // ─────────────────────────────────────────────

  Future<bool> saveLocation() async {
    try {
      if (!_formKey.currentState!.validate()) {
        throw FillAllFieldsException();
      }

      if (selectedStartDateTime == null || selectedEndDateTime == null) {
        throw InfoChooseStartAndEnddateException();
      }
      if (selectedEndDateTime!.isBefore(selectedStartDateTime!)) {
        throw InfoEnddateBeforeStartdateException();
      }

      _uploading = true;
      notifyListeners();

      final orderedImages = _imagesWithUpdatedSortIndex();

      final updateMyLocationRequest = UpdateMyLocationRequest(
        id: location.id,
        title: titleCtrl.text.trim(),
        description: descriptionCtrl.text.trim(),
        address: addressCtrl.text.trim(),
        position: LatLng(position.latitude, position.longitude),
        startDateTime: selectedStartDateTime!,
        endDateTime: selectedEndDateTime!,
        imageRequests: orderedImages,
      );

      final locationFull = await LocationService.updateMyLocation(
        updateMyLocationRequest,
      );
      _location = locationFull;

      return true;
    } catch (e, st) {
      debugPrint('Error while updating location: $e');
      debugPrintStack(stackTrace: st);

      _error = e;
    } finally {
      _uploading = false;
      notifyListeners();
    }
    return false;
  }
}
