import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meetmaap/app/controller/auth_controller.dart';
import 'package:meetmaap/app/model/exception/app_exception.dart';
import 'package:meetmaap/app/model/response/locationbase_response.dart';
import 'package:meetmaap/app/model/response/locationfull_response.dart';
import 'package:meetmaap/app/model/response/usermyprofile_response.dart';
import 'package:meetmaap/app/service/location_service.dart';
import 'package:meetmaap/app/service/navigation_service.dart';
import 'package:meetmaap/app/view/util/app_errormessage_mapper.dart';

class LocationDetailsController extends ChangeNotifier {
  final AuthController authController;

  LocationDetailsController({required this.authController});
  // ─────────────────────────────────────────────
  // STATE
  // ─────────────────────────────────────────────
  bool _isLoading = false;
  String? _errorMessage;
  LocationBaseResponse? _locationBase;
  LocationFullResponse? _locationFull;
  UserMyProfileResponse? _myProfile;
  Timer? _toggleDebounce;

  bool _isLiked = false;
  bool _isJoined = false;
  int _likedUserCount = 0;
  int _joinedUserCount = 0;
  bool canOpenInNewPage = true;

  String get title => _locationFull?.title ?? _locationBase!.title;

  bool get hasError => _errorMessage != null && _errorMessage!.isNotEmpty;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _myProfile != null;
  bool get canEdit =>
      _myProfile != null &&
      _locationFull != null &&
      _myProfile!.id == _locationFull!.createdUserId;
  LocationBaseResponse? get locationBase => _locationBase;
  LocationFullResponse? get locationFull => _locationFull;

  bool get isLiked => _isLiked;
  bool get isJoined => _isJoined;
  bool get isLikeJoinAble => isLoggedIn && _locationFull != null;
  int get likedUserCount => _likedUserCount;
  int get joinedUserCount => _joinedUserCount;
  bool get hasLocation => _locationBase != null || _locationFull != null;
  LocationBaseResponse get location =>
      _locationFull != null ? _locationFull! : _locationBase!;

  List<String> get imageUrls {
    if (locationFull == null) {
      String thumbnailUrl = _locationBase?.thumbnailImage?.imageUrl ?? '';
      return [thumbnailUrl];
    }
    return _locationFull?.images.map((image) => image.imageUrl).toList() ??
        [
          "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee",
          "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee",
          "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee",
          "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee",
        ];
  }

  // ─────────────────────────────────────────────
  // STATE MUTATION
  // ─────────────────────────────────────────────

  // ─────────────────────────────────────────────
  // FUNCTIONS
  // ─────────────────────────────────────────────

  Future<void> load(
    String? locationId,
    LocationBaseResponse? locationBase,
  ) async {
    if (_isLoading) return;
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      if (locationBase == null) {
        final id = int.tryParse(locationId ?? '');
        if (id == null) throw CustomAppException("Ungültige Locationid");

        _locationFull = await LocationService.fetchFullLocation(id);
        _locationBase = _locationFull;
      } else {
        _locationBase = locationBase;
      }
      _myProfile = authController.myProfile;

      _locationFull ??= _locationBase is LocationFullResponse
          ? _locationBase as LocationFullResponse
          : await LocationService.fetchFullLocation(_locationBase!.id);

      _likedUserCount = _locationFull!.likedUserCount;
      _joinedUserCount = _locationFull!.joinedUserCount;
      _isLiked = _locationFull!.likedByCurrentUser ?? false;
      _isJoined = _locationFull!.joinedByCurrentUser ?? false;
    } catch (e, st) {
      debugPrint('Error while loading location details: $e');
      debugPrintStack(stackTrace: st);
      _errorMessage = AppErrorMapper.toUserMessage(
        e,
        fallback: 'Location konnte nicht geladen werden.',
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> reload() async {
    final id = _locationFull?.id ?? _locationBase?.id;

    if (id == null) return;
    _locationFull = null;
    await load(id.toString(), null);
  }

  // ─────────────────────────────────────────────
  // API CALL BEHAVIOR
  // ─────────────────────────────────────────────

  Future<void> toggleLike() async {
    if (_toggleDebounce?.isActive ?? false) {
      _toggleDebounce!.cancel();
    }

    _toggleDebounce = Timer(
      const Duration(milliseconds: 500),
      () async => await _toggleLike(),
    );
  }

  Future<void> _toggleLike() async {
    if (_myProfile == null || _locationFull == null) return;

    final previousLiked = _isLiked;
    final previousCount = _likedUserCount;

    _isLiked = !_isLiked;
    _likedUserCount += _isLiked ? 1 : -1;
    notifyListeners();

    try {
      if (_isLiked) {
        await LocationService.like(_locationFull!.id);
      } else {
        await LocationService.unlike(_locationFull!.id);
      }
    } catch (e, st) {
      debugPrint('Error while toggling like: $e');
      debugPrintStack(stackTrace: st);

      _errorMessage = AppErrorMapper.toUserMessage(
        e,
        fallback: 'Fehler beim Liken der Location.',
      );
      _isLiked = previousLiked;
      _likedUserCount = previousCount;
      notifyListeners();
    }
  }

  Future<void> toggleJoin() async {
    if (_toggleDebounce?.isActive ?? false) {
      _toggleDebounce!.cancel();
    }

    _toggleDebounce = Timer(
      const Duration(milliseconds: 500),
      () async => await _toggleJoin(),
    );
  }

  Future<void> _toggleJoin() async {
    if (_myProfile == null || _locationFull == null) return;

    final previousJoined = _isJoined;
    final previousCount = _joinedUserCount;

    _isJoined = !_isJoined;
    _joinedUserCount += _isJoined ? 1 : -1;
    notifyListeners();

    try {
      if (_isJoined) {
        await LocationService.join(_locationFull!.id);
      } else {
        await LocationService.unjoin(_locationFull!.id);
      }
    } catch (e, st) {
      debugPrint('Error while toggling join: $e');
      debugPrintStack(stackTrace: st);

      _errorMessage = AppErrorMapper.toUserMessage(
        e,
        fallback: 'Fehler beim Beitreten der Location.',
      );
      _isJoined = previousJoined;
      _joinedUserCount = previousCount;
      notifyListeners();
    }
  }

  Future<void> navigateToLocation() async {
    NavigationService.openNavigation(location.position);
  }
}
