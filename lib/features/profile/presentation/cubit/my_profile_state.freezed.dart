// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MyProfileState {

 LoadStatus get status; UserProfile? get profile; AppFailure? get failure;
/// Create a copy of MyProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyProfileStateCopyWith<MyProfileState> get copyWith => _$MyProfileStateCopyWithImpl<MyProfileState>(this as MyProfileState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MyProfileState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyProfileState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.profile, _this.profile) || other.profile == _this.profile)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as MyProfileState;
  return Object.hash(runtimeType,_this.status,_this.profile,_this.failure);
}

@override
String toString() {
  final _this = this as MyProfileState;
  return 'MyProfileState(status: ${_this.status}, profile: ${_this.profile}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $MyProfileStateCopyWith<$Res>  {
  factory $MyProfileStateCopyWith(MyProfileState value, $Res Function(MyProfileState) _then) = _$MyProfileStateCopyWithImpl;
@useResult
$Res call({
 LoadStatus status, UserProfile? profile, AppFailure? failure
});


$UserProfileCopyWith<$Res>? get profile;

}
/// @nodoc
class _$MyProfileStateCopyWithImpl<$Res>
    implements $MyProfileStateCopyWith<$Res> {
  _$MyProfileStateCopyWithImpl(this._self, this._then);

  final MyProfileState _self;
  final $Res Function(MyProfileState) _then;

/// Create a copy of MyProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? profile = freezed,Object? failure = freezed,}) {
  return _then(MyProfileState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as UserProfile?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,
  ));
}
/// Create a copy of MyProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserProfileCopyWith<$Res>? get profile {
    if (_self.profile == null) {
    return null;
  }

  return $UserProfileCopyWith<$Res>(_self.profile!, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}


/// Adds pattern-matching-related methods to [MyProfileState].
extension MyProfileStatePatterns on MyProfileState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MyProfileState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MyProfileState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MyProfileState value)  $default,){
final _that = this;
switch (_that) {
case _MyProfileState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MyProfileState value)?  $default,){
final _that = this;
switch (_that) {
case _MyProfileState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoadStatus status,  UserProfile? profile,  AppFailure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MyProfileState() when $default != null:
return $default(_that.status,_that.profile,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoadStatus status,  UserProfile? profile,  AppFailure? failure)  $default,) {final _that = this;
switch (_that) {
case _MyProfileState():
return $default(_that.status,_that.profile,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoadStatus status,  UserProfile? profile,  AppFailure? failure)?  $default,) {final _that = this;
switch (_that) {
case _MyProfileState() when $default != null:
return $default(_that.status,_that.profile,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _MyProfileState implements MyProfileState {
  const _MyProfileState({this.status = LoadStatus.initial, this.profile, this.failure});
  

@override@JsonKey() final  LoadStatus status;
@override final  UserProfile? profile;
@override final  AppFailure? failure;

/// Create a copy of MyProfileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MyProfileStateCopyWith<_MyProfileState> get copyWith => __$MyProfileStateCopyWithImpl<_MyProfileState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MyProfileState&&(identical(other.status, status) || other.status == status)&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,profile,failure);
}

@override
String toString() {
    return 'MyProfileState(status: $status, profile: $profile, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$MyProfileStateCopyWith<$Res> implements $MyProfileStateCopyWith<$Res> {
  factory _$MyProfileStateCopyWith(_MyProfileState value, $Res Function(_MyProfileState) _then) = __$MyProfileStateCopyWithImpl;
@override @useResult
$Res call({
 LoadStatus status, UserProfile? profile, AppFailure? failure
});


@override $UserProfileCopyWith<$Res>? get profile;

}
/// @nodoc
class __$MyProfileStateCopyWithImpl<$Res>
    implements _$MyProfileStateCopyWith<$Res> {
  __$MyProfileStateCopyWithImpl(this._self, this._then);

  final _MyProfileState _self;
  final $Res Function(_MyProfileState) _then;

/// Create a copy of MyProfileState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? profile = freezed,Object? failure = freezed,}) {
  return _then(_MyProfileState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as UserProfile?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,
  ));
}

/// Create a copy of MyProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserProfileCopyWith<$Res>? get profile {
    if (_self.profile == null) {
    return null;
  }

  return $UserProfileCopyWith<$Res>(_self.profile!, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}

// dart format on
