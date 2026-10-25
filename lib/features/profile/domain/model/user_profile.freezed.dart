// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserProfile {

 int get id; String get username; String get firstName; String get lastName; String? get aboutMe; String? get email; DateTime? get createdAt; AppImage? get profileImage; int get joinedLocationCount; int get likedLocationCount; int? get createdLocationCount; AppSettings? get settings;
/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileCopyWith<UserProfile> get copyWith => _$UserProfileCopyWithImpl<UserProfile>(this as UserProfile, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as UserProfile;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfile&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.username, _this.username) || other.username == _this.username)&&(identical(other.firstName, _this.firstName) || other.firstName == _this.firstName)&&(identical(other.lastName, _this.lastName) || other.lastName == _this.lastName)&&(identical(other.aboutMe, _this.aboutMe) || other.aboutMe == _this.aboutMe)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.profileImage, _this.profileImage) || other.profileImage == _this.profileImage)&&(identical(other.joinedLocationCount, _this.joinedLocationCount) || other.joinedLocationCount == _this.joinedLocationCount)&&(identical(other.likedLocationCount, _this.likedLocationCount) || other.likedLocationCount == _this.likedLocationCount)&&(identical(other.createdLocationCount, _this.createdLocationCount) || other.createdLocationCount == _this.createdLocationCount)&&(identical(other.settings, _this.settings) || other.settings == _this.settings));
}


@override
int get hashCode {
  final _this = this as UserProfile;
  return Object.hash(runtimeType,_this.id,_this.username,_this.firstName,_this.lastName,_this.aboutMe,_this.email,_this.createdAt,_this.profileImage,_this.joinedLocationCount,_this.likedLocationCount,_this.createdLocationCount,_this.settings);
}

@override
String toString() {
  final _this = this as UserProfile;
  return 'UserProfile(id: ${_this.id}, username: ${_this.username}, firstName: ${_this.firstName}, lastName: ${_this.lastName}, aboutMe: ${_this.aboutMe}, email: ${_this.email}, createdAt: ${_this.createdAt}, profileImage: ${_this.profileImage}, joinedLocationCount: ${_this.joinedLocationCount}, likedLocationCount: ${_this.likedLocationCount}, createdLocationCount: ${_this.createdLocationCount}, settings: ${_this.settings})';
}


}

/// @nodoc
abstract mixin class $UserProfileCopyWith<$Res>  {
  factory $UserProfileCopyWith(UserProfile value, $Res Function(UserProfile) _then) = _$UserProfileCopyWithImpl;
@useResult
$Res call({
 int id, String username, String firstName, String lastName, String? aboutMe, String? email, DateTime? createdAt, AppImage? profileImage, int joinedLocationCount, int likedLocationCount, int? createdLocationCount, AppSettings? settings
});


$AppImageCopyWith<$Res>? get profileImage;$AppSettingsCopyWith<$Res>? get settings;

}
/// @nodoc
class _$UserProfileCopyWithImpl<$Res>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._self, this._then);

  final UserProfile _self;
  final $Res Function(UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? username = null,Object? firstName = null,Object? lastName = null,Object? aboutMe = freezed,Object? email = freezed,Object? createdAt = freezed,Object? profileImage = freezed,Object? joinedLocationCount = null,Object? likedLocationCount = null,Object? createdLocationCount = freezed,Object? settings = freezed,}) {
  return _then(UserProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,aboutMe: freezed == aboutMe ? _self.aboutMe : aboutMe // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as AppImage?,joinedLocationCount: null == joinedLocationCount ? _self.joinedLocationCount : joinedLocationCount // ignore: cast_nullable_to_non_nullable
as int,likedLocationCount: null == likedLocationCount ? _self.likedLocationCount : likedLocationCount // ignore: cast_nullable_to_non_nullable
as int,createdLocationCount: freezed == createdLocationCount ? _self.createdLocationCount : createdLocationCount // ignore: cast_nullable_to_non_nullable
as int?,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as AppSettings?,
  ));
}
/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppImageCopyWith<$Res>? get profileImage {
    if (_self.profileImage == null) {
    return null;
  }

  return $AppImageCopyWith<$Res>(_self.profileImage!, (value) {
    return _then(_self.copyWith(profileImage: value));
  });
}/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppSettingsCopyWith<$Res>? get settings {
    if (_self.settings == null) {
    return null;
  }

  return $AppSettingsCopyWith<$Res>(_self.settings!, (value) {
    return _then(_self.copyWith(settings: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserProfile].
extension UserProfilePatterns on UserProfile {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfile value)  $default,){
final _that = this;
switch (_that) {
case _UserProfile():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfile value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String username,  String firstName,  String lastName,  String? aboutMe,  String? email,  DateTime? createdAt,  AppImage? profileImage,  int joinedLocationCount,  int likedLocationCount,  int? createdLocationCount,  AppSettings? settings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.id,_that.username,_that.firstName,_that.lastName,_that.aboutMe,_that.email,_that.createdAt,_that.profileImage,_that.joinedLocationCount,_that.likedLocationCount,_that.createdLocationCount,_that.settings);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String username,  String firstName,  String lastName,  String? aboutMe,  String? email,  DateTime? createdAt,  AppImage? profileImage,  int joinedLocationCount,  int likedLocationCount,  int? createdLocationCount,  AppSettings? settings)  $default,) {final _that = this;
switch (_that) {
case _UserProfile():
return $default(_that.id,_that.username,_that.firstName,_that.lastName,_that.aboutMe,_that.email,_that.createdAt,_that.profileImage,_that.joinedLocationCount,_that.likedLocationCount,_that.createdLocationCount,_that.settings);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String username,  String firstName,  String lastName,  String? aboutMe,  String? email,  DateTime? createdAt,  AppImage? profileImage,  int joinedLocationCount,  int likedLocationCount,  int? createdLocationCount,  AppSettings? settings)?  $default,) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.id,_that.username,_that.firstName,_that.lastName,_that.aboutMe,_that.email,_that.createdAt,_that.profileImage,_that.joinedLocationCount,_that.likedLocationCount,_that.createdLocationCount,_that.settings);case _:
  return null;

}
}

}

