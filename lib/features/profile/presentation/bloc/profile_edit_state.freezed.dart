// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_edit_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileEditState {

 UserProfile? get original; LoadStatus get status; String get firstName; String get lastName; String get aboutMe; ProfileImageChange get imageChange; bool get isProcessingImage; bool get isSaving; bool get isSaved; AppFailure? get failure;
/// Create a copy of ProfileEditState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileEditStateCopyWith<ProfileEditState> get copyWith => _$ProfileEditStateCopyWithImpl<ProfileEditState>(this as ProfileEditState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ProfileEditState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileEditState&&(identical(other.original, _this.original) || other.original == _this.original)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.firstName, _this.firstName) || other.firstName == _this.firstName)&&(identical(other.lastName, _this.lastName) || other.lastName == _this.lastName)&&(identical(other.aboutMe, _this.aboutMe) || other.aboutMe == _this.aboutMe)&&(identical(other.imageChange, _this.imageChange) || other.imageChange == _this.imageChange)&&(identical(other.isProcessingImage, _this.isProcessingImage) || other.isProcessingImage == _this.isProcessingImage)&&(identical(other.isSaving, _this.isSaving) || other.isSaving == _this.isSaving)&&(identical(other.isSaved, _this.isSaved) || other.isSaved == _this.isSaved)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as ProfileEditState;
  return Object.hash(runtimeType,_this.original,_this.status,_this.firstName,_this.lastName,_this.aboutMe,_this.imageChange,_this.isProcessingImage,_this.isSaving,_this.isSaved,_this.failure);
}

