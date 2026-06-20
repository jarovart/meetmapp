// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get invalidVerifyLink => 'Ungültiger Verifizierungslink';

  @override
  String get login => 'Login';

  @override
  String get loginNow => 'Jetzt einloggen';

  @override
  String get locations => 'Location';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get editLocation => 'Location bearbeiten';

  @override
  String get users => 'Benutzer';

  @override
  String get friends => 'Freunde';

  @override
  String get favourites => 'Favoriten';

  @override
  String get logout => 'Logout';

  @override
  String get settings => 'Einstellungen';

  @override
  String get language => 'Sprache';

  @override
  String get design => 'Design anpassen';

  @override
  String choosedLabel(Object label) {
    return 'Ausgewählt $label';
  }

  @override
  String locationOf(Object title) {
    return 'Location von $title';
  }

  @override
  String get choosePerfectPlace => 'Suche den perfekten Standort aus.';

  @override
  String get longPressSetPostion =>
      'Gedrückt halten um die Position der Location zu setzen.';

  @override
  String get searching => 'Suchen...';

  @override
  String get loading => 'Laden...';

  @override
  String get uploading => 'Wird hochgeladen...';

  @override
  String get location => 'Location';

  @override
  String get noLocationsFound => 'Keine Locations gefunden.';

  @override
  String get locationCouldNotBeLoaded =>
      'Location konnte nicht geladen werden.';

  @override
  String get createLocation => 'Erstelle eine Location';

  @override
  String createLocationAs(Object username) {
    return 'Erstelle eine Location als $username';
  }

  @override
  String get saveLocation => 'Location speichern';

  @override
  String get navigateToLocation => 'Zur Location navigieren';

  @override
  String get openLocation => 'Location öffnen';

  @override
  String get validEmailHint => 'Bitte gültige E-Mail eingeben.';

  @override
  String get forgotPassword => 'Passwort vergessen';

  @override
  String get linkSendToEmail =>
      'Wenn die E-Mail existiert, haben wir dir einen Link geschickt.';

  @override
  String get defaultErrorMessage =>
      'Etwas ist schiefgelaufen. Bitte versuche es erneut.';

  @override
  String get loginToProceed => 'Bitte anmelden, um fortzufahren.';

  @override
  String get serverNotReachable =>
      'Server aktuell nicht erreichbar. Bitte überprüfe deine Verbindung.';

  @override
  String get invalidInput => 'Die Eingaben sind ungültig.';

  @override
  String get notLoggedInLoginAgain =>
      'Du bist nicht mehr eingeloggt. Bitte melde dich erneut an.';

  @override
  String get noAuthorization => 'Du hast keine Berechtigung für diese Aktion.';

  @override
  String get requestedDataNotFound =>
      'Die angeforderten Daten wurden nicht gefunden.';

  @override
  String get actionCouldNotBePerformed =>
      'Die Aktion konnte nicht ausgeführt werden.';

  @override
  String get linkExpired => 'Der Link ist abgelaufen.';

  @override
  String get fileTooLarge => 'Die hochgeladene Datei ist zu groß.';

  @override
  String get unsupportedFileType =>
      'Dieses Dateiformat wird nicht unterstützt.';

  @override
  String get dataCouldNotBeProcessed =>
      'Die Daten konnten nicht verarbeitet werden.';

  @override
  String get tooManyRequests => 'Zu viele Anfragen wurden verschickt.';

  @override
  String get serverError =>
      'Auf dem Server ist ein Fehler aufgetreten. Bitte versuche es später erneut.';

  @override
  String get imageNotFound => 'Bild konnte nicht gefunden werden.';

  @override
  String get invalidCredentials => 'Ungultige Zugangsdaten';

  @override
  String get invalidLink => 'Der Link ist ungültig.';

  @override
  String get linkAlreadyUsed => 'Der Link wurde bereits verwendet.';

  @override
  String get noAccessLocation => 'Kein Zugriff auf die Location.';

  @override
  String get tokenExpired => 'Login Token ist abgelaufen.';

  @override
  String get tokenInvalid => 'Login Token ist ungültig.';

  @override
  String get tokenMissing => 'Der Token wurde nicht übertragen.';

  @override
  String get userNotFound => 'Benutzer wurde nicht gefunden.';

  @override
  String get settingsNotFound => 'Nutzereinstellungen wurden nicht gefunden.';

  @override
  String get usersNotFound => 'Es wurden keine Benutzer gefunden.';

  @override
  String get emailAlreadyExists => 'E-Mail existiert bereits.';

  @override
  String get emailInvalid => 'E-Mail ist ungültig.';

  @override
  String get emailRequired => 'E-Mail ist erforderlich.';

  @override
  String get passwordRequired => 'Passwort ist erforderlich.';

  @override
  String get passwordTooShort => 'Das Passwort ist zu kurz.';

  @override
  String get usernameAlreadyExists => 'Der Nutzername existiert bereits.';

  @override
  String get loginAgain => 'Bitte melde dich erneut an.';

  @override
  String get profileUpdateFailed => 'Profil konnte nicht aktualisiert werden.';

  @override
  String get profileImageTooLarge => 'Das Profilbild ist zu groß.';

  @override
  String get profileImageInvalidFormat =>
      'Das Profilbild hat ein ungültiges Format.';

  @override
  String get contentIsNotPublic => 'Diese Inhalte sind nicht öffentlich.';

  @override
  String get errorPasswordReset => 'Fehler beim Passwort zurücksetzen.';

  @override
  String waitForXSeconds(Object cooldown) {
    return 'Bitte warten ($cooldown s)';
  }

  @override
  String get sendLink => 'Link senden';

  @override
  String get email => 'E-Mail';

  @override
  String get username => 'Benutzername';

  @override
  String get firstName => 'Vorname';

  @override
  String get familyName => 'Nachname';

  @override
  String get password => 'Passwort';

  @override
  String get newPassword => 'Neues Password';

  @override
  String get setNewPassword => 'Neues Passwort setzen';

  @override
  String get changedPassword => 'Passwort geändert! ✅';

  @override
  String get repeatPassword => 'Passwort wiederholen';

  @override
  String get forgotPasswordQuestion => 'Passwort vergessen?';

  @override
  String get savePassword => 'Passwort speichern';

  @override
  String get save => 'Speichern';

  @override
  String get title => 'Titel';

  @override
  String get enterTitle => 'Titel eingeben';

  @override
  String get titleNotEmpty => 'Titel darf nicht leer sein.';

  @override
  String get description => 'Beschreibung';

  @override
  String get enterDescription => 'Beschreibung eingeben';

  @override
  String get missingDescription => 'Beschreibung fehlt.';

  @override
  String get chooseStartdate => 'Startdatum wählen';

  @override
  String get noChosedStartdate => 'Kein Startdatum ausgewählt.';

  @override
  String displayStartdate(Object time) {
    return 'Beginn: $time Uhr';
  }

  @override
  String get chooseEnddate => 'Enddatum wählen';

  @override
  String get noChosedEnddate => 'Kein Enddatum ausgewählt.';

  @override
  String displayEnddate(Object time) {
    return 'Ende: $time Uhr';
  }

  @override
  String get address => 'Adresse';

  @override
  String get resetAddress => 'Adresse zurücksetzen';

  @override
  String get enterAddress => 'Adresse eingeben';

  @override
  String get missingAddress => 'Adresse fehlt.';

  @override
  String get position => 'Position (lat, lng)';

  @override
  String positionWithCoordinates(Object latitude, Object longitude) {
    return 'Position:\nLatitude: $latitude\nLongitude: $longitude';
  }

  @override
  String get positionCopied => 'Position wurde kopiert!';

  @override
  String get images => 'Bilder';

  @override
  String imageNumber(Object index) {
    return 'Bild $index';
  }

  @override
  String get thumbnail => 'Titelbild';

  @override
  String get addImage => 'Bild hinzufügen';

  @override
  String get noAccountQuestion => 'Noch keinen Account?';

  @override
  String get register => 'Registrieren';

  @override
  String get registerSuccessfully => 'Registrierung erfolgreich!';

  @override
  String get resendEmail => 'E-Mail erneut senden';

  @override
  String get resentEmail => 'E-Mail wurde erneut gesendet';

  @override
  String get errorSendEmail => 'Fehler beim Verschicken der E-Mail.';

  @override
  String get fillAllFields => 'Alle Felder müssen ausgefüllt sein';

  @override
  String get notMatchPasswords => 'Passwörter stimmen nicht überein.';

  @override
  String get atleast8CharPassword =>
      'Passwörter müssen mindestens 8 Zeichen lang sein';

  @override
  String get errorRegister => 'Fehler beim Registrieren.';

  @override
  String get verifcationFailed => 'Verifizierung fehlgeschlagen.';

  @override
  String get backtToHomepage => 'Zurück zur Startseite';

  @override
  String get verifyEmail => 'E-Mail Verifizierung';

  @override
  String get verifyingEmail => 'Verifiziere E-Mail Adresse...';

  @override
  String get unknownError => 'Unbekannter Fehler';

  @override
  String get createdBy => 'Erstellt von';

  @override
  String get useSearch => 'Benutze die Suche';

  @override
  String get filter => 'Filter';

  @override
  String get close => 'Schließen';

  @override
  String get places => 'Orte (z.B. Hamburg)';

  @override
  String radiusInput(Object radius) {
    return 'Radius: $radius km';
  }

  @override
  String get reset => 'Zurücksetzen';

  @override
  String get apply => 'Anwenden';

  @override
  String get darkMode => 'Dunkler Modus';

  @override
  String get selectImage => 'Bild auswählen';

  @override
  String get removeImage => 'Bild entfernen';

  @override
  String get editProfile => 'Profil bearbeiten';

  @override
  String get aboutMe => 'Über mich';

  @override
  String profileOf(Object name) {
    return 'Benutzer $name';
  }

  @override
  String get profileCouldNotBeLoaded => 'Profil konnte nicht geladen werden.';

  @override
  String get created => 'Erstellt';

  @override
  String get joined => 'Beigetreten';

  @override
  String get liked => 'Geliked';

  @override
  String likesCount(Object count) {
    return '$count gefällt es';
  }

  @override
  String joinsCount(Object count) {
    return '$count nehmen teil';
  }

  @override
  String get createdLocations => 'Erstellte Locations';

  @override
  String get joinedLocations => 'Beigetreten Locations';

  @override
  String get likedLocations => 'Gefällt mir-Locations';

  @override
  String get noDescriptionAvailable => 'Keine Beschreibung vorhanden.';

  @override
  String get enterNameSearch => 'Please enter a name in the search bar.';

  @override
  String get reload => 'Neu laden';

  @override
  String get noEntriesAvailable => 'Keine Einträge vorhanden';

  @override
  String get invalidLocationId => 'Ungültige Location id';

  @override
  String get notLocationOwnerNoEdit =>
      'Sie sind nicht der Besitzer der Location und können diese daher nicht bearbeiten.';

  @override
  String get infoChooseStartAndEnddate =>
      'Bitte ein Start- und ein Enddatum auswählen.';

  @override
  String get infoEnddateBeforeStartdate =>
      'Das Enddatum darf nicht vor dem Startdatum sein.';

  @override
  String get errorUpdatingLocation => 'Fehler beim Aktualisieren der Location.';

  @override
  String get cropProfileImage => 'Profilbild zuschneiden';

  @override
  String get imageCouldNotBeProcessed =>
      'Bild konnte nicht verarbeitet werden.';

  @override
  String get errorCreateLocation => 'Fehler beim Erstellen der Location.';

  @override
  String get errorAddingImage =>
      'Beim Hinzufügen eines Bildes ist ein Fehler aufgetreten.';

  @override
  String get errorLikeLocation => 'Fehler beim Liken der Locations.';

  @override
  String get errorJoinLocation => 'Fehler beim Beitreten der Locations.';

  @override
  String get disabledLocationServices => 'Standortdienste sind deaktiviert';

  @override
  String get deniedLocationPermission => 'Standort-Berechtigung verweigert';

  @override
  String get noGpsAndNoFilterLocation => 'Keine GPS-Positionen verfügbar.';

  @override
  String get errorCallLocations =>
      'Fehler beim Abrufen der weiteren Locations.';

  @override
  String get errorCallMoreLocations =>
      'Error occurs while retrieving more locations.';

  @override
  String get errorLogin => 'Fehler beim Einloggen.';

  @override
  String get errorLogout => 'Fehler beim Ausloggen.';

  @override
  String get errorSearch => 'Suche fehlgeschlagen.';

  @override
  String get errorCallUsers => 'Fehler beim Abrufen der Benutzer.';

  @override
  String get errorCallMoreUsers => 'Fehler beim Abrufen der weiteren Benutzer.';

  @override
  String get today => 'Heute';

  @override
  String get tomorrow => 'Morgen';

  @override
  String get dayAfterTomorrow => 'Übermorgen';

  @override
  String get nextWeek => '1 Woche';

  @override
  String get nextMonth => '1 Monat';

  @override
  String memberSince(Object date) {
    return 'Mitglied seit $date';
  }

  @override
  String get menu => 'Menü';

  @override
  String get systemLanguage => 'System Sprache';

  @override
  String get english => 'Englisch';

  @override
  String get german => 'Deutsch';

  @override
  String get noPhotoPermission => 'Kein Fotozugriff wurde erlaubt.';

  @override
  String get support => 'Support';

  @override
  String get info => 'Info';

  @override
  String aboutApp(Object apptitle) {
    return 'Über $apptitle';
  }

  @override
  String aboutAppText(Object apptitle) {
    return '$apptitle verbindet Menschen über gemeinsame Aktivitäten und interessante Orte.\nErstelle Verabredungen, entdecke Events und triff neue Leute in deiner Umgebung.';
  }

  @override
  String get version => 'Version';

  @override
  String get serverVersion => 'Server Version';

  @override
  String get server => 'Server';

  @override
  String get database => 'Datenbank';

  @override
  String get online => 'Online';

  @override
  String get offline => 'Offline';

  @override
  String get homepage => 'HomePage';

  @override
  String get howToSupport => 'Wie können wir dir helfen?';

  @override
  String get sendEmail =>
      'Schreib uns eine E-Mail oder sende direkt eine Nachricht an den Support.';

  @override
  String get writeEmail => 'E-Mail schreiben';

  @override
  String get openMailProgramm =>
      'Öffnet dein Mailprogramm mit vorausgefülltem Betreff.';

  @override
  String get contactSupport => 'Support kontaktieren';

  @override
  String get messageSent => 'Nachricvht wurde gesendet';

  @override
  String get messageFailed => 'Nachricht konnte nicht gesendet werden.';
}
