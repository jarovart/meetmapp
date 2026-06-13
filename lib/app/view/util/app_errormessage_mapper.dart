import 'dart:async';
import 'dart:io';

import 'package:http/http.dart';
import 'package:meetmaap/app/model/exception/app_exception.dart';
import 'package:meetmaap/l10n/app_localizations.dart';

class AppErrorMapper {
  static bool isForbiddenException(Object error) {
    if (error is AppHttpException) {
      return error.statusCode == 403;
    }
    return false;
  }

  static bool isServerNotReachableException(Object error) {
    if (error is AppNetworkException) {
      final origin = error.originException;
      return origin is SocketException ||
          origin is TimeoutException ||
          origin is ClientException;
    }
    return false;
  }

  static String toUserMessage(
    Object error,
    AppLocalizations l10n, {
    String? fallback,
  }) {
    String fallbackMessage = fallback ?? l10n.defaultErrorMessage;
    if (error is CustomAppException) {
      return _getAppErrorMessage(error, l10n, fallbackMessage);
    }

    if (error is AppHttpException) {
      if (error.errorCode != null) {
        final mappedByCode = _mapErrorCode(error.errorCode!, l10n);
        if (mappedByCode != null) return mappedByCode;
      }

      return _mapStatusCode(error.statusCode, l10n, fallback: fallbackMessage);
    }

    if (error is NotLoggedInException) {
      return l10n.loginToProceed;
    }

    if (error is AppNetworkException) {
      return l10n.serverNotReachable;
    }

    if (error is AppUnknownException) {
      return fallbackMessage;
    }

    return fallbackMessage;
  }

  static String _mapStatusCode(
    int statusCode,
    AppLocalizations l10n, {
    required String fallback,
  }) {
    switch (statusCode) {
      case 400:
        return l10n.invalidInput;
      case 401:
        return l10n.notLoggedInLoginAgain;
      case 403:
        return l10n.noAuthorization;
      case 404:
        return l10n.requestedDataNotFound;
      case 409:
        return l10n.actionCouldNotBePerformed;
      case 410:
        return l10n.linkExpired;
      case 413:
        return l10n.fileTooLarge;
      case 415:
        return l10n.unsupportedFileType;
      case 422:
        return l10n.dataCouldNotBeProcessed;
      case 429:
        return l10n.tooManyRequests;
      case 500:
      case 502:
      case 503:
      case 504:
        return l10n.serverError;
      default:
        return fallback;
    }
  }

  static String? _mapErrorCode(String errorCode, AppLocalizations l10n) {
    switch (errorCode) {
      case 'IMAGE_NOT_FOUND':
        return l10n.imageNotFound;
      case 'INVALID_CREDENTIALS':
        return l10n.invalidCredentials;
      case 'LINK_NOT_VALID':
        return l10n.invalidLink;
      case 'LINK_USED':
        return l10n.linkAlreadyUsed;
      case 'LINK_EXPIRED':
        return l10n.linkExpired;
      case 'LOCATION_NOT_FOUND':
        return l10n.noLocationsFound;
      case 'LOCATION_FORBIDDEN':
        return l10n.noAccessLocation;
      case 'LOCATION_LIKE_NOT_FOUND':
        return l10n.actionCouldNotBePerformed;
      case 'LOCATION_JOIN_NOT_FOUND':
        return l10n.actionCouldNotBePerformed;
      case 'TOKEN_EXPIRED':
        return l10n.tokenExpired;
      case 'TOKEN_INVALID':
        return l10n.tokenInvalid;
      case 'TOKEN_MISSING':
        return l10n.tokenMissing;
      case 'USER_NOT_FOUND':
        return l10n.userNotFound;
      case 'SETTINGS_NOT_FOUND':
        return l10n.settingsNotFound;
      case 'USER_EMAIL_EXISTS':
        return l10n.emailAlreadyExists;
      case 'USER_EMAIL_INVALID':
        return l10n.emailInvalid;
      case 'USER_EMAIL_REQUIRED':
        return l10n.emailRequired;
      case 'USER_PASSWORD_REQUIRED':
        return l10n.passwordRequired;
      case 'USER_PASSWORD_TOO_SHORT':
        return l10n.passwordTooShort;
      case 'USER_USERNAME_EXISTS':
        return l10n.usernameAlreadyExists;
      case 'NOT_AUTHENTICATED':
        return l10n.loginAgain;
      case 'PROFILE_UPDATE_FAILED':
        return l10n.profileUpdateFailed;
      case 'PROFILE_IMAGE_TOO_LARGE':
        return l10n.profileImageTooLarge;
      case 'PROFILE_IMAGE_INVALID_TYPE':
        return l10n.profileImageInvalidFormat;
      case 'LIKED_LOCATIONS_NOT_PUBLIC':
        return l10n.contentIsNotPublic;
      default:
        return null;
    }
  }

  static String _getAppErrorMessage(
    CustomAppException error,
    AppLocalizations l10n,
    String fallback,
  ) {
    switch (error) {
      case LocationCouldNotBeLoadedException():
        return l10n.locationCouldNotBeLoaded;
      case LocationServiceDisabled():
        return l10n.disabledLocationServices;
      case LocationPermissionDenied():
        return l10n.deniedLocationPermission;
      case LocationError():
        return error.message;
      case NoTokenException():
        return l10n.tokenMissing;
      case InvalidLocationIdException():
        return l10n.invalidLocationId;
      case NotLocationOwnerNoEditException():
        return l10n.notLocationOwnerNoEdit;
      case FillAllFieldsException():
        return l10n.fillAllFields;
      case InfoChooseStartAndEnddateException():
        return l10n.infoChooseStartAndEnddate;
      case InfoEnddateBeforeStartdateException():
        return l10n.infoEnddateBeforeStartdate;
      case ValidEmailHintException():
        return l10n.validEmailHint;
      case NotMatchPasswordsException():
        return l10n.notMatchPasswords;
      case Atleast8CharPasswordException():
        return l10n.atleast8CharPassword;
      case EmailInvalidException():
        return l10n.emailInvalid;
      case NoGpsAndNoFilterLocationException():
        return l10n.noGpsAndNoFilterLocation;
      default:
        return fallback;
    }
  }
}
