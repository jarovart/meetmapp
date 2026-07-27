class ApiErrorDTO {
  const ApiErrorDTO({
    required this.code,
    required this.message,
    this.requestId,
    this.fieldErrors = const {},
  });

  final String code;
  final String message;
  final String? requestId;
  final Map<String, String> fieldErrors;

  factory ApiErrorDTO.fromJson(Map<String, dynamic> json) {
    return ApiErrorDTO(
      code: json['code'] as String? ?? 'UNKNOWN',
      message: json['message'] as String? ?? '',
      requestId: json['requestId'] as String?,
      fieldErrors:
          (json['fieldErrors'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(key, value.toString()),
          ) ??
          const {},
    );
  }
}
