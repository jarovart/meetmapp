import 'package:flutter/rendering.dart';
import 'package:meetmaap/app/model/exception/app_exception.dart';

class AppErrorMapper {
  static String toUserMessage(
    Object error, {
    String fallback = 'Etwas ist schiefgelaufen. Bitte versuche es erneut.',
  }) {
    if (error is CustomAppException) {
      return error.message.isNotEmpty ? error.message : fallback;
    }

    debugPrint(error.toString());
    if (error is AppHttpException) {
      debugPrint("apphttp: ${error.toString()}");
      if (error.errorCode != null) {
        final mappedByCode = _mapErrorCode(error.errorCode!);
        if (mappedByCode != null) return mappedByCode;
      }

      return _mapStatusCode(error.statusCode, fallback: fallback);
    }

    if (error is NotLoggedInException) {
      return 'Bitte anmelden, um fortzufahren.';
    }

    if (error is AppNetworkException) {
      return 'Server aktuell nicht erreichbar. Bitte prüfe deine Verbindung und versuche es erneut.';
    }

    if (error is AppUnknownException) {
      return fallback;
    }

    return fallback;
  }

  static String _mapStatusCode(int statusCode, {required String fallback}) {
    switch (statusCode) {
      case 400:
        return 'Die Eingaben sind ungültig.';
      case 401:
        return 'Du bist nicht mehr eingeloggt. Bitte melde dich erneut an.';
      case 403:
        return 'Du hast keine Berechtigung für diese Aktion.';
      case 404:
        return 'Die angeforderten Daten wurden nicht gefunden.';
      case 409:
        return 'Die Aktion konnte nicht ausgeführt werden.';
      case 413:
        return 'Die hochgeladene Datei ist zu groß.';
      case 415:
        return 'Dieses Dateiformat wird nicht unterstützt.';
      case 422:
        return 'Die Daten konnten nicht verarbeitet werden.';
      case 429:
        return 'Zu viele Anfragen wurden verschickt.';
      case 500:
      case 502:
      case 503:
      case 504:
        return 'Auf dem Server ist ein Fehler aufgetreten. Bitte versuche es später erneut.';
      default:
        return fallback;
    }
  }

  static String? _mapErrorCode(String errorCode) {
    switch (errorCode) {
      case 'IMAGE_NOT_FOUND':
        return 'Bild konnte nicht gefunden werden.';
      case 'INVALID_CREDENTIALS':
        return '';
      case 'LINK_NOT_VALID':
        return 'Der Link ist ungültig.';
      case 'LINK_USED':
        return 'Der Link wurde bereits verwendet.';
      case 'LINK_EXPIRED':
        return 'Der Link ist abgelaufen.';
      case 'LOCATION_NOT_FOUND':
        return 'Location wurde nicht gefunden.';
      case 'LOCATION_FORBIDDEN':
        return 'Kein Zugriff auf die Location.';
      case 'TOKEN_EXPIRED':
        return 'Login Token ist abgelaufen.';
      case 'TOKEN_INVALID':
        return 'Login Token ist ungültig.';
      case 'TOKEN_MISSING':
        return 'Der Token wurde nicht übertragen.';
      case 'USER_NOT_FOUND':
        return 'Benutzer wurde nicht gefunden.';
      case 'USER_EMAIL_EXISTS':
        return 'E-Mail existiert bereits.';
      case 'USER_EMAIL_INVALID':
        return 'E-Mail ist ungültig.';
      case 'USER_EMAIL_REQUIRED':
        return 'E-Mail ist erforderlich.';
      case 'USER_PASSWORD_REQUIRED':
        return 'Passwort ist erforderlich.';
      case 'USER_PASSWORD_TOO_SHORT':
        return 'Passwort ist zu kurz.';
      case 'USER_USERNAME_EXISTS':
        return 'Der Nutzername existiert bereits.';
      case 'NOT_AUTHENTICATED':
        return 'Bitte melde dich erneut an.';
      case 'PROFILE_UPDATE_FAILED':
        return 'Profil konnte nicht gespeichert werden.';
      case 'PROFILE_IMAGE_TOO_LARGE':
        return 'Das Profilbild ist zu groß.';
      case 'PROFILE_IMAGE_INVALID_TYPE':
        return 'Das Profilbild hat ein ungültiges Format.';
      case 'LIKED_LOCATIONS_NOT_PUBLIC':
        return 'Diese Inhalte sind nicht öffentlich sichtbar.';
      default:
        return null;
    }
  }
}