@override
String toString() {
  final _this = this as ProfileEditState;
  return 'ProfileEditState(original: ${_this.original}, status: ${_this.status}, firstName: ${_this.firstName}, lastName: ${_this.lastName}, aboutMe: ${_this.aboutMe}, imageChange: ${_this.imageChange}, isProcessingImage: ${_this.isProcessingImage}, isSaving: ${_this.isSaving}, isSaved: ${_this.isSaved}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $ProfileEditStateCopyWith<$Res>  {
  factory $ProfileEditStateCopyWith(ProfileEditState value, $Res Function(ProfileEditState) _then) = _$ProfileEditStateCopyWithImpl;
@useResult
$Res call({
 UserProfile? original, LoadStatus status, String firstName, String lastName, String aboutMe, ProfileImageChange imageChange, bool isProcessingImage, bool isSaving, bool isSaved, AppFailure? failure
});


$UserProfileCopyWith<$Res>? get original;

}
/// @nodoc
class _$ProfileEditStateCopyWithImpl<$Res>
    implements $ProfileEditStateCopyWith<$Res> {
  _$ProfileEditStateCopyWithImpl(this._self, this._then);

  final ProfileEditState _self;
  final $Res Function(ProfileEditState) _then;

/// Create a copy of ProfileEditState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? original = freezed,Object? status = null,Object? firstName = null,Object? lastName = null,Object? aboutMe = null,Object? imageChange = null,Object? isProcessingImage = null,Object? isSaving = null,Object? isSaved = null,Object? failure = freezed,}) {
  return _then(ProfileEditState(
original: freezed == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as UserProfile?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,aboutMe: null == aboutMe ? _self.aboutMe : aboutMe // ignore: cast_nullable_to_non_nullable
as String,imageChange: null == imageChange ? _self.imageChange : imageChange // ignore: cast_nullable_to_non_nullable
as ProfileImageChange,isProcessingImage: null == isProcessingImage ? _self.isProcessingImage : isProcessingImage // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isSaved: null == isSaved ? _self.isSaved : isSaved // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,
  ));
}
/// Create a copy of ProfileEditState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserProfileCopyWith<$Res>? get original {
    if (_self.original == null) {
    return null;
  }

  return $UserProfileCopyWith<$Res>(_self.original!, (value) {
    return _then(_self.copyWith(original: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProfileEditState].
extension ProfileEditStatePatterns on ProfileEditState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileEditState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileEditState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileEditState value)  $default,){
final _that = this;
switch (_that) {
case _ProfileEditState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileEditState value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileEditState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UserProfile? original,  LoadStatus status,  String firstName,  String lastName,  String aboutMe,  ProfileImageChange imageChange,  bool isProcessingImage,  bool isSaving,  bool isSaved,  AppFailure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileEditState() when $default != null:
return $default(_that.original,_that.status,_that.firstName,_that.lastName,_that.aboutMe,_that.imageChange,_that.isProcessingImage,_that.isSaving,_that.isSaved,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UserProfile? original,  LoadStatus status,  String firstName,  String lastName,  String aboutMe,  ProfileImageChange imageChange,  bool isProcessingImage,  bool isSaving,  bool isSaved,  AppFailure? failure)  $default,) {final _that = this;
switch (_that) {
case _ProfileEditState():
return $default(_that.original,_that.status,_that.firstName,_that.lastName,_that.aboutMe,_that.imageChange,_that.isProcessingImage,_that.isSaving,_that.isSaved,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UserProfile? original,  LoadStatus status,  String firstName,  String lastName,  String aboutMe,  ProfileImageChange imageChange,  bool isProcessingImage,  bool isSaving,  bool isSaved,  AppFailure? failure)?  $default,) {final _that = this;
switch (_that) {
case _ProfileEditState() when $default != null:
return $default(_that.original,_that.status,_that.firstName,_that.lastName,_that.aboutMe,_that.imageChange,_that.isProcessingImage,_that.isSaving,_that.isSaved,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _ProfileEditState extends ProfileEditState {
  const _ProfileEditState({this.original, this.status = LoadStatus.initial, this.firstName = '', this.lastName = '', this.aboutMe = '', this.imageChange = const KeepImage(), this.isProcessingImage = false, this.isSaving = false, this.isSaved = false, this.failure}): super._();
  

@override final  UserProfile? original;
@override@JsonKey() final  LoadStatus status;
@override@JsonKey() final  String firstName;
@override@JsonKey() final  String lastName;
@override@JsonKey() final  String aboutMe;
@override@JsonKey() final  ProfileImageChange imageChange;
@override@JsonKey() final  bool isProcessingImage;
@override@JsonKey() final  bool isSaving;
@override@JsonKey() final  bool isSaved;
@override final  AppFailure? failure;

/// Create a copy of ProfileEditState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileEditStateCopyWith<_ProfileEditState> get copyWith => __$ProfileEditStateCopyWithImpl<_ProfileEditState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileEditState&&(identical(other.original, original) || other.original == original)&&(identical(other.status, status) || other.status == status)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.aboutMe, aboutMe) || other.aboutMe == aboutMe)&&(identical(other.imageChange, imageChange) || other.imageChange == imageChange)&&(identical(other.isProcessingImage, isProcessingImage) || other.isProcessingImage == isProcessingImage)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.isSaved, isSaved) || other.isSaved == isSaved)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,original,status,firstName,lastName,aboutMe,imageChange,isProcessingImage,isSaving,isSaved,failure);
}

@override
String toString() {
    return 'ProfileEditState(original: $original, status: $status, firstName: $firstName, lastName: $lastName, aboutMe: $aboutMe, imageChange: $imageChange, isProcessingImage: $isProcessingImage, isSaving: $isSaving, isSaved: $isSaved, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$ProfileEditStateCopyWith<$Res> implements $ProfileEditStateCopyWith<$Res> {
  factory _$ProfileEditStateCopyWith(_ProfileEditState value, $Res Function(_ProfileEditState) _then) = __$ProfileEditStateCopyWithImpl;
@override @useResult
$Res call({
 UserProfile? original, LoadStatus status, String firstName, String lastName, String aboutMe, ProfileImageChange imageChange, bool isProcessingImage, bool isSaving, bool isSaved, AppFailure? failure
});


@override $UserProfileCopyWith<$Res>? get original;

}
/// @nodoc
class __$ProfileEditStateCopyWithImpl<$Res>
    implements _$ProfileEditStateCopyWith<$Res> {
  __$ProfileEditStateCopyWithImpl(this._self, this._then);

  final _ProfileEditState _self;
  final $Res Function(_ProfileEditState) _then;

/// Create a copy of ProfileEditState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? original = freezed,Object? status = null,Object? firstName = null,Object? lastName = null,Object? aboutMe = null,Object? imageChange = null,Object? isProcessingImage = null,Object? isSaving = null,Object? isSaved = null,Object? failure = freezed,}) {
  return _then(_ProfileEditState(
original: freezed == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as UserProfile?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,aboutMe: null == aboutMe ? _self.aboutMe : aboutMe // ignore: cast_nullable_to_non_nullable
as String,imageChange: null == imageChange ? _self.imageChange : imageChange // ignore: cast_nullable_to_non_nullable
as ProfileImageChange,isProcessingImage: null == isProcessingImage ? _self.isProcessingImage : isProcessingImage // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isSaved: null == isSaved ? _self.isSaved : isSaved // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,
  ));
}

/// Create a copy of ProfileEditState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserProfileCopyWith<$Res>? get original {
    if (_self.original == null) {
    return null;
  }

  return $UserProfileCopyWith<$Res>(_self.original!, (value) {
    return _then(_self.copyWith(original: value));
  });
}
}

// dart format on
