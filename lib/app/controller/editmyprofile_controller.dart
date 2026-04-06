import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:meetmaap/app/model/request/editmyprofile_request.dart';
import 'package:meetmaap/app/model/response/usermyprofile_response.dart';
import 'package:meetmaap/app/repository/authentication_repository.dart';
import 'package:meetmaap/app/repository/user_repository.dart';
import 'package:meetmaap/app/service/user_service.dart';
import 'package:meetmaap/app/view/util/app_errormessage_mapper.dart';

class EditMyProfileController extends ChangeNotifier {
  bool _isLoading = false;
  bool _uploading = false;
  String? _errorMessage;
  bool _saving = false;
  UserMyProfileResponse? _myProfile;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameCtrl = TextEditingController();
  final TextEditingController _lastNameCtrl = TextEditingController();
  final TextEditingController _aboutMeCtrl = TextEditingController();
  final _imagePicker = ImagePicker();
  Uint8List? _selectedProfileImage; // neues lokales Bild
  bool _removeCurrentProfileImage = false; // altes Bild bewusst löschen
  String? _currentProfileImageUrl; // bestehendes Bild vom Server

  bool get isLoading => _isLoading;
  bool get isUploading => _uploading;
  bool get isSaving => _saving;
  bool get hasError => _errorMessage != null && _errorMessage!.isNotEmpty;
  String? get errorMessage => _errorMessage;
  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get firstNameCtrl => _firstNameCtrl;
  TextEditingController get lastNameCtrl => _lastNameCtrl;
  TextEditingController get aboutMeCtrl => _aboutMeCtrl;
  ImageProvider? get previewImageProvider => _getPreviewImageProvider();

  Uint8List? get selectedProfileImageBytes => _selectedProfileImage;
  bool get removeCurrentProfileImage => _removeCurrentProfileImage;
  String? get currentProfileImageUrl => _currentProfileImageUrl;

  void setCurrentProfileImageUrl(String? url) {
    _currentProfileImageUrl = url;
  }

  Future<void> load({int? userId}) async {
    if (_isLoading) return;
    if (userId == null) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      if (!(await AuthRepository.isLoggedIn())) {
        throw Exception("Not logged in");
      }
      final myUserId = await AuthRepository.getUserId();

      if (myUserId != null && myUserId == userId) {
        _myProfile = await UserRepository.fetchMyProfile();
        setCurrentProfileImageUrl(_myProfile?.profileImage?.imageUrl ?? '');
      } else {
        throw Exception("Can not edit profile of other user");
      }
      _initEditFields();
    } catch (e, st) {
      debugPrint('load editprofile failed: $e');
      debugPrintStack(stackTrace: st);

      _errorMessage = AppErrorMapper.toUserMessage(
        e,
        fallback: 'Profil konnte nicht geladen werden.',
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveProfile() async {
    if (isSaving) return;
    if (!_formKey.currentState!.validate()) return;
    _saving = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _updateMyProfile();
    } catch (e, st) {
      debugPrint('saveProfile failed: $e');
      debugPrintStack(stackTrace: st);

      _errorMessage = AppErrorMapper.toUserMessage(
        e,
        fallback: 'Profil konnte nicht gespeichert werden.',
      );
    } finally {
      _saving = false;
      notifyListeners();
    }
  }

  Future<void> pickProfileImage(BuildContext context) async {
    final picked = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    if (picked == null) return;
    if (!context.mounted) return;

    final screen = MediaQuery.of(context).size;
    final cropperWidth = screen.width * 0.85;
    final cropperHeight = screen.height * 0.55;

    final CroppedFile? cropped = await ImageCropper().cropImage(
      sourcePath: picked.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Profilbild zuschneiden',
          lockAspectRatio: true,
          hideBottomControls: false,
        ),
        IOSUiSettings(
          title: 'Profilbild zuschneiden',
          aspectRatioLockEnabled: true,
        ),
        if (kIsWeb)
          WebUiSettings(
            context: context, // nur falls du Web nutzt
            presentStyle: WebPresentStyle.dialog,
            size: CropperSize(
              width: cropperWidth.clamp(280, 520).toInt(),
              height: cropperHeight.clamp(320, 700).toInt(),
            ),
            viewwMode: WebViewMode.mode_1,
            dragMode: WebDragMode.move,
            zoomable: true,
            scalable: true,
            movable: true,
            zoomOnTouch: true,
            zoomOnWheel: true,
          ),
      ],
    );

    if (cropped == null) return;

    _uploading = true;
    notifyListeners();
    try {
      final bytes = await cropped.readAsBytes(); //or picked v
      _selectedProfileImage = await compute(_compressImage, bytes);
      _removeCurrentProfileImage = false;
    } catch (e, st) {
      debugPrint('Failed to process image: $e');
      debugPrintStack(stackTrace: st);

      _errorMessage = AppErrorMapper.toUserMessage(
        e,
        fallback: 'Bild konnte nicht verarbeitet werden.',
      );
    } finally {
      _uploading = false;
      notifyListeners();
    }
  }

  void removeProfileImage() {
    _selectedProfileImage = null;
    _removeCurrentProfileImage = true;
    notifyListeners();
  }

  Future<void> _updateMyProfile() async {
    if (_myProfile == null) throw Exception("Not my profile");

    final profileRequest = EditMyProfileRequest(
      firstName: firstNameCtrl.text.trim(),
      lastName: lastNameCtrl.text.trim(),
      aboutMe: aboutMeCtrl.text.trim(),
    );

    final updatedProfile = await UserService.updateMyProfile(
      profileRequest,
      _selectedProfileImage,
      _removeCurrentProfileImage,
    );
    _myProfile = updatedProfile;
    _currentProfileImageUrl = _myProfile?.profileImage?.imageUrl ?? '';
    _removeCurrentProfileImage = false;
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _aboutMeCtrl.dispose();
    super.dispose();
  }

  void _initEditFields() {
    _firstNameCtrl.text = _myProfile?.firstName ?? "";
    _lastNameCtrl.text = _myProfile?.lastName ?? "";
    _aboutMeCtrl.text = _myProfile?.aboutMe ?? "";
  }

  ImageProvider? _getPreviewImageProvider() {
    if (_selectedProfileImage != null) {
      return MemoryImage(_selectedProfileImage!);
    } else if (_removeCurrentProfileImage) {
      return null;
    } else if (_currentProfileImageUrl != null &&
        _currentProfileImageUrl!.isNotEmpty) {
      return NetworkImage(_currentProfileImageUrl!);
    } else {
      return null;
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
}
