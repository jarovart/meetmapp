// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LocationDraft {

 String get title; String get description; String get address; DateTime get startDateTime; DateTime get endDateTime; LatLng get position; String get createdUsername;
/// Create a copy of LocationDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationDraftCopyWith<LocationDraft> get copyWith => _$LocationDraftCopyWithImpl<LocationDraft>(this as LocationDraft, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LocationDraft;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationDraft&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.address, _this.address) || other.address == _this.address)&&(identical(other.startDateTime, _this.startDateTime) || other.startDateTime == _this.startDateTime)&&(identical(other.endDateTime, _this.endDateTime) || other.endDateTime == _this.endDateTime)&&(identical(other.position, _this.position) || other.position == _this.position)&&(identical(other.createdUsername, _this.createdUsername) || other.createdUsername == _this.createdUsername));
}


@override
int get hashCode {
  final _this = this as LocationDraft;
  return Object.hash(runtimeType,_this.title,_this.description,_this.address,_this.startDateTime,_this.endDateTime,_this.position,_this.createdUsername);
}

@override
String toString() {
  final _this = this as LocationDraft;
  return 'LocationDraft(title: ${_this.title}, description: ${_this.description}, address: ${_this.address}, startDateTime: ${_this.startDateTime}, endDateTime: ${_this.endDateTime}, position: ${_this.position}, createdUsername: ${_this.createdUsername})';
}


}

/// @nodoc
abstract mixin class $LocationDraftCopyWith<$Res>  {
  factory $LocationDraftCopyWith(LocationDraft value, $Res Function(LocationDraft) _then) = _$LocationDraftCopyWithImpl;
@useResult
$Res call({
 String title, String description, String address, DateTime startDateTime, DateTime endDateTime, LatLng position, String createdUsername
});




}
/// @nodoc
class _$LocationDraftCopyWithImpl<$Res>
    implements $LocationDraftCopyWith<$Res> {
  _$LocationDraftCopyWithImpl(this._self, this._then);

  final LocationDraft _self;
  final $Res Function(LocationDraft) _then;

/// Create a copy of LocationDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? description = null,Object? address = null,Object? startDateTime = null,Object? endDateTime = null,Object? position = null,Object? createdUsername = null,}) {
  return _then(LocationDraft(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,startDateTime: null == startDateTime ? _self.startDateTime : startDateTime // ignore: cast_nullable_to_non_nullable
as DateTime,endDateTime: null == endDateTime ? _self.endDateTime : endDateTime // ignore: cast_nullable_to_non_nullable
as DateTime,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as LatLng,createdUsername: null == createdUsername ? _self.createdUsername : createdUsername // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LocationDraft].
extension LocationDraftPatterns on LocationDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocationDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocationDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocationDraft value)  $default,){
final _that = this;
switch (_that) {
case _LocationDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocationDraft value)?  $default,){
final _that = this;
switch (_that) {
case _LocationDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String description,  String address,  DateTime startDateTime,  DateTime endDateTime,  LatLng position,  String createdUsername)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocationDraft() when $default != null:
return $default(_that.title,_that.description,_that.address,_that.startDateTime,_that.endDateTime,_that.position,_that.createdUsername);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String description,  String address,  DateTime startDateTime,  DateTime endDateTime,  LatLng position,  String createdUsername)  $default,) {final _that = this;
switch (_that) {
case _LocationDraft():
return $default(_that.title,_that.description,_that.address,_that.startDateTime,_that.endDateTime,_that.position,_that.createdUsername);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String description,  String address,  DateTime startDateTime,  DateTime endDateTime,  LatLng position,  String createdUsername)?  $default,) {final _that = this;
switch (_that) {
case _LocationDraft() when $default != null:
return $default(_that.title,_that.description,_that.address,_that.startDateTime,_that.endDateTime,_that.position,_that.createdUsername);case _:
  return null;

}
}

}

/// @nodoc


class _LocationDraft implements LocationDraft {
  const _LocationDraft({required this.title, required this.description, required this.address, required this.startDateTime, required this.endDateTime, required this.position, required this.createdUsername});
  

@override final  String title;
@override final  String description;
@override final  String address;
@override final  DateTime startDateTime;
@override final  DateTime endDateTime;
@override final  LatLng position;
@override final  String createdUsername;

/// Create a copy of LocationDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationDraftCopyWith<_LocationDraft> get copyWith => __$LocationDraftCopyWithImpl<_LocationDraft>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationDraft&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.address, address) || other.address == address)&&(identical(other.startDateTime, startDateTime) || other.startDateTime == startDateTime)&&(identical(other.endDateTime, endDateTime) || other.endDateTime == endDateTime)&&(identical(other.position, position) || other.position == position)&&(identical(other.createdUsername, createdUsername) || other.createdUsername == createdUsername));
}


@override
int get hashCode {
    return Object.hash(runtimeType,title,description,address,startDateTime,endDateTime,position,createdUsername);
}

@override
String toString() {
    return 'LocationDraft(title: $title, description: $description, address: $address, startDateTime: $startDateTime, endDateTime: $endDateTime, position: $position, createdUsername: $createdUsername)';
}


}

/// @nodoc
abstract mixin class _$LocationDraftCopyWith<$Res> implements $LocationDraftCopyWith<$Res> {
  factory _$LocationDraftCopyWith(_LocationDraft value, $Res Function(_LocationDraft) _then) = __$LocationDraftCopyWithImpl;
@override @useResult
$Res call({
 String title, String description, String address, DateTime startDateTime, DateTime endDateTime, LatLng position, String createdUsername
});




}
/// @nodoc
class __$LocationDraftCopyWithImpl<$Res>
    implements _$LocationDraftCopyWith<$Res> {
  __$LocationDraftCopyWithImpl(this._self, this._then);

  final _LocationDraft _self;
  final $Res Function(_LocationDraft) _then;

/// Create a copy of LocationDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = null,Object? address = null,Object? startDateTime = null,Object? endDateTime = null,Object? position = null,Object? createdUsername = null,}) {
  return _then(_LocationDraft(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,startDateTime: null == startDateTime ? _self.startDateTime : startDateTime // ignore: cast_nullable_to_non_nullable
as DateTime,endDateTime: null == endDateTime ? _self.endDateTime : endDateTime // ignore: cast_nullable_to_non_nullable
as DateTime,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as LatLng,createdUsername: null == createdUsername ? _self.createdUsername : createdUsername // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
