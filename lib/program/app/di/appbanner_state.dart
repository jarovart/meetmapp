import 'package:casttime/program/core/failure/appfailure.dart';
import 'package:equatable/equatable.dart';

enum AppBannerType { error, warning, info, success }

class AppBannerState extends Equatable {
  const AppBannerState({
    this.failure,
    this.type = AppBannerType.error,
    this.messageId = 0,
  });

  final AppFailure? failure;
  final AppBannerType type;

  /// Wird bei jeder neuen Anzeige erhöht.
  /// Dadurch kann derselbe Fehler mehrfach angezeigt werden.
  final int messageId;

  bool get isVisible => failure != null;

  factory AppBannerState.initial() {
    return const AppBannerState();
  }

  AppBannerState copyWith({
    AppFailure? failure,
    bool clearFailure = false,
    AppBannerType? type,
    int? messageId,
  }) {
    return AppBannerState(
      failure: clearFailure ? null : failure ?? this.failure,
      type: type ?? this.type,
      messageId: messageId ?? this.messageId,
    );
  }

  @override
  List<Object?> get props => [failure, type, messageId];
}
