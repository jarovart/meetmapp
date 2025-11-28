import 'package:flutter/material.dart';

class NotificationService extends ChangeNotifier {
  final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  void showError(String message) {
    messengerKey.currentState?.showSnackBar(SnackBar(content: Text(message)));
  }
}
