// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LocationFilter {

 DateTime? get start; DateTime? get end; LatLng? get center; String? get placeText; double get radiusKm;
/// Create a copy of LocationFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationFilterCopyWith<LocationFilter> get copyWith => _$LocationFilterCopyWithImpl<LocationFilter>(this as LocationFilter, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LocationFilter;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationFilter&&(identical(other.start, _this.start) || other.start == _this.start)&&(identical(other.end, _this.end) || other.end == _this.end)&&(identical(other.center, _this.center) || other.center == _this.center)&&(identical(other.placeText, _this.placeText) || other.placeText == _this.placeText)&&(identical(other.radiusKm, _this.radiusKm) || other.radiusKm == _this.radiusKm));
}


@override
int get hashCode {
  final _this = this as LocationFilter;
  return Object.hash(runtimeType,_this.start,_this.end,_this.center,_this.placeText,_this.radiusKm);
}

@override
String toString() {
  final _this = this as LocationFilter;
  return 'LocationFilter(start: ${_this.start}, end: ${_this.end}, center: ${_this.center}, placeText: ${_this.placeText}, radiusKm: ${_this.radiusKm})';
}


}

/// @nodoc
abstract mixin class $LocationFilterCopyWith<$Res>  {
  factory $LocationFilterCopyWith(LocationFilter value, $Res Function(LocationFilter) _then) = _$LocationFilterCopyWithImpl;
@useResult
$Res call({
 DateTime? start, DateTime? end, LatLng? center, String? placeText, double radiusKm
});




}
/// @nodoc
class _$LocationFilterCopyWithImpl<$Res>
    implements $LocationFilterCopyWith<$Res> {
  _$LocationFilterCopyWithImpl(this._self, this._then);

  final LocationFilter _self;
  final $Res Function(LocationFilter) _then;

/// Create a copy of LocationFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? start = freezed,Object? end = freezed,Object? center = freezed,Object? placeText = freezed,Object? radiusKm = null,}) {
  return _then(LocationFilter(
start: freezed == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime?,end: freezed == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime?,center: freezed == center ? _self.center : center // ignore: cast_nullable_to_non_nullable
as LatLng?,placeText: freezed == placeText ? _self.placeText : placeText // ignore: cast_nullable_to_non_nullable
as String?,radiusKm: null == radiusKm ? _self.radiusKm : radiusKm // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [LocationFilter].
extension LocationFilterPatterns on LocationFilter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocationFilter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocationFilter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocationFilter value)  $default,){
final _that = this;
switch (_that) {
case _LocationFilter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocationFilter value)?  $default,){
final _that = this;
switch (_that) {
case _LocationFilter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime? start,  DateTime? end,  LatLng? center,  String? placeText,  double radiusKm)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocationFilter() when $default != null:
return $default(_that.start,_that.end,_that.center,_that.placeText,_that.radiusKm);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime? start,  DateTime? end,  LatLng? center,  String? placeText,  double radiusKm)  $default,) {final _that = this;
switch (_that) {
case _LocationFilter():
return $default(_that.start,_that.end,_that.center,_that.placeText,_that.radiusKm);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime? start,  DateTime? end,  LatLng? center,  String? placeText,  double radiusKm)?  $default,) {final _that = this;
switch (_that) {
case _LocationFilter() when $default != null:
return $default(_that.start,_that.end,_that.center,_that.placeText,_that.radiusKm);case _:
  return null;

}
}

}

/// @nodoc


class _LocationFilter implements LocationFilter {
  const _LocationFilter({this.start, this.end, this.center, this.placeText, this.radiusKm = 10.0});
  

@override final  DateTime? start;
@override final  DateTime? end;
@override final  LatLng? center;
@override final  String? placeText;
@override@JsonKey() final  double radiusKm;

/// Create a copy of LocationFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationFilterCopyWith<_LocationFilter> get copyWith => __$LocationFilterCopyWithImpl<_LocationFilter>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationFilter&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.center, center) || other.center == center)&&(identical(other.placeText, placeText) || other.placeText == placeText)&&(identical(other.radiusKm, radiusKm) || other.radiusKm == radiusKm));
}


@override
int get hashCode {
    return Object.hash(runtimeType,start,end,center,placeText,radiusKm);
}

@override
String toString() {
    return 'LocationFilter(start: $start, end: $end, center: $center, placeText: $placeText, radiusKm: $radiusKm)';
}


}

/// @nodoc
abstract mixin class _$LocationFilterCopyWith<$Res> implements $LocationFilterCopyWith<$Res> {
  factory _$LocationFilterCopyWith(_LocationFilter value, $Res Function(_LocationFilter) _then) = __$LocationFilterCopyWithImpl;
@override @useResult
$Res call({
 DateTime? start, DateTime? end, LatLng? center, String? placeText, double radiusKm
});




}
/// @nodoc
class __$LocationFilterCopyWithImpl<$Res>
    implements _$LocationFilterCopyWith<$Res> {
  __$LocationFilterCopyWithImpl(this._self, this._then);

  final _LocationFilter _self;
  final $Res Function(_LocationFilter) _then;

/// Create a copy of LocationFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? start = freezed,Object? end = freezed,Object? center = freezed,Object? placeText = freezed,Object? radiusKm = null,}) {
  return _then(_LocationFilter(
start: freezed == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime?,end: freezed == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime?,center: freezed == center ? _self.center : center // ignore: cast_nullable_to_non_nullable
as LatLng?,placeText: freezed == placeText ? _self.placeText : placeText // ignore: cast_nullable_to_non_nullable
as String?,radiusKm: null == radiusKm ? _self.radiusKm : radiusKm // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
