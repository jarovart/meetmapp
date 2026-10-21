// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppStatus {

 String? get serverVersion; bool get serverOnline; bool? get databaseOnline;
/// Create a copy of AppStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppStatusCopyWith<AppStatus> get copyWith => _$AppStatusCopyWithImpl<AppStatus>(this as AppStatus, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AppStatus;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppStatus&&(identical(other.serverVersion, _this.serverVersion) || other.serverVersion == _this.serverVersion)&&(identical(other.serverOnline, _this.serverOnline) || other.serverOnline == _this.serverOnline)&&(identical(other.databaseOnline, _this.databaseOnline) || other.databaseOnline == _this.databaseOnline));
}


@override
int get hashCode {
  final _this = this as AppStatus;
  return Object.hash(runtimeType,_this.serverVersion,_this.serverOnline,_this.databaseOnline);
}

@override
String toString() {
  final _this = this as AppStatus;
  return 'AppStatus(serverVersion: ${_this.serverVersion}, serverOnline: ${_this.serverOnline}, databaseOnline: ${_this.databaseOnline})';
}


}

/// @nodoc
abstract mixin class $AppStatusCopyWith<$Res>  {
  factory $AppStatusCopyWith(AppStatus value, $Res Function(AppStatus) _then) = _$AppStatusCopyWithImpl;
@useResult
$Res call({
 String? serverVersion, bool serverOnline, bool? databaseOnline
});




}
/// @nodoc
class _$AppStatusCopyWithImpl<$Res>
    implements $AppStatusCopyWith<$Res> {
  _$AppStatusCopyWithImpl(this._self, this._then);

  final AppStatus _self;
  final $Res Function(AppStatus) _then;

/// Create a copy of AppStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? serverVersion = freezed,Object? serverOnline = null,Object? databaseOnline = freezed,}) {
  return _then(AppStatus(
serverVersion: freezed == serverVersion ? _self.serverVersion : serverVersion // ignore: cast_nullable_to_non_nullable
as String?,serverOnline: null == serverOnline ? _self.serverOnline : serverOnline // ignore: cast_nullable_to_non_nullable
as bool,databaseOnline: freezed == databaseOnline ? _self.databaseOnline : databaseOnline // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppStatus].
extension AppStatusPatterns on AppStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppStatus value)  $default,){
final _that = this;
switch (_that) {
case _AppStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppStatus value)?  $default,){
final _that = this;
switch (_that) {
case _AppStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? serverVersion,  bool serverOnline,  bool? databaseOnline)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppStatus() when $default != null:
return $default(_that.serverVersion,_that.serverOnline,_that.databaseOnline);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? serverVersion,  bool serverOnline,  bool? databaseOnline)  $default,) {final _that = this;
switch (_that) {
case _AppStatus():
return $default(_that.serverVersion,_that.serverOnline,_that.databaseOnline);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? serverVersion,  bool serverOnline,  bool? databaseOnline)?  $default,) {final _that = this;
switch (_that) {
case _AppStatus() when $default != null:
return $default(_that.serverVersion,_that.serverOnline,_that.databaseOnline);case _:
  return null;

}
}

}

/// @nodoc


class _AppStatus implements AppStatus {
  const _AppStatus({this.serverVersion, required this.serverOnline, this.databaseOnline});
  

@override final  String? serverVersion;
@override final  bool serverOnline;
@override final  bool? databaseOnline;

/// Create a copy of AppStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppStatusCopyWith<_AppStatus> get copyWith => __$AppStatusCopyWithImpl<_AppStatus>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppStatus&&(identical(other.serverVersion, serverVersion) || other.serverVersion == serverVersion)&&(identical(other.serverOnline, serverOnline) || other.serverOnline == serverOnline)&&(identical(other.databaseOnline, databaseOnline) || other.databaseOnline == databaseOnline));
}


@override
int get hashCode {
    return Object.hash(runtimeType,serverVersion,serverOnline,databaseOnline);
}

@override
String toString() {
    return 'AppStatus(serverVersion: $serverVersion, serverOnline: $serverOnline, databaseOnline: $databaseOnline)';
}


}

/// @nodoc
abstract mixin class _$AppStatusCopyWith<$Res> implements $AppStatusCopyWith<$Res> {
  factory _$AppStatusCopyWith(_AppStatus value, $Res Function(_AppStatus) _then) = __$AppStatusCopyWithImpl;
@override @useResult
$Res call({
 String? serverVersion, bool serverOnline, bool? databaseOnline
});




}
/// @nodoc
class __$AppStatusCopyWithImpl<$Res>
    implements _$AppStatusCopyWith<$Res> {
  __$AppStatusCopyWithImpl(this._self, this._then);

  final _AppStatus _self;
  final $Res Function(_AppStatus) _then;

/// Create a copy of AppStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? serverVersion = freezed,Object? serverOnline = null,Object? databaseOnline = freezed,}) {
  return _then(_AppStatus(
serverVersion: freezed == serverVersion ? _self.serverVersion : serverVersion // ignore: cast_nullable_to_non_nullable
as String?,serverOnline: null == serverOnline ? _self.serverOnline : serverOnline // ignore: cast_nullable_to_non_nullable
as bool,databaseOnline: freezed == databaseOnline ? _self.databaseOnline : databaseOnline // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
