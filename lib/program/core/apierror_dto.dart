class ApiErrorDto {
  const ApiErrorDto({
    required this.code,
    required this.message,
    this.requestId,
    this.fieldErrors = const {},
  });

  final String code;
  final String message;
  final String? requestId;
  final Map<String, String> fieldErrors;

  factory ApiErrorDto.fromJson(Map<String, dynamic> json) {
    return ApiErrorDto(
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
