import 'package:flutter/material.dart';
import 'package:meetmaap/app/model/response/status_response.dart';
import 'package:meetmaap/app/service/info_service.dart';

class InfoController extends ChangeNotifier {
  bool _isLoading = false;
  Object? error;
  bool loggedIn = false;
  StatusResponse? statusResponse;

  Future<void> load(bool? loggedIn) async {
    if (_isLoading) return;
    _isLoading = true;
    error = null;
    this.loggedIn = loggedIn ?? false;
    notifyListeners();

    try {
      final statusResponse = await InfoService.getHealth();
      this.statusResponse = statusResponse;
    } catch (e, st) {
      debugPrint('load editprofile failed: $e');
      debugPrintStack(stackTrace: st);
      statusResponse = null;
      error = e;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
