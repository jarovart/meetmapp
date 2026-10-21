// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'info_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InfoState {

 LoadStatus get status; AppStatus? get appStatus; AppFailure? get failure;
/// Create a copy of InfoState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InfoStateCopyWith<InfoState> get copyWith => _$InfoStateCopyWithImpl<InfoState>(this as InfoState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as InfoState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InfoState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.appStatus, _this.appStatus) || other.appStatus == _this.appStatus)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as InfoState;
  return Object.hash(runtimeType,_this.status,_this.appStatus,_this.failure);
}

@override
String toString() {
  final _this = this as InfoState;
  return 'InfoState(status: ${_this.status}, appStatus: ${_this.appStatus}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $InfoStateCopyWith<$Res>  {
  factory $InfoStateCopyWith(InfoState value, $Res Function(InfoState) _then) = _$InfoStateCopyWithImpl;
@useResult
$Res call({
 LoadStatus status, AppStatus? appStatus, AppFailure? failure
});


$AppStatusCopyWith<$Res>? get appStatus;

}
/// @nodoc
class _$InfoStateCopyWithImpl<$Res>
    implements $InfoStateCopyWith<$Res> {
  _$InfoStateCopyWithImpl(this._self, this._then);

  final InfoState _self;
  final $Res Function(InfoState) _then;

/// Create a copy of InfoState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? appStatus = freezed,Object? failure = freezed,}) {
  return _then(InfoState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,appStatus: freezed == appStatus ? _self.appStatus : appStatus // ignore: cast_nullable_to_non_nullable
as AppStatus?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,
  ));
}
/// Create a copy of InfoState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppStatusCopyWith<$Res>? get appStatus {
    if (_self.appStatus == null) {
    return null;
  }

  return $AppStatusCopyWith<$Res>(_self.appStatus!, (value) {
    return _then(_self.copyWith(appStatus: value));
  });
}
}


/// Adds pattern-matching-related methods to [InfoState].
extension InfoStatePatterns on InfoState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InfoState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InfoState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InfoState value)  $default,){
final _that = this;
switch (_that) {
case _InfoState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InfoState value)?  $default,){
final _that = this;
switch (_that) {
case _InfoState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoadStatus status,  AppStatus? appStatus,  AppFailure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InfoState() when $default != null:
return $default(_that.status,_that.appStatus,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoadStatus status,  AppStatus? appStatus,  AppFailure? failure)  $default,) {final _that = this;
switch (_that) {
case _InfoState():
return $default(_that.status,_that.appStatus,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoadStatus status,  AppStatus? appStatus,  AppFailure? failure)?  $default,) {final _that = this;
switch (_that) {
case _InfoState() when $default != null:
return $default(_that.status,_that.appStatus,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _InfoState implements InfoState {
  const _InfoState({this.status = LoadStatus.initial, this.appStatus, this.failure});
  

@override@JsonKey() final  LoadStatus status;
@override final  AppStatus? appStatus;
@override final  AppFailure? failure;

/// Create a copy of InfoState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InfoStateCopyWith<_InfoState> get copyWith => __$InfoStateCopyWithImpl<_InfoState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _InfoState&&(identical(other.status, status) || other.status == status)&&(identical(other.appStatus, appStatus) || other.appStatus == appStatus)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,appStatus,failure);
}

@override
String toString() {
    return 'InfoState(status: $status, appStatus: $appStatus, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$InfoStateCopyWith<$Res> implements $InfoStateCopyWith<$Res> {
  factory _$InfoStateCopyWith(_InfoState value, $Res Function(_InfoState) _then) = __$InfoStateCopyWithImpl;
@override @useResult
$Res call({
 LoadStatus status, AppStatus? appStatus, AppFailure? failure
});


@override $AppStatusCopyWith<$Res>? get appStatus;

}
/// @nodoc
class __$InfoStateCopyWithImpl<$Res>
    implements _$InfoStateCopyWith<$Res> {
  __$InfoStateCopyWithImpl(this._self, this._then);

  final _InfoState _self;
  final $Res Function(_InfoState) _then;

/// Create a copy of InfoState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? appStatus = freezed,Object? failure = freezed,}) {
  return _then(_InfoState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,appStatus: freezed == appStatus ? _self.appStatus : appStatus // ignore: cast_nullable_to_non_nullable
as AppStatus?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,
  ));
}

/// Create a copy of InfoState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppStatusCopyWith<$Res>? get appStatus {
    if (_self.appStatus == null) {
    return null;
  }

  return $AppStatusCopyWith<$Res>(_self.appStatus!, (value) {
    return _then(_self.copyWith(appStatus: value));
  });
}
}

// dart format on
