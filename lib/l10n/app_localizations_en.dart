// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get invalidVerifyLink => 'Invalid verificationlink';

  @override
  String get login => 'Login';

  @override
  String get loginNow => 'Log in now';

  @override
  String get locations => 'Locations';

  @override
  String get edit => 'Edit';

  @override
  String get editLocation => 'Edit location ';

  @override
  String get users => 'User';

  @override
  String get friends => 'Friends';

  @override
  String get favourites => 'favourites';

  @override
  String get logout => 'log out';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get design => 'Customize theme';

  @override
  String choosedLabel(Object label) {
    return 'Chosed $label';
  }

  @override
  String locationOf(Object title) {
    return 'Location of $title';
  }

  @override
  String get choosePerfectPlace => 'Choose the perfect place';

  @override
  String get longPressSetPostion =>
      'Long press anywhere on the map to drop a pin and set the location.';

  @override
  String get searching => 'Searching...';

  @override
  String get loading => 'Loading...';

  @override
  String get uploading => 'Uploading...';

  @override
  String get location => 'Location';

  @override
  String get noLocationsFound => 'Location not found.';

  @override
  String get locationCouldNotBeLoaded => 'Location could not be loaded.';

  @override
  String get createLocation => 'Create a location';

  @override
  String createLocationAs(Object username) {
    return 'Create a location as $username';
  }

  @override
  String get saveLocation => 'Save this location';

  @override
  String get navigateToLocation => 'Navigate to Location';

  @override
  String get openLocation => 'Open location';

  @override
  String get validEmailHint => 'Please use a valid E-Mail.';

  @override
  String get forgotPassword => 'Forgot password';

  @override
  String get linkSendToEmail => 'A link has been sent to your e-mail.';

  @override
  String get defaultErrorMessage =>
      'Something went wrong. Please try again later.';

  @override
  String get loginToProceed => 'Please log in for proceeding.';

  @override
  String get serverNotReachable =>
      'Server is not reachable. Please check the connection.';

  @override
  String get invalidInput => 'Input is not valid.';

  @override
  String get notLoggedInLoginAgain =>
      'You are not logged in. Please log in again.';

  @override
  String get noAuthorization => 'You are not authorized for this action';

  @override
  String get requestedDataNotFound => 'The requested data was not found.';

  @override
  String get actionCouldNotBePerformed => 'Action could not be performed.';

  @override
  String get linkExpired => 'The Link has been expired.';

  @override
  String get fileTooLarge => 'The uploaded file is too large.';

  @override
  String get unsupportedFileType => 'This file format is not supported.';

  @override
  String get dataCouldNotBeProcessed => 'The data could not be processed.';

  @override
  String get tooManyRequests => 'Too many requests were sent.';

  @override
  String get serverError =>
      'An error occurred on the server. Please try again later.';

  @override
  String get imageNotFound => 'Image not found.';

  @override
  String get invalidCredentials => 'Invalid credentials.';

  @override
  String get invalidLink => 'Invalid credentials.';

  @override
  String get linkAlreadyUsed => 'The link has already been used.';

  @override
  String get noAccessLocation => 'No access to the location.';

  @override
  String get tokenExpired => 'Login token has expired.';

  @override
  String get tokenInvalid => 'The login token is invalid.';

  @override
  String get tokenMissing => 'The token was not transferred.';

  @override
  String get userNotFound => 'User not found.';

  @override
  String get usersNotFound => 'No users could be found.';

  @override
  String get emailAlreadyExists => 'E-Mail already exists.';

  @override
  String get emailInvalid => 'The E-Mail is invalid.';

  @override
  String get emailRequired => 'E-Mail is required.';

  @override
  String get passwordRequired => 'E-Mail is required.';

  @override
  String get passwordTooShort => 'The password is too short.';

  @override
  String get usernameAlreadyExists => 'The username already exists.';

  @override
  String get loginAgain => 'Please log in again.';

  @override
  String get profileUpdateFailed => 'Profile could not be updated.';

  @override
  String get profileImageTooLarge => 'The profile picture is too large.';

  @override
  String get profileImageInvalidFormat =>
      'The profile picture has an invalid format.';

  @override
  String get contentIsNotPublic => 'This content is not public.';

  @override
  String get errorPasswordReset => 'Error occurs while resetting password.';

  @override
  String waitForXSeconds(Object cooldown) {
    return 'Please wait ($cooldown s)';
  }

  @override
  String get sendLink => 'Send link';

  @override
  String get email => 'E-Mail';

  @override
  String get username => 'Username';

  @override
  String get firstName => 'Firstname';

  @override
  String get familyName => 'Familyname';

  @override
  String get password => 'Password';

  @override
  String get newPassword => 'New Password';

  @override
  String get setNewPassword => 'Set new Password';

  @override
  String get changedPassword => 'Password changed! ✅';

  @override
  String get repeatPassword => 'Repeat password';

  @override
  String get forgotPasswordQuestion => 'Forgot password?';

  @override
  String get savePassword => 'Save password';

  @override
  String get save => 'Save';

  @override
  String get title => 'Title';

  @override
  String get enterTitle => 'Enter Title';

  @override
  String get titleNotEmpty => 'Title cannot be empty.';

  @override
  String get description => 'Description';

  @override
  String get enterDescription => 'Enter Description';

  @override
  String get missingDescription => 'Description is missing.';

  @override
  String get chooseStartdate => 'Choose start date';

  @override
  String get noChosedStartdate => 'No start date selected';

  @override
  String displayStartdate(Object time) {
    return 'Begin: $time';
  }

  @override
  String get chooseEnddate => 'Choose end date';

  @override
  String get noChosedEnddate => 'No end date selected';

  @override
  String displayEnddate(Object time) {
    return 'End: $time';
  }

  @override
  String get address => 'Address';

  @override
  String get resetAddress => 'Reset address';

  @override
  String get enterAddress => 'Enter address';

  @override
  String get missingAddress => 'Address missing';

  @override
  String get position => 'Position (lat, lng)';

  @override
  String positionWithCoordinates(Object latitude, Object longitude) {
    return 'Position:\nLatitude: $latitude\nLongitude: $longitude';
  }

  @override
  String get positionCopied => 'Position has been copied!';

  @override
  String get images => 'Pictures';

  @override
  String imageNumber(Object index) {
    return 'Image $index';
  }

  @override
  String get thumbnail => 'Thumbnail';

  @override
  String get addImage => 'Add image';

  @override
  String get noAccountQuestion => 'Don\'t have an account yet?';

  @override
  String get register => 'Register';

  @override
  String get registerSuccessfully => 'Registration successful!';

  @override
  String get resendEmail => 'Resend Email';

  @override
  String get resentEmail => 'Email has been resent';

  @override
  String get errorSendEmail => 'Error occurs while sending the email.';

  @override
  String get fillAllFields => 'All fields must be filled out.';

  @override
  String get notMatchPasswords => 'Passwords do not match.';

  @override
  String get atleast8CharPassword =>
      'Passwords must be at least 8 characters long.';

  @override
  String get errorRegister => 'Error occurs during registration.';

  @override
  String get verifcationFailed => 'Verification failed.';

  @override
  String get backtToHomepage => 'Back to Home';

  @override
  String get verifyEmail => 'E-Mail Verification';

  @override
  String get verifyingEmail => 'Verifying E-Mail address...';

  @override
  String get unknownError => 'Unknown error';

  @override
  String get createdBy => 'Created by';

  @override
  String get useSearch => 'Use the search above.';

  @override
  String get filter => 'Filter';

  @override
  String get close => 'Close';

  @override
  String get places => 'Cities (e.g. Hamburg)';

  @override
  String radiusInput(Object radius) {
    return 'Radius: $radius km';
  }

  @override
  String get reset => 'Zurücksetzen';

  @override
  String get apply => 'Apply';

  @override
  String get darkMode => 'Dark mode';

  @override
  String get selectImage => 'Select image';

  @override
  String get removeImage => 'Remove image';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get aboutMe => 'About me';

  @override
  String profileOf(Object name) {
    return 'User $name';
  }

  @override
  String get profileCouldNotBeLoaded => 'Userprofile could not be loaded.';

  @override
  String get created => 'Created';

  @override
  String get joined => 'Joined';

  @override
  String get liked => 'Liked';

  @override
  String likesCount(Object count) {
    return '$count Likes';
  }

  @override
  String joinsCount(Object count) {
    return '$count Joins';
  }

  @override
  String get createdLocations => 'Created locations';

  @override
  String get joinedLocations => 'Joined locations';

  @override
  String get likedLocations => 'Liked locations';

  @override
  String get noDescriptionAvailable => 'No description is not available.';

  @override
  String get enterNameSearch => 'Please enter a name in the search bar.';

  @override
  String get reload => 'Reload';

  @override
  String get noEntriesAvailable => 'No entries are available.';

  @override
  String get invalidLocationId => 'Location id is not valid.';

  @override
  String get notLocationOwnerNoEdit =>
      'You are not the owner of the location and therefore cannot edit it.';

  @override
  String get infoChooseStartAndEnddate =>
      'Please select a start and an end date.';

  @override
  String get infoEnddateBeforeStartdate =>
      'The end date must not be before the start date.';

  @override
  String get errorUpdatingLocation => 'Error while updating the location.';

  @override
  String get cropProfileImage => 'Crop profile picture';

  @override
  String get imageCouldNotBeProcessed => 'The image could not be processed.';

  @override
  String get errorCreateLocation => 'Error occurs while creating location.';

  @override
  String get errorAddingImage => 'Error occurs while adding an image.';

  @override
  String get errorLikeLocation => 'Error occurs while liking the locations.';

  @override
  String get errorJoinLocation => 'Error occurs while joining the locations.';

  @override
  String get disabledLocationServices => 'Location services are disabled.';

  @override
  String get deniedLocationPermission => 'Location permission denied.';

  @override
  String get noGpsAndNoFilterLocation => 'No GPS positions available.';

  @override
  String get errorCallLocations => 'Error occurs while retrieving locations.';

  @override
  String get errorCallMoreLocations =>
      'Error occurs while retrieving more locations.';

  @override
  String get errorLogin => 'Error occurs while logging in.';

  @override
  String get errorLogout => 'Error occurs while logging out.';

  @override
  String get errorSearch => 'Error occurs while searching.';

  @override
  String get errorCallUsers => 'Error occurs while retrieving users.';

  @override
  String get errorCallMoreUsers => 'Error occurs while retrieving more users.';
}
