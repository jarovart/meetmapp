import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExceptionMessage {
  static void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: GestureDetector(
          onTap: () {
            Clipboard.setData(ClipboardData(text: message));

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text("Kopiert!"),
                duration: const Duration(seconds: 1),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.error_outline, color: Colors.white, size: 26),
                const SizedBox(width: 12),

                // 🔥 Text block is flexible and supports unlimited lines
                Expanded(
                  child: SelectableText(
                    message,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }
}
