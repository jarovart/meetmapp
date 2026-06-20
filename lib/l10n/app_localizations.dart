import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
  ];

  /// No description provided for @invalidVerifyLink.
  ///
  /// In en, this message translates to:
  /// **'Invalid verificationlink'**
  String get invalidVerifyLink;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @loginNow.
  ///
  /// In en, this message translates to:
  /// **'Log in now'**
  String get loginNow;

  /// No description provided for @locations.
  ///
  /// In en, this message translates to:
  /// **'Locations'**
  String get locations;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @editLocation.
  ///
  /// In en, this message translates to:
  /// **'Edit location '**
  String get editLocation;

  /// No description provided for @users.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get users;

  /// No description provided for @friends.
  ///
  /// In en, this message translates to:
  /// **'Friends'**
  String get friends;

  /// No description provided for @favourites.
  ///
  /// In en, this message translates to:
  /// **'favourites'**
  String get favourites;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'log out'**
  String get logout;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @design.
  ///
  /// In en, this message translates to:
  /// **'Customize theme'**
  String get design;

  /// No description provided for @choosedLabel.
  ///
  /// In en, this message translates to:
  /// **'Chosed {label}'**
  String choosedLabel(Object label);

  /// No description provided for @locationOf.
  ///
  /// In en, this message translates to:
  /// **'Location of {title}'**
  String locationOf(Object title);

  /// No description provided for @choosePerfectPlace.
  ///
  /// In en, this message translates to:
  /// **'Choose the perfect place'**
  String get choosePerfectPlace;

  /// No description provided for @longPressSetPostion.
  ///
  /// In en, this message translates to:
  /// **'Long press anywhere on the map to drop a pin and set the location.'**
  String get longPressSetPostion;

  /// No description provided for @searching.
  ///
  /// In en, this message translates to:
  /// **'Searching...'**
  String get searching;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @uploading.
  ///
  /// In en, this message translates to:
  /// **'Uploading...'**
  String get uploading;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @noLocationsFound.
  ///
  /// In en, this message translates to:
  /// **'Location not found.'**
  String get noLocationsFound;

  /// No description provided for @locationCouldNotBeLoaded.
  ///
  /// In en, this message translates to:
  /// **'Location could not be loaded.'**
  String get locationCouldNotBeLoaded;

  /// No description provided for @createLocation.
  ///
  /// In en, this message translates to:
  /// **'Create a location'**
  String get createLocation;

  /// No description provided for @createLocationAs.
  ///
  /// In en, this message translates to:
  /// **'Create a location as {username}'**
  String createLocationAs(Object username);

  /// No description provided for @saveLocation.
  ///
  /// In en, this message translates to:
  /// **'Save this location'**
  String get saveLocation;

  /// No description provided for @navigateToLocation.
  ///
  /// In en, this message translates to:
  /// **'Navigate to Location'**
  String get navigateToLocation;

  /// No description provided for @openLocation.
  ///
  /// In en, this message translates to:
  /// **'Open location'**
  String get openLocation;

  /// No description provided for @validEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Please use a valid E-Mail.'**
  String get validEmailHint;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password'**
  String get forgotPassword;

  /// No description provided for @linkSendToEmail.
  ///
  /// In en, this message translates to:
  /// **'A link has been sent to your e-mail.'**
  String get linkSendToEmail;

  /// No description provided for @defaultErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again later.'**
  String get defaultErrorMessage;

  /// No description provided for @loginToProceed.
  ///
  /// In en, this message translates to:
  /// **'Please log in for proceeding.'**
  String get loginToProceed;

  /// No description provided for @serverNotReachable.
  ///
  /// In en, this message translates to:
  /// **'Server is not reachable. Please check the connection.'**
  String get serverNotReachable;

  /// No description provided for @invalidInput.
  ///
  /// In en, this message translates to:
  /// **'Input is not valid.'**
  String get invalidInput;

  /// No description provided for @notLoggedInLoginAgain.
  ///
  /// In en, this message translates to:
  /// **'You are not logged in. Please log in again.'**
  String get notLoggedInLoginAgain;

  /// No description provided for @noAuthorization.
  ///
  /// In en, this message translates to:
  /// **'You are not authorized for this action'**
  String get noAuthorization;

  /// No description provided for @requestedDataNotFound.
  ///
  /// In en, this message translates to:
  /// **'The requested data was not found.'**
  String get requestedDataNotFound;

  /// No description provided for @actionCouldNotBePerformed.
  ///
  /// In en, this message translates to:
  /// **'Action could not be performed.'**
  String get actionCouldNotBePerformed;

  /// No description provided for @linkExpired.
  ///
  /// In en, this message translates to:
  /// **'The Link has been expired.'**
  String get linkExpired;

  /// No description provided for @fileTooLarge.
  ///
  /// In en, this message translates to:
  /// **'The uploaded file is too large.'**
  String get fileTooLarge;

  /// No description provided for @unsupportedFileType.
  ///
  /// In en, this message translates to:
  /// **'This file format is not supported.'**
  String get unsupportedFileType;

  /// No description provided for @dataCouldNotBeProcessed.
  ///
  /// In en, this message translates to:
  /// **'The data could not be processed.'**
  String get dataCouldNotBeProcessed;

  /// No description provided for @tooManyRequests.
  ///
  /// In en, this message translates to:
  /// **'Too many requests were sent.'**
  String get tooManyRequests;

  /// No description provided for @serverError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred on the server. Please try again later.'**
  String get serverError;

  /// No description provided for @imageNotFound.
  ///
  /// In en, this message translates to:
  /// **'Image not found.'**
  String get imageNotFound;

  /// No description provided for @invalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid credentials.'**
  String get invalidCredentials;

  /// No description provided for @invalidLink.
  ///
  /// In en, this message translates to:
  /// **'Invalid credentials.'**
  String get invalidLink;

  /// No description provided for @linkAlreadyUsed.
  ///
  /// In en, this message translates to:
  /// **'The link has already been used.'**
  String get linkAlreadyUsed;

  /// No description provided for @noAccessLocation.
  ///
  /// In en, this message translates to:
  /// **'No access to the location.'**
  String get noAccessLocation;

  /// No description provided for @tokenExpired.
  ///
  /// In en, this message translates to:
  /// **'Login token has expired.'**
  String get tokenExpired;

  /// No description provided for @tokenInvalid.
  ///
  /// In en, this message translates to:
  /// **'The login token is invalid.'**
  String get tokenInvalid;

  /// No description provided for @tokenMissing.
  ///
  /// In en, this message translates to:
  /// **'The token was not transferred.'**
  String get tokenMissing;

  /// No description provided for @userNotFound.
  ///
  /// In en, this message translates to:
  /// **'User not found.'**
  String get userNotFound;

  /// No description provided for @settingsNotFound.
  ///
  /// In en, this message translates to:
  /// **'Usersettings not found.'**
  String get settingsNotFound;

  /// No description provided for @usersNotFound.
  ///
  /// In en, this message translates to:
  /// **'No users could be found.'**
  String get usersNotFound;

  /// No description provided for @emailAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'E-Mail already exists.'**
  String get emailAlreadyExists;

  /// No description provided for @emailInvalid.
  ///
  /// In en, this message translates to:
  /// **'The E-Mail is invalid.'**
  String get emailInvalid;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'E-Mail is required.'**
  String get emailRequired;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'E-Mail is required.'**
  String get passwordRequired;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'The password is too short.'**
  String get passwordTooShort;

  /// No description provided for @usernameAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'The username already exists.'**
  String get usernameAlreadyExists;

  /// No description provided for @loginAgain.
  ///
  /// In en, this message translates to:
  /// **'Please log in again.'**
  String get loginAgain;

  /// No description provided for @profileUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Profile could not be updated.'**
  String get profileUpdateFailed;

  /// No description provided for @profileImageTooLarge.
  ///
  /// In en, this message translates to:
  /// **'The profile picture is too large.'**
  String get profileImageTooLarge;

  /// No description provided for @profileImageInvalidFormat.
  ///
  /// In en, this message translates to:
  /// **'The profile picture has an invalid format.'**
  String get profileImageInvalidFormat;

  /// No description provided for @contentIsNotPublic.
  ///
  /// In en, this message translates to:
  /// **'This content is not public.'**
  String get contentIsNotPublic;

  /// No description provided for @errorPasswordReset.
  ///
  /// In en, this message translates to:
  /// **'Error occurs while resetting password.'**
  String get errorPasswordReset;

  /// No description provided for @waitForXSeconds.
  ///
  /// In en, this message translates to:
  /// **'Please wait ({cooldown} s)'**
  String waitForXSeconds(Object cooldown);

  /// No description provided for @sendLink.
  ///
  /// In en, this message translates to:
  /// **'Send link'**
  String get sendLink;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'E-Mail'**
  String get email;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'Firstname'**
  String get firstName;

  /// No description provided for @familyName.
  ///
  /// In en, this message translates to:
  /// **'Familyname'**
  String get familyName;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @setNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Set new Password'**
  String get setNewPassword;

  /// No description provided for @changedPassword.
  ///
  /// In en, this message translates to:
  /// **'Password changed! ✅'**
  String get changedPassword;

  /// No description provided for @repeatPassword.
  ///
  /// In en, this message translates to:
  /// **'Repeat password'**
  String get repeatPassword;

  /// No description provided for @forgotPasswordQuestion.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPasswordQuestion;

  /// No description provided for @savePassword.
  ///
  /// In en, this message translates to:
  /// **'Save password'**
  String get savePassword;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @enterTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter Title'**
  String get enterTitle;

  /// No description provided for @titleNotEmpty.
  ///
  /// In en, this message translates to:
  /// **'Title cannot be empty.'**
  String get titleNotEmpty;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @enterDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter Description'**
  String get enterDescription;

  /// No description provided for @missingDescription.
  ///
  /// In en, this message translates to:
  /// **'Description is missing.'**
  String get missingDescription;

  /// No description provided for @chooseStartdate.
  ///
  /// In en, this message translates to:
  /// **'Choose start date'**
  String get chooseStartdate;

  /// No description provided for @noChosedStartdate.
  ///
  /// In en, this message translates to:
  /// **'No start date selected'**
  String get noChosedStartdate;

  /// No description provided for @displayStartdate.
  ///
  /// In en, this message translates to:
  /// **'Begin: {time}'**
  String displayStartdate(Object time);

  /// No description provided for @chooseEnddate.
  ///
  /// In en, this message translates to:
  /// **'Choose end date'**
  String get chooseEnddate;

  /// No description provided for @noChosedEnddate.
  ///
  /// In en, this message translates to:
  /// **'No end date selected'**
  String get noChosedEnddate;

  /// No description provided for @displayEnddate.
  ///
  /// In en, this message translates to:
  /// **'End: {time}'**
  String displayEnddate(Object time);

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @resetAddress.
  ///
  /// In en, this message translates to:
  /// **'Reset address'**
  String get resetAddress;

  /// No description provided for @enterAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter address'**
  String get enterAddress;

  /// No description provided for @missingAddress.
  ///
  /// In en, this message translates to:
  /// **'Address missing'**
  String get missingAddress;

  /// No description provided for @position.
  ///
  /// In en, this message translates to:
  /// **'Position (lat, lng)'**
  String get position;

  /// No description provided for @positionWithCoordinates.
  ///
  /// In en, this message translates to:
  /// **'Position:\nLatitude: {latitude}\nLongitude: {longitude}'**
  String positionWithCoordinates(Object latitude, Object longitude);

  /// No description provided for @positionCopied.
  ///
  /// In en, this message translates to:
  /// **'Position has been copied!'**
  String get positionCopied;

  /// No description provided for @images.
  ///
  /// In en, this message translates to:
  /// **'Pictures'**
  String get images;

  /// No description provided for @imageNumber.
  ///
  /// In en, this message translates to:
  /// **'Image {index}'**
  String imageNumber(Object index);

  /// No description provided for @thumbnail.
  ///
  /// In en, this message translates to:
  /// **'Thumbnail'**
  String get thumbnail;

  /// No description provided for @addImage.
  ///
  /// In en, this message translates to:
  /// **'Add image'**
  String get addImage;

  /// No description provided for @noAccountQuestion.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account yet?'**
  String get noAccountQuestion;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @registerSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Registration successful!'**
  String get registerSuccessfully;

  /// No description provided for @resendEmail.
  ///
  /// In en, this message translates to:
  /// **'Resend Email'**
  String get resendEmail;

  /// No description provided for @resentEmail.
  ///
  /// In en, this message translates to:
  /// **'Email has been resent'**
  String get resentEmail;

  /// No description provided for @errorSendEmail.
  ///
  /// In en, this message translates to:
  /// **'Error occurs while sending the email.'**
  String get errorSendEmail;

  /// No description provided for @fillAllFields.
  ///
  /// In en, this message translates to:
  /// **'All fields must be filled out.'**
  String get fillAllFields;

  /// No description provided for @notMatchPasswords.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get notMatchPasswords;

  /// No description provided for @atleast8CharPassword.
  ///
  /// In en, this message translates to:
  /// **'Passwords must be at least 8 characters long.'**
  String get atleast8CharPassword;

  /// No description provided for @errorRegister.
  ///
  /// In en, this message translates to:
  /// **'Error occurs during registration.'**
  String get errorRegister;

  /// No description provided for @verifcationFailed.
  ///
  /// In en, this message translates to:
  /// **'Verification failed.'**
  String get verifcationFailed;

  /// No description provided for @backtToHomepage.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backtToHomepage;

  /// No description provided for @verifyEmail.
  ///
  /// In en, this message translates to:
  /// **'E-Mail Verification'**
  String get verifyEmail;

  /// No description provided for @verifyingEmail.
  ///
  /// In en, this message translates to:
  /// **'Verifying E-Mail address...'**
  String get verifyingEmail;

  /// No description provided for @unknownError.
  ///
  /// In en, this message translates to:
  /// **'Unknown error'**
  String get unknownError;

  /// No description provided for @createdBy.
  ///
  /// In en, this message translates to:
  /// **'Created by'**
  String get createdBy;

  /// No description provided for @useSearch.
  ///
  /// In en, this message translates to:
  /// **'Use the search above.'**
  String get useSearch;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @places.
  ///
  /// In en, this message translates to:
  /// **'Cities (e.g. Hamburg)'**
  String get places;

  /// No description provided for @radiusInput.
  ///
  /// In en, this message translates to:
  /// **'Radius: {radius} km'**
  String radiusInput(Object radius);

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Zurücksetzen'**
  String get reset;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get darkMode;

  /// No description provided for @selectImage.
  ///
  /// In en, this message translates to:
  /// **'Select image'**
  String get selectImage;

  /// No description provided for @removeImage.
  ///
  /// In en, this message translates to:
  /// **'Remove image'**
  String get removeImage;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @aboutMe.
  ///
  /// In en, this message translates to:
  /// **'About me'**
  String get aboutMe;

  /// No description provided for @profileOf.
  ///
  /// In en, this message translates to:
  /// **'User {name}'**
  String profileOf(Object name);

  /// No description provided for @profileCouldNotBeLoaded.
  ///
  /// In en, this message translates to:
  /// **'Userprofile could not be loaded.'**
  String get profileCouldNotBeLoaded;

  /// No description provided for @created.
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get created;

  /// No description provided for @joined.
  ///
  /// In en, this message translates to:
  /// **'Joined'**
  String get joined;

  /// No description provided for @liked.
  ///
  /// In en, this message translates to:
  /// **'Liked'**
  String get liked;

  /// No description provided for @likesCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Likes'**
  String likesCount(Object count);

  /// No description provided for @joinsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Joins'**
  String joinsCount(Object count);

  /// No description provided for @createdLocations.
  ///
  /// In en, this message translates to:
  /// **'Created locations'**
  String get createdLocations;

  /// No description provided for @joinedLocations.
  ///
  /// In en, this message translates to:
  /// **'Joined locations'**
  String get joinedLocations;

  /// No description provided for @likedLocations.
  ///
  /// In en, this message translates to:
  /// **'Liked locations'**
  String get likedLocations;

  /// No description provided for @noDescriptionAvailable.
  ///
  /// In en, this message translates to:
  /// **'No description is not available.'**
  String get noDescriptionAvailable;

  /// No description provided for @enterNameSearch.
  ///
  /// In en, this message translates to:
  /// **'Please enter a name in the search bar.'**
  String get enterNameSearch;

  /// No description provided for @reload.
  ///
  /// In en, this message translates to:
  /// **'Reload'**
  String get reload;

  /// No description provided for @noEntriesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No entries are available.'**
  String get noEntriesAvailable;

  /// No description provided for @invalidLocationId.
  ///
  /// In en, this message translates to:
  /// **'Location id is not valid.'**
  String get invalidLocationId;

  /// No description provided for @notLocationOwnerNoEdit.
  ///
  /// In en, this message translates to:
  /// **'You are not the owner of the location and therefore cannot edit it.'**
  String get notLocationOwnerNoEdit;

  /// No description provided for @infoChooseStartAndEnddate.
  ///
  /// In en, this message translates to:
  /// **'Please select a start and an end date.'**
  String get infoChooseStartAndEnddate;

  /// No description provided for @infoEnddateBeforeStartdate.
  ///
  /// In en, this message translates to:
  /// **'The end date must not be before the start date.'**
  String get infoEnddateBeforeStartdate;

  /// No description provided for @errorUpdatingLocation.
  ///
  /// In en, this message translates to:
  /// **'Error while updating the location.'**
  String get errorUpdatingLocation;

  /// No description provided for @cropProfileImage.
  ///
  /// In en, this message translates to:
  /// **'Crop profile picture'**
  String get cropProfileImage;

  /// No description provided for @imageCouldNotBeProcessed.
  ///
  /// In en, this message translates to:
  /// **'The image could not be processed.'**
  String get imageCouldNotBeProcessed;

  /// No description provided for @errorCreateLocation.
  ///
  /// In en, this message translates to:
  /// **'Error occurs while creating location.'**
  String get errorCreateLocation;

  /// No description provided for @errorAddingImage.
  ///
  /// In en, this message translates to:
  /// **'Error occurs while adding an image.'**
  String get errorAddingImage;

  /// No description provided for @errorLikeLocation.
  ///
  /// In en, this message translates to:
  /// **'Error occurs while liking the locations.'**
  String get errorLikeLocation;

  /// No description provided for @errorJoinLocation.
  ///
  /// In en, this message translates to:
  /// **'Error occurs while joining the locations.'**
  String get errorJoinLocation;

  /// No description provided for @disabledLocationServices.
  ///
  /// In en, this message translates to:
  /// **'Location services are disabled.'**
  String get disabledLocationServices;

  /// No description provided for @deniedLocationPermission.
  ///
  /// In en, this message translates to:
  /// **'Location permission denied.'**
  String get deniedLocationPermission;

  /// No description provided for @noGpsAndNoFilterLocation.
  ///
  /// In en, this message translates to:
  /// **'No GPS positions available.'**
  String get noGpsAndNoFilterLocation;

  /// No description provided for @errorCallLocations.
  ///
  /// In en, this message translates to:
  /// **'Error occurs while retrieving locations.'**
  String get errorCallLocations;

  /// No description provided for @errorCallMoreLocations.
  ///
  /// In en, this message translates to:
  /// **'Error occurs while retrieving more locations.'**
  String get errorCallMoreLocations;

  /// No description provided for @errorLogin.
  ///
  /// In en, this message translates to:
  /// **'Error occurs while logging in.'**
  String get errorLogin;

  /// No description provided for @errorLogout.
  ///
  /// In en, this message translates to:
  /// **'Error occurs while logging out.'**
  String get errorLogout;

  /// No description provided for @errorSearch.
  ///
  /// In en, this message translates to:
  /// **'Error occurs while searching.'**
  String get errorSearch;

  /// No description provided for @errorCallUsers.
  ///
  /// In en, this message translates to:
  /// **'Error occurs while retrieving users.'**
  String get errorCallUsers;

  /// No description provided for @errorCallMoreUsers.
  ///
  /// In en, this message translates to:
  /// **'Error occurs while retrieving more users.'**
  String get errorCallMoreUsers;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'today'**
  String get today;

  /// No description provided for @tomorrow.
  ///
  /// In en, this message translates to:
  /// **'tomorrow'**
  String get tomorrow;

  /// No description provided for @dayAfterTomorrow.
  ///
  /// In en, this message translates to:
  /// **'day after tomorrow'**
  String get dayAfterTomorrow;

  /// No description provided for @nextWeek.
  ///
  /// In en, this message translates to:
  /// **'next week'**
  String get nextWeek;

  /// No description provided for @nextMonth.
  ///
  /// In en, this message translates to:
  /// **'Next month'**
  String get nextMonth;

  /// No description provided for @memberSince.
  ///
  /// In en, this message translates to:
  /// **'Member since {date}'**
  String memberSince(Object date);

  /// No description provided for @menu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// No description provided for @systemLanguage.
  ///
  /// In en, this message translates to:
  /// **'system language'**
  String get systemLanguage;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @german.
  ///
  /// In en, this message translates to:
  /// **'German'**
  String get german;

  /// No description provided for @noPhotoPermission.
  ///
  /// In en, this message translates to:
  /// **'No photo permission granted.'**
  String get noPhotoPermission;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @info.
  ///
  /// In en, this message translates to:
  /// **'Info'**
  String get info;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About {apptitle}'**
  String aboutApp(Object apptitle);

  /// No description provided for @aboutAppText.
  ///
  /// In en, this message translates to:
  /// **'{apptitle} brings people together through shared activities and exciting places.\nCreate meetups, discover events, and connect with new people nearby.'**
  String aboutAppText(Object apptitle);

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @serverVersion.
  ///
  /// In en, this message translates to:
  /// **'Server Version'**
  String get serverVersion;

  /// No description provided for @server.
  ///
  /// In en, this message translates to:
  /// **'Server'**
  String get server;

  /// No description provided for @database.
  ///
  /// In en, this message translates to:
  /// **'Database'**
  String get database;

  /// No description provided for @online.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get online;

  /// No description provided for @offline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get offline;

  /// No description provided for @homepage.
  ///
  /// In en, this message translates to:
  /// **'HomePage'**
  String get homepage;

  /// No description provided for @howToSupport.
  ///
  /// In en, this message translates to:
  /// **'How can we help you?'**
  String get howToSupport;

  /// No description provided for @sendEmail.
  ///
  /// In en, this message translates to:
  /// **'Write us an email or send a direct message to support.'**
  String get sendEmail;

  /// No description provided for @writeEmail.
  ///
  /// In en, this message translates to:
  /// **'Write an Email'**
  String get writeEmail;

  /// No description provided for @openMailProgramm.
  ///
  /// In en, this message translates to:
  /// **'Opens your email application with a pre-filled subject.'**
  String get openMailProgramm;

  /// No description provided for @contactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get contactSupport;

  /// No description provided for @messageSent.
  ///
  /// In en, this message translates to:
  /// **'Message sent successfully.'**
  String get messageSent;

  /// No description provided for @messageFailed.
  ///
  /// In en, this message translates to:
  /// **'Message could not be sent.'**
  String get messageFailed;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
