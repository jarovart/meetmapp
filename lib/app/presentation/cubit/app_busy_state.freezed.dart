// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_busy_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppBusyState {

 bool get isBusy; String? get messageKey;
/// Create a copy of AppBusyState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppBusyStateCopyWith<AppBusyState> get copyWith => _$AppBusyStateCopyWithImpl<AppBusyState>(this as AppBusyState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AppBusyState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppBusyState&&(identical(other.isBusy, _this.isBusy) || other.isBusy == _this.isBusy)&&(identical(other.messageKey, _this.messageKey) || other.messageKey == _this.messageKey));
}


@override
int get hashCode {
  final _this = this as AppBusyState;
  return Object.hash(runtimeType,_this.isBusy,_this.messageKey);
}

@override
String toString() {
  final _this = this as AppBusyState;
  return 'AppBusyState(isBusy: ${_this.isBusy}, messageKey: ${_this.messageKey})';
}


}

/// @nodoc
abstract mixin class $AppBusyStateCopyWith<$Res>  {
  factory $AppBusyStateCopyWith(AppBusyState value, $Res Function(AppBusyState) _then) = _$AppBusyStateCopyWithImpl;
@useResult
$Res call({
 bool isBusy, String? messageKey
});




}
/// @nodoc
class _$AppBusyStateCopyWithImpl<$Res>
    implements $AppBusyStateCopyWith<$Res> {
  _$AppBusyStateCopyWithImpl(this._self, this._then);

  final AppBusyState _self;
  final $Res Function(AppBusyState) _then;

/// Create a copy of AppBusyState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isBusy = null,Object? messageKey = freezed,}) {
  return _then(AppBusyState(
isBusy: null == isBusy ? _self.isBusy : isBusy // ignore: cast_nullable_to_non_nullable
as bool,messageKey: freezed == messageKey ? _self.messageKey : messageKey // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppBusyState].
extension AppBusyStatePatterns on AppBusyState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppBusyState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppBusyState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppBusyState value)  $default,){
final _that = this;
switch (_that) {
case _AppBusyState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppBusyState value)?  $default,){
final _that = this;
switch (_that) {
case _AppBusyState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isBusy,  String? messageKey)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppBusyState() when $default != null:
return $default(_that.isBusy,_that.messageKey);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isBusy,  String? messageKey)  $default,) {final _that = this;
switch (_that) {
case _AppBusyState():
return $default(_that.isBusy,_that.messageKey);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isBusy,  String? messageKey)?  $default,) {final _that = this;
switch (_that) {
case _AppBusyState() when $default != null:
return $default(_that.isBusy,_that.messageKey);case _:
  return null;

}
}

}

/// @nodoc


class _AppBusyState implements AppBusyState {
  const _AppBusyState({this.isBusy = false, this.messageKey});
  

@override@JsonKey() final  bool isBusy;
@override final  String? messageKey;

/// Create a copy of AppBusyState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppBusyStateCopyWith<_AppBusyState> get copyWith => __$AppBusyStateCopyWithImpl<_AppBusyState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppBusyState&&(identical(other.isBusy, isBusy) || other.isBusy == isBusy)&&(identical(other.messageKey, messageKey) || other.messageKey == messageKey));
}


@override
int get hashCode {
    return Object.hash(runtimeType,isBusy,messageKey);
}

@override
String toString() {
    return 'AppBusyState(isBusy: $isBusy, messageKey: $messageKey)';
}


}

/// @nodoc
abstract mixin class _$AppBusyStateCopyWith<$Res> implements $AppBusyStateCopyWith<$Res> {
  factory _$AppBusyStateCopyWith(_AppBusyState value, $Res Function(_AppBusyState) _then) = __$AppBusyStateCopyWithImpl;
@override @useResult
$Res call({
 bool isBusy, String? messageKey
});




}
/// @nodoc
class __$AppBusyStateCopyWithImpl<$Res>
    implements _$AppBusyStateCopyWith<$Res> {
  __$AppBusyStateCopyWithImpl(this._self, this._then);

  final _AppBusyState _self;
  final $Res Function(_AppBusyState) _then;

/// Create a copy of AppBusyState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isBusy = null,Object? messageKey = freezed,}) {
  return _then(_AppBusyState(
isBusy: null == isBusy ? _self.isBusy : isBusy // ignore: cast_nullable_to_non_nullable
as bool,messageKey: freezed == messageKey ? _self.messageKey : messageKey // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
