import 'package:casttime/core/failure/app_failure.dart';
import 'package:casttime/l10n/app_localizations.dart';

extension AppFailureLocalization on AppFailure {
  String localizedMessage(AppLocalizations l10n) {
    return switch (this) {
      NoConnectionFailure() => l10n.serverNotReachable,
      ConnectionTimeoutFailure() => l10n.serverNotReachable,
      ServerUnavailableFailure() => l10n.serverNotReachable,
      UnauthorizedFailure() => l10n.noAuthorization,
      ForbiddenFailure() => l10n.errorForbidden,
      NotFoundFailure() => l10n.dataCouldNotBeProcessed,
      ValidationFailure() => l10n.invalidInput,
      ConflictFailure(:final code) => _localizeConflict(code, l10n),
      InvalidSearchQueryFailure() => l10n.errorSearch,
      InvalidDateRangeFailure() => l10n.infoEnddateBeforeStartdate,
      UnexpectedFailure() => l10n.unknownError,
      LocationPermissionDeniedFailure() => "todo error",
      LocationPermissionDeniedForeverFailure() => "todo error",
      LocationServiceDisabledFailure() => "todo error",
      LocationTimeoutFailure() => "todo error",
    };
  }

  String _localizeConflict(String? code, AppLocalizations l10n) {
    return switch (code) {
      'USERNAME_ALREADY_EXISTS' => l10n.usernameAlreadyExists,

      'EMAIL_ALREADY_EXISTS' => l10n.emailAlreadyExists,

      'LOCATION_ALREADY_JOINED' => l10n.actionCouldNotBePerformed,

      _ => l10n.unknownError,
    };
  }
}
