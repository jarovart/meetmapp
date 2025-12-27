class CooldownException implements Exception {
  final int seconds;
  final String message;
  CooldownException(this.message, this.seconds);
}
