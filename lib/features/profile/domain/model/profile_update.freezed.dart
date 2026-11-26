// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_update.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileUpdate {

 String get firstName; String get lastName; String get aboutMe; ProfileImageChange get imageChange;
/// Create a copy of ProfileUpdate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileUpdateCopyWith<ProfileUpdate> get copyWith => _$ProfileUpdateCopyWithImpl<ProfileUpdate>(this as ProfileUpdate, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ProfileUpdate;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileUpdate&&(identical(other.firstName, _this.firstName) || other.firstName == _this.firstName)&&(identical(other.lastName, _this.lastName) || other.lastName == _this.lastName)&&(identical(other.aboutMe, _this.aboutMe) || other.aboutMe == _this.aboutMe)&&(identical(other.imageChange, _this.imageChange) || other.imageChange == _this.imageChange));
}


@override
int get hashCode {
  final _this = this as ProfileUpdate;
  return Object.hash(runtimeType,_this.firstName,_this.lastName,_this.aboutMe,_this.imageChange);
}

@override
String toString() {
  final _this = this as ProfileUpdate;
  return 'ProfileUpdate(firstName: ${_this.firstName}, lastName: ${_this.lastName}, aboutMe: ${_this.aboutMe}, imageChange: ${_this.imageChange})';
}


}

/// @nodoc
abstract mixin class $ProfileUpdateCopyWith<$Res>  {
  factory $ProfileUpdateCopyWith(ProfileUpdate value, $Res Function(ProfileUpdate) _then) = _$ProfileUpdateCopyWithImpl;
@useResult
$Res call({
 String firstName, String lastName, String aboutMe, ProfileImageChange imageChange
});




}
/// @nodoc
class _$ProfileUpdateCopyWithImpl<$Res>
    implements $ProfileUpdateCopyWith<$Res> {
  _$ProfileUpdateCopyWithImpl(this._self, this._then);

  final ProfileUpdate _self;
  final $Res Function(ProfileUpdate) _then;

/// Create a copy of ProfileUpdate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? firstName = null,Object? lastName = null,Object? aboutMe = null,Object? imageChange = null,}) {
  return _then(ProfileUpdate(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,aboutMe: null == aboutMe ? _self.aboutMe : aboutMe // ignore: cast_nullable_to_non_nullable
as String,imageChange: null == imageChange ? _self.imageChange : imageChange // ignore: cast_nullable_to_non_nullable
as ProfileImageChange,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileUpdate].
extension ProfileUpdatePatterns on ProfileUpdate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileUpdate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileUpdate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileUpdate value)  $default,){
final _that = this;
switch (_that) {
case _ProfileUpdate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileUpdate value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileUpdate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String firstName,  String lastName,  String aboutMe,  ProfileImageChange imageChange)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileUpdate() when $default != null:
return $default(_that.firstName,_that.lastName,_that.aboutMe,_that.imageChange);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String firstName,  String lastName,  String aboutMe,  ProfileImageChange imageChange)  $default,) {final _that = this;
switch (_that) {
case _ProfileUpdate():
return $default(_that.firstName,_that.lastName,_that.aboutMe,_that.imageChange);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String firstName,  String lastName,  String aboutMe,  ProfileImageChange imageChange)?  $default,) {final _that = this;
switch (_that) {
case _ProfileUpdate() when $default != null:
return $default(_that.firstName,_that.lastName,_that.aboutMe,_that.imageChange);case _:
  return null;

}
}

}

/// @nodoc


class _ProfileUpdate implements ProfileUpdate {
  const _ProfileUpdate({required this.firstName, required this.lastName, required this.aboutMe, required this.imageChange});
  

@override final  String firstName;
@override final  String lastName;
@override final  String aboutMe;
@override final  ProfileImageChange imageChange;

/// Create a copy of ProfileUpdate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileUpdateCopyWith<_ProfileUpdate> get copyWith => __$ProfileUpdateCopyWithImpl<_ProfileUpdate>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileUpdate&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.aboutMe, aboutMe) || other.aboutMe == aboutMe)&&(identical(other.imageChange, imageChange) || other.imageChange == imageChange));
}


@override
int get hashCode {
    return Object.hash(runtimeType,firstName,lastName,aboutMe,imageChange);
}

@override
String toString() {
    return 'ProfileUpdate(firstName: $firstName, lastName: $lastName, aboutMe: $aboutMe, imageChange: $imageChange)';
}


}

/// @nodoc
abstract mixin class _$ProfileUpdateCopyWith<$Res> implements $ProfileUpdateCopyWith<$Res> {
  factory _$ProfileUpdateCopyWith(_ProfileUpdate value, $Res Function(_ProfileUpdate) _then) = __$ProfileUpdateCopyWithImpl;
@override @useResult
$Res call({
 String firstName, String lastName, String aboutMe, ProfileImageChange imageChange
});




}
/// @nodoc
class __$ProfileUpdateCopyWithImpl<$Res>
    implements _$ProfileUpdateCopyWith<$Res> {
  __$ProfileUpdateCopyWithImpl(this._self, this._then);

  final _ProfileUpdate _self;
  final $Res Function(_ProfileUpdate) _then;

/// Create a copy of ProfileUpdate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? firstName = null,Object? lastName = null,Object? aboutMe = null,Object? imageChange = null,}) {
  return _then(_ProfileUpdate(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,aboutMe: null == aboutMe ? _self.aboutMe : aboutMe // ignore: cast_nullable_to_non_nullable
as String,imageChange: null == imageChange ? _self.imageChange : imageChange // ignore: cast_nullable_to_non_nullable
as ProfileImageChange,
  ));
}


}

// dart format on
