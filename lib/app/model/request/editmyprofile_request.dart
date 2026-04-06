class EditMyProfileRequest {
  final String firstName;
  final String lastName;
  final String aboutMe;

  EditMyProfileRequest({
    required this.firstName,
    required this.lastName,
    required this.aboutMe,
  });

  Map<String, dynamic> toMap() {
    return {"firstName": firstName, "lastName": lastName, "aboutMe": aboutMe};
  }
}
