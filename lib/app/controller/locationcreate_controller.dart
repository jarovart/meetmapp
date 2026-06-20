import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:casttime/app/model/exception/app_exception.dart';
import 'package:casttime/app/model/request/createlocation_request.dart';
import 'package:casttime/app/model/response/image_response.dart';
import 'package:casttime/app/model/response/locationbase_response.dart';
import 'package:casttime/app/model/response/usermyprofile_response.dart';
import 'package:casttime/app/service/image_service.dart';
import 'package:casttime/app/service/location_service.dart';

class LocationCreateController extends ChangeNotifier {
  final LatLng point;
  final String? geoAddress;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _thumbnailController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _userController = TextEditingController();

  final picker = ImagePicker();
  final List<Uint8List> _images = [];
  bool _uploading = false;
  Object? _error;
  String? _initialAddress;
  DateTime? _selectedStartDateTime;
  DateTime? _selectedEndDateTime;
  UserMyProfileResponse? _myProfile;
  LocationBaseResponse? _locationBase;

  LocationCreateController({required this.point, this.geoAddress}) {
    _initialAddress = geoAddress ?? '';
    addressController.text = _initialAddress!;
    debugPrint(
      'Receivedlocacreate lat: ${point.latitude}, lng: ${point.longitude}, geoAddress: $geoAddress',
    );
  }

  bool get uploading => _uploading;
  bool get hasError => _error != null;
  Object? get error => _error;
  String? get initialAddress => _initialAddress;
  DateTime? get selectedStartDateTime => _selectedStartDateTime;
  DateTime? get selectedEndDateTime => _selectedEndDateTime;
  bool get loggedIn => _myProfile != null;
  UserMyProfileResponse? get myProfile => _myProfile;
  List<Uint8List> get images => _images;
  LocationBaseResponse? get locationBase => _locationBase;
  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get titleController => _titleController;
  TextEditingController get descriptionController => _descriptionController;
  TextEditingController get addressController => _addressController;
  TextEditingController get thumbnailController => _thumbnailController;
  TextEditingController get imageController => _imageController;
  TextEditingController get userController => _userController;

  set myProfile(UserMyProfileResponse? myProfile) {
    _myProfile = myProfile;
  }

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

  void removeImage(int index) {
    _images.removeAt(index);
    notifyListeners();
  }

  Future<bool> saveLocation() async {
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

    try {
      final createdLocation = CreateLocationRequest(
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        address: addressController.text.trim(),
        creationDateTime: DateTime.now(),
        startDateTime: selectedStartDateTime!,
        endDateTime: selectedEndDateTime!,
        position: LatLng(point.latitude, point.longitude),
        createdUsername: _myProfile!.username,
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

      _locationBase = locationBase;
      return true;
    } catch (e, st) {
      debugPrint('Error while uploading location: $e');
      debugPrintStack(stackTrace: st);

      _error = e;
    } finally {
      _uploading = false;
      notifyListeners();
    }
    return false;
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

      _images.add(compressed);
    } catch (e) {
      debugPrint("Add image failed: $e");
      _error = e;
    } finally {
      _uploading = false;
      notifyListeners();
    }
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

  void reorderImages(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;
    final img = _images.removeAt(oldIndex);
    _images.insert(newIndex, img);
    notifyListeners();
  }

  String getPositionForCopyClipboard() {
    return "${point.latitude}, ${point.longitude}";
  }
}
