class StatusResponse {
  final bool serverOnline;
  final bool? dataBaseOnline;
  final String? serverVersion;

  StatusResponse({
    required this.serverOnline,
    this.serverVersion,
    this.dataBaseOnline,
  });

  factory StatusResponse.fromMap(Map<String, dynamic> map) {
    return StatusResponse(
      serverOnline: map['serverOnline'] ?? false,
      dataBaseOnline: map['dataBaseOnline'],
      serverVersion: map['serverVersion'],
    );
  }
}
