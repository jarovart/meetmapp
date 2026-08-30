// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LocationDetail {

 Location get location; List<AppImage> get images;
/// Create a copy of LocationDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationDetailCopyWith<LocationDetail> get copyWith => _$LocationDetailCopyWithImpl<LocationDetail>(this as LocationDetail, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationDetail&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other.images, images));
}


@override
int get hashCode => Object.hash(runtimeType,location,const DeepCollectionEquality().hash(images));

@override
String toString() {
  return 'LocationDetail(location: $location, images: $images)';
}


}

/// @nodoc
abstract mixin class $LocationDetailCopyWith<$Res>  {
  factory $LocationDetailCopyWith(LocationDetail value, $Res Function(LocationDetail) _then) = _$LocationDetailCopyWithImpl;
@useResult
$Res call({
 Location location, List<AppImage> images
});


$LocationCopyWith<$Res> get location;

}
/// @nodoc
class _$LocationDetailCopyWithImpl<$Res>
    implements $LocationDetailCopyWith<$Res> {
  _$LocationDetailCopyWithImpl(this._self, this._then);

  final LocationDetail _self;
  final $Res Function(LocationDetail) _then;

/// Create a copy of LocationDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? location = null,Object? images = null,}) {
  return _then(_self.copyWith(
location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as Location,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<AppImage>,
  ));
}
/// Create a copy of LocationDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationCopyWith<$Res> get location {
  
  return $LocationCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// Adds pattern-matching-related methods to [LocationDetail].
extension LocationDetailPatterns on LocationDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocationDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocationDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocationDetail value)  $default,){
final _that = this;
switch (_that) {
case _LocationDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocationDetail value)?  $default,){
final _that = this;
switch (_that) {
case _LocationDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Location location,  List<AppImage> images)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocationDetail() when $default != null:
return $default(_that.location,_that.images);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Location location,  List<AppImage> images)  $default,) {final _that = this;
switch (_that) {
case _LocationDetail():
return $default(_that.location,_that.images);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Location location,  List<AppImage> images)?  $default,) {final _that = this;
switch (_that) {
case _LocationDetail() when $default != null:
return $default(_that.location,_that.images);case _:
  return null;

}
}

}

/// @nodoc


class _LocationDetail implements LocationDetail {
  const _LocationDetail({required this.location, required final  List<AppImage> images}): _images = images;
  

@override final  Location location;
 final  List<AppImage> _images;
@override List<AppImage> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}


/// Create a copy of LocationDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationDetailCopyWith<_LocationDetail> get copyWith => __$LocationDetailCopyWithImpl<_LocationDetail>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationDetail&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other._images, _images));
}


@override
int get hashCode => Object.hash(runtimeType,location,const DeepCollectionEquality().hash(_images));

@override
String toString() {
  return 'LocationDetail(location: $location, images: $images)';
}


}

/// @nodoc
abstract mixin class _$LocationDetailCopyWith<$Res> implements $LocationDetailCopyWith<$Res> {
  factory _$LocationDetailCopyWith(_LocationDetail value, $Res Function(_LocationDetail) _then) = __$LocationDetailCopyWithImpl;
@override @useResult
$Res call({
 Location location, List<AppImage> images
});


@override $LocationCopyWith<$Res> get location;

}
/// @nodoc
class __$LocationDetailCopyWithImpl<$Res>
    implements _$LocationDetailCopyWith<$Res> {
  __$LocationDetailCopyWithImpl(this._self, this._then);

  final _LocationDetail _self;
  final $Res Function(_LocationDetail) _then;

/// Create a copy of LocationDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? location = null,Object? images = null,}) {
  return _then(_LocationDetail(
location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as Location,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<AppImage>,
  ));
}

/// Create a copy of LocationDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationCopyWith<$Res> get location {
  
  return $LocationCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}

// dart format on
