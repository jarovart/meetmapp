import 'package:flutter/material.dart';
import 'package:meetmaap/app/model/responses/usermyprofile_response.dart';
import 'package:meetmaap/app/repository/authentication_repository.dart';
import 'package:meetmaap/app/repository/user_repository.dart';

class EditMyProfileController extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  bool _saving = false;
  UserMyProfileResponse? _myProfile;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameCtrl = TextEditingController();
  final TextEditingController _lastNameCtrl = TextEditingController();
  final TextEditingController _aboutMeCtrl = TextEditingController();

  bool get isLoading => _isLoading;
  bool get isSaving => _saving;
  bool get hasError => _errorMessage != null && _errorMessage!.isNotEmpty;
  String? get errorMessage => _errorMessage;
  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get firstNameCtrl => _firstNameCtrl;
  TextEditingController get lastNameCtrl => _lastNameCtrl;
  TextEditingController get aboutMeCtrl => _aboutMeCtrl;

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
      } else {
        throw Exception("Can not edit profile of other user");
      }
      _initEditFields();
    } catch (e) {
      _errorMessage = e.toString();
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
    } catch (e) {
      debugPrint("Error on EditMyProfileController: $e");
      _errorMessage = e.toString();
    } finally {
      _saving = false;
      notifyListeners();
    }
  }

  Future<void> _updateMyProfile() async {
    if (_myProfile == null) throw Exception("Not my profile");

    final updatedProfile = await UserRepository.updateMyProfile(
      firstName: firstNameCtrl.text.trim(),
      lastName: lastNameCtrl.text.trim(),
      aboutMe: aboutMeCtrl.text.trim(),
    );
    _myProfile = updatedProfile;
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
}
