// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_update.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LocationUpdate {

 int get id; String get title; String get description; String get address; LatLng get position; DateTime get startDateTime; DateTime get endDateTime; List<ImageEntry> get images;
/// Create a copy of LocationUpdate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationUpdateCopyWith<LocationUpdate> get copyWith => _$LocationUpdateCopyWithImpl<LocationUpdate>(this as LocationUpdate, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LocationUpdate;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationUpdate&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.address, _this.address) || other.address == _this.address)&&(identical(other.position, _this.position) || other.position == _this.position)&&(identical(other.startDateTime, _this.startDateTime) || other.startDateTime == _this.startDateTime)&&(identical(other.endDateTime, _this.endDateTime) || other.endDateTime == _this.endDateTime)&&const DeepCollectionEquality().equals(other.images, _this.images));
}


@override
int get hashCode {
  final _this = this as LocationUpdate;
  return Object.hash(runtimeType,_this.id,_this.title,_this.description,_this.address,_this.position,_this.startDateTime,_this.endDateTime,const DeepCollectionEquality().hash(_this.images));
}

@override
String toString() {
  final _this = this as LocationUpdate;
  return 'LocationUpdate(id: ${_this.id}, title: ${_this.title}, description: ${_this.description}, address: ${_this.address}, position: ${_this.position}, startDateTime: ${_this.startDateTime}, endDateTime: ${_this.endDateTime}, images: ${_this.images})';
}


}

/// @nodoc
abstract mixin class $LocationUpdateCopyWith<$Res>  {
  factory $LocationUpdateCopyWith(LocationUpdate value, $Res Function(LocationUpdate) _then) = _$LocationUpdateCopyWithImpl;
@useResult
$Res call({
 int id, String title, String description, String address, LatLng position, DateTime startDateTime, DateTime endDateTime, List<ImageEntry> images
});




}
/// @nodoc
class _$LocationUpdateCopyWithImpl<$Res>
    implements $LocationUpdateCopyWith<$Res> {
  _$LocationUpdateCopyWithImpl(this._self, this._then);

  final LocationUpdate _self;
  final $Res Function(LocationUpdate) _then;

/// Create a copy of LocationUpdate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? address = null,Object? position = null,Object? startDateTime = null,Object? endDateTime = null,Object? images = null,}) {
  return _then(LocationUpdate(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as LatLng,startDateTime: null == startDateTime ? _self.startDateTime : startDateTime // ignore: cast_nullable_to_non_nullable
as DateTime,endDateTime: null == endDateTime ? _self.endDateTime : endDateTime // ignore: cast_nullable_to_non_nullable
as DateTime,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<ImageEntry>,
  ));
}

}


/// Adds pattern-matching-related methods to [LocationUpdate].
extension LocationUpdatePatterns on LocationUpdate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocationUpdate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocationUpdate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocationUpdate value)  $default,){
final _that = this;
switch (_that) {
case _LocationUpdate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocationUpdate value)?  $default,){
final _that = this;
switch (_that) {
case _LocationUpdate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String description,  String address,  LatLng position,  DateTime startDateTime,  DateTime endDateTime,  List<ImageEntry> images)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocationUpdate() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.address,_that.position,_that.startDateTime,_that.endDateTime,_that.images);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String description,  String address,  LatLng position,  DateTime startDateTime,  DateTime endDateTime,  List<ImageEntry> images)  $default,) {final _that = this;
switch (_that) {
case _LocationUpdate():
return $default(_that.id,_that.title,_that.description,_that.address,_that.position,_that.startDateTime,_that.endDateTime,_that.images);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String description,  String address,  LatLng position,  DateTime startDateTime,  DateTime endDateTime,  List<ImageEntry> images)?  $default,) {final _that = this;
switch (_that) {
case _LocationUpdate() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.address,_that.position,_that.startDateTime,_that.endDateTime,_that.images);case _:
  return null;

}
}

}

/// @nodoc


class _LocationUpdate implements LocationUpdate {
  const _LocationUpdate({required this.id, required this.title, required this.description, required this.address, required this.position, required this.startDateTime, required this.endDateTime, required  List<ImageEntry> images}): _images = images;
  

@override final  int id;
@override final  String title;
@override final  String description;
@override final  String address;
@override final  LatLng position;
@override final  DateTime startDateTime;
@override final  DateTime endDateTime;
 final  List<ImageEntry> _images;
@override List<ImageEntry> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}


/// Create a copy of LocationUpdate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationUpdateCopyWith<_LocationUpdate> get copyWith => __$LocationUpdateCopyWithImpl<_LocationUpdate>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationUpdate&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.address, address) || other.address == address)&&(identical(other.position, position) || other.position == position)&&(identical(other.startDateTime, startDateTime) || other.startDateTime == startDateTime)&&(identical(other.endDateTime, endDateTime) || other.endDateTime == endDateTime)&&const DeepCollectionEquality().equals(other.images, _images));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,title,description,address,position,startDateTime,endDateTime,const DeepCollectionEquality().hash(_images));
}

@override
String toString() {
    return 'LocationUpdate(id: $id, title: $title, description: $description, address: $address, position: $position, startDateTime: $startDateTime, endDateTime: $endDateTime, images: $images)';
}


}

/// @nodoc
abstract mixin class _$LocationUpdateCopyWith<$Res> implements $LocationUpdateCopyWith<$Res> {
  factory _$LocationUpdateCopyWith(_LocationUpdate value, $Res Function(_LocationUpdate) _then) = __$LocationUpdateCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String description, String address, LatLng position, DateTime startDateTime, DateTime endDateTime, List<ImageEntry> images
});




}
/// @nodoc
class __$LocationUpdateCopyWithImpl<$Res>
    implements _$LocationUpdateCopyWith<$Res> {
  __$LocationUpdateCopyWithImpl(this._self, this._then);

  final _LocationUpdate _self;
  final $Res Function(_LocationUpdate) _then;

/// Create a copy of LocationUpdate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? address = null,Object? position = null,Object? startDateTime = null,Object? endDateTime = null,Object? images = null,}) {
  return _then(_LocationUpdate(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as LatLng,startDateTime: null == startDateTime ? _self.startDateTime : startDateTime // ignore: cast_nullable_to_non_nullable
as DateTime,endDateTime: null == endDateTime ? _self.endDateTime : endDateTime // ignore: cast_nullable_to_non_nullable
as DateTime,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<ImageEntry>,
  ));
}


}

// dart format on
