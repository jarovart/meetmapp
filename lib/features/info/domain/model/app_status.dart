import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_status.freezed.dart';

@freezed
abstract class AppStatus with _$AppStatus {
  const factory AppStatus({
    String? serverVersion,
    required bool serverOnline,
    bool? databaseOnline,
  }) = _AppStatus;
}
