import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExceptionMessage {
  static void showInfo(
    BuildContext context,
    String message, {
    StackTrace? stackTrace,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      createSnackBar(
        Icon(Icons.info_outline, color: Colors.black, size: 30),
        message,
        stackTrace,
      ),
    );
  }

  static void showWarning(
    BuildContext context,
    String message, {
    StackTrace? stackTrace,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      createSnackBar(
        Icon(
          Icons.warning_amber_outlined,
          color: Colors.yellowAccent,
          size: 30,
        ),
        message,
        stackTrace,
      ),
    );
  }

  static void showError(
    BuildContext context,
    String message, {
    StackTrace? stackTrace,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      createSnackBar(
        Icon(Icons.error_outline, color: Colors.redAccent, size: 30),
        message,
        stackTrace,
      ),
    );
  }

  static SnackBar createSnackBar(
    Icon icon,
    String message,
    StackTrace? stackTrace,
  ) {
    if (stackTrace != null) {
      log(message, level: 1000, name: "MapPage", stackTrace: stackTrace);
    } else {
      debugPrint(message);
    }

    return SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: const Duration(seconds: 5),
      content: GestureDetector(
        onTap: () {
          Clipboard.setData(ClipboardData(text: message));
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color.fromARGB(240, 214, 214, 214),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              icon,
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
