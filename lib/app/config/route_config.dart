class RouteConfig {
  static const String homePageUrl = "/";
  static const String mapUrl = "/map";
  static const String locationListUrl = "/locationlist";
  static const String locationUrl = "/location";
  static const String locationCreateUrl = "/locationcreate";
  static const String userListUrl = "/userlist";
  static const String profileUrl = "/profile/:username";
  static const String myProfileUrl = "/profile/me";
  static const String profileEditUrl = "edit";
  static const String loginUrl = "/login";
  static const String registerUrl = "/register";
  static const String sendRegisterEmailUrl = "/sendregisteremail";
  static const String verifyRegisterEmailUrl = "/verifyemail";
  static const String forgotPasswordUrl = "/forgotpassword";
  static const String resetPasswordUrl = "/resetpassword";
  static const String settingsUrl = "/settings";

  // ─────────────────────────────────────────────
  // Testing Section
  // ─────────────────────────────────────────────
  static const String testShowModalUrl = "/test-showmodal";
  static const String testSliderGps = "/test-slidergps";

  // ─────────────────────────────────────────────
  // STATE
  // ─────────────────────────────────────────────

  static String getProfileUrl(String username) =>
      profileUrl.replaceFirst(':username', username);

  static String getLoginUrlWithRedirect(String redirect) =>
      Uri(path: loginUrl, queryParameters: {'redirect': redirect}).toString();

  static String? getRedirectUrlFromLogin(Uri uri) {
    final redirect = uri.queryParameters['redirect'];
    return (redirect != null && redirect.isNotEmpty)
        ? Uri.decodeComponent(redirect)
        : null;
  }

  static String getLocationCreateUrl({
    double? lat,
    double? lng,
    String? geoAddress,
  }) {
    final queryParams = <String, String>{};
    if (lat != null) queryParams['lat'] = lat.toString();
    if (lng != null) queryParams['lng'] = lng.toString();

    if (geoAddress != null && geoAddress.isNotEmpty) {
      queryParams['geoaddress'] = geoAddress;
    }

    final uri = Uri.parse(
      locationCreateUrl,
    ).replace(queryParameters: queryParams.isEmpty ? null : queryParams);

    return uri.toString();
  }
}
