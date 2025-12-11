import 'dart:async';

class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer({required this.delay});

  /// Führt die Funktion erst aus, wenn der Nutzer
  /// [delay] lang nichts mehr aufgerufen hat.
  void run(void Function() action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  /// Optional, falls du canceln willst
  void cancel() {
    _timer?.cancel();
  }
}