/// @nodoc


class _UserProfile implements UserProfile {
  const _UserProfile({required this.id, required this.username, required this.firstName, required this.lastName, this.aboutMe, this.email, this.createdAt, this.profileImage, required this.joinedLocationCount, required this.likedLocationCount, this.createdLocationCount, this.settings});
  

@override final  int id;
@override final  String username;
@override final  String firstName;
@override final  String lastName;
@override final  String? aboutMe;
@override final  String? email;
@override final  DateTime? createdAt;
@override final  AppImage? profileImage;
@override final  int joinedLocationCount;
@override final  int likedLocationCount;
@override final  int? createdLocationCount;
@override final  AppSettings? settings;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileCopyWith<_UserProfile> get copyWith => __$UserProfileCopyWithImpl<_UserProfile>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.aboutMe, aboutMe) || other.aboutMe == aboutMe)&&(identical(other.email, email) || other.email == email)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage)&&(identical(other.joinedLocationCount, joinedLocationCount) || other.joinedLocationCount == joinedLocationCount)&&(identical(other.likedLocationCount, likedLocationCount) || other.likedLocationCount == likedLocationCount)&&(identical(other.createdLocationCount, createdLocationCount) || other.createdLocationCount == createdLocationCount)&&(identical(other.settings, settings) || other.settings == settings));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,username,firstName,lastName,aboutMe,email,createdAt,profileImage,joinedLocationCount,likedLocationCount,createdLocationCount,settings);
}

@override
String toString() {
    return 'UserProfile(id: $id, username: $username, firstName: $firstName, lastName: $lastName, aboutMe: $aboutMe, email: $email, createdAt: $createdAt, profileImage: $profileImage, joinedLocationCount: $joinedLocationCount, likedLocationCount: $likedLocationCount, createdLocationCount: $createdLocationCount, settings: $settings)';
}


}

/// @nodoc
abstract mixin class _$UserProfileCopyWith<$Res> implements $UserProfileCopyWith<$Res> {
  factory _$UserProfileCopyWith(_UserProfile value, $Res Function(_UserProfile) _then) = __$UserProfileCopyWithImpl;
@override @useResult
$Res call({
 int id, String username, String firstName, String lastName, String? aboutMe, String? email, DateTime? createdAt, AppImage? profileImage, int joinedLocationCount, int likedLocationCount, int? createdLocationCount, AppSettings? settings
});


@override $AppImageCopyWith<$Res>? get profileImage;@override $AppSettingsCopyWith<$Res>? get settings;

}
/// @nodoc
class __$UserProfileCopyWithImpl<$Res>
    implements _$UserProfileCopyWith<$Res> {
  __$UserProfileCopyWithImpl(this._self, this._then);

  final _UserProfile _self;
  final $Res Function(_UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? username = null,Object? firstName = null,Object? lastName = null,Object? aboutMe = freezed,Object? email = freezed,Object? createdAt = freezed,Object? profileImage = freezed,Object? joinedLocationCount = null,Object? likedLocationCount = null,Object? createdLocationCount = freezed,Object? settings = freezed,}) {
  return _then(_UserProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,aboutMe: freezed == aboutMe ? _self.aboutMe : aboutMe // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as AppImage?,joinedLocationCount: null == joinedLocationCount ? _self.joinedLocationCount : joinedLocationCount // ignore: cast_nullable_to_non_nullable
as int,likedLocationCount: null == likedLocationCount ? _self.likedLocationCount : likedLocationCount // ignore: cast_nullable_to_non_nullable
as int,createdLocationCount: freezed == createdLocationCount ? _self.createdLocationCount : createdLocationCount // ignore: cast_nullable_to_non_nullable
as int?,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as AppSettings?,
  ));
}

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppImageCopyWith<$Res>? get profileImage {
    if (_self.profileImage == null) {
    return null;
  }

  return $AppImageCopyWith<$Res>(_self.profileImage!, (value) {
    return _then(_self.copyWith(profileImage: value));
  });
}/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppSettingsCopyWith<$Res>? get settings {
    if (_self.settings == null) {
    return null;
  }

  return $AppSettingsCopyWith<$Res>(_self.settings!, (value) {
    return _then(_self.copyWith(settings: value));
  });
}
}

// dart format on
