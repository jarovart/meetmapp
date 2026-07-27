import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:casttime/app/model/exception/app_exception.dart';
import 'package:casttime/app/model/request/updatemyprofile_request.dart';
import 'package:casttime/app/model/response/usermyprofile_response.dart';
import 'package:casttime/app/service/authentication_service.dart';
import 'package:casttime/app/service/user_service.dart';

class EditMyProfileController extends ChangeNotifier {
  String? _username;
  UserMyProfileResponse? _myProfile;

  EditMyProfileController(this._username);

  bool _isLoading = false;
  bool uploading = false;
  Object? error;
  bool _saving = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameCtrl = TextEditingController();
  final TextEditingController _lastNameCtrl = TextEditingController();
  final TextEditingController _aboutMeCtrl = TextEditingController();
  final _imagePicker = ImagePicker();
  Uint8List? _selectedProfileImage; // neues lokales Bild
  bool removeCurrentProfileImage = false; // altes Bild bewusst löschen
  String? _currentProfileImageUrl; // bestehendes Bild vom Server

  bool get isLoading => _isLoading;
  bool get isSaving => _saving;
  bool get hasError => error != null;
  ImagePicker get imagePicker => _imagePicker;
  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get firstNameCtrl => _firstNameCtrl;
  TextEditingController get lastNameCtrl => _lastNameCtrl;
  TextEditingController get aboutMeCtrl => _aboutMeCtrl;
  ImageProvider? get previewImageProvider => _getPreviewImageProvider();

  Uint8List? get selectedProfileImageBytes => _selectedProfileImage;
  String? get currentProfileImageUrl => _currentProfileImageUrl;
  String get username => _username ?? 'CT';

  set selectedProfileImage(Uint8List value) => _selectedProfileImage = value;

  bool isOwnerOfProfile() {
    return _myProfile != null &&
        _username != null &&
        _myProfile!.username == _username;
  }

  void setCurrentProfileImageUrl(String? url) {
    _currentProfileImageUrl = url;
  }

  Future<void> load() async {
    if (_isLoading) return;
    _isLoading = true;
    error = null;
    notifyListeners();

    try {
      if (!(await AuthService.isLoggedIn())) throw NotLoggedInException();
      if ((await AuthService.getUsername() != _username)) return;

      _myProfile = await AuthService.fetchMyProfile();
      setCurrentProfileImageUrl(_myProfile?.profileImage?.imageUrl ?? '');
      _initEditFields();
    } catch (e, st) {
      debugPrint('load editprofile failed: $e');
      debugPrintStack(stackTrace: st);

      error = e;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void callNotifier() {
    notifyListeners();
  }

  Future<void> saveProfile() async {
    if (isSaving) return;
    if (!_formKey.currentState!.validate()) return;
    _saving = true;
    error = null;
    notifyListeners();

    try {
      await _updateMyProfile();
    } catch (e, st) {
      debugPrint('saveProfile failed: $e');
      debugPrintStack(stackTrace: st);

      error = e;
    } finally {
      _saving = false;
      notifyListeners();
    }
  }

  void removeProfileImage() {
    _selectedProfileImage = null;
    removeCurrentProfileImage = true;
    notifyListeners();
  }

  Future<void> _updateMyProfile() async {
    final profileRequest = UpdateMyProfileRequest(
      firstName: firstNameCtrl.text.trim(),
      lastName: lastNameCtrl.text.trim(),
      aboutMe: aboutMeCtrl.text.trim(),
      removeProfileImage: removeCurrentProfileImage,
    );

    final updatedProfile = await UserService.updateMyProfile(
      profileRequest,
      _selectedProfileImage,
    );
    _myProfile = updatedProfile;
    _currentProfileImageUrl = _myProfile?.profileImage?.imageUrl ?? '';
    removeCurrentProfileImage = false;
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _aboutMeCtrl.dispose();
    super.dispose();
  }

  void _initEditFields() {
    _firstNameCtrl.text = _myProfile?.firstName ?? '';
    _lastNameCtrl.text = _myProfile?.lastName ?? '';
    _aboutMeCtrl.text = _myProfile?.aboutMe ?? '';
  }

  ImageProvider? _getPreviewImageProvider() {
    if (_selectedProfileImage != null) {
      return MemoryImage(_selectedProfileImage!);
    } else if (removeCurrentProfileImage) {
      return null;
    } else if (_currentProfileImageUrl != null &&
        _currentProfileImageUrl!.isNotEmpty) {
      return NetworkImage(_currentProfileImageUrl!);
    } else {
      return null;
    }
  }

  static Uint8List compressImage(Uint8List bytes) {
    final image = img.decodeImage(bytes);
    if (image == null) return bytes;

    final resized = img.copyResize(
      image,
      width: image.width > 1280 ? 1280 : image.width,
    );

    return Uint8List.fromList(img.encodeJpg(resized, quality: 80));
  }
}
