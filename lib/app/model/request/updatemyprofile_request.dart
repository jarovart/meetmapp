class UpdateMyProfileRequest {
  final String firstName;
  final String lastName;
  final String aboutMe;
  final bool removeProfileImage;

  UpdateMyProfileRequest({
    required this.firstName,
    required this.lastName,
    required this.aboutMe,
    required this.removeProfileImage, // = false
  });

  Map<String, dynamic> toMap() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "aboutMe": aboutMe,
      "removeProfileImage": removeProfileImage,
    };
  }
}
