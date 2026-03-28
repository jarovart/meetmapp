import 'package:flutter/material.dart';
import 'package:meetmaap/app/model/responses/userfull_response.dart';
import 'package:meetmaap/app/model/utils/image_utils.dart';

class UserMyProfileResponse extends UserFullResponse {
  final String email;
  final DateTime createdAt;
  final int createdLocations;

  UserMyProfileResponse({
    required super.id,
    required super.username,
    required super.firstName,
    required super.lastName,
    required super.profileUrl,
    required super.aboutMe,
    required super.likedLocationCount,
    required super.joinedLocationCount,
    required this.email,
    required this.createdAt,
    required this.createdLocations,
  });

  factory UserMyProfileResponse.fromMap(Map<String, dynamic> map) {
    debugPrint(map['profileUrl']?.toString() ?? "no profile url");
    return UserMyProfileResponse(
      id: map['id'] as int,
      username: map['username'] as String,
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      profileUrl: ImageUtils.toAbsolute(map['profileUrl']?.toString() ?? ''),
      aboutMe: map['aboutMe'] ?? '',
      likedLocationCount: map['likedLocationCount'] ?? 0,
      joinedLocationCount: map['joinedLocationCount'] ?? 0,
      email: map['email'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
      createdLocations: map['createdLocations'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'profileUrl': profileUrl,
      'aboutMe': aboutMe,
      'likedLocationCount': likedLocationCount,
      'joinedLocationCount': joinedLocationCount,
      'email': email,
      'createdAt': createdAt.toIso8601String(),
      'createdLocations': createdLocations,
    };
  }
}
