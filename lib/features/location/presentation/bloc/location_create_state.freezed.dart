// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_create_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LocationCreateState {

 LatLng? get initialPosition; LatLng? get position; String? get initialAddress; String get title; String get description; String get address; DateTime? get startDateTime; DateTime? get endDateTime; List<Uint8List> get images; bool get isProcessingImage; CreateStep get step; Location? get createdLocation; AppFailure? get failure;
/// Create a copy of LocationCreateState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationCreateStateCopyWith<LocationCreateState> get copyWith => _$LocationCreateStateCopyWithImpl<LocationCreateState>(this as LocationCreateState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LocationCreateState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationCreateState&&(identical(other.initialPosition, _this.initialPosition) || other.initialPosition == _this.initialPosition)&&(identical(other.position, _this.position) || other.position == _this.position)&&(identical(other.initialAddress, _this.initialAddress) || other.initialAddress == _this.initialAddress)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.address, _this.address) || other.address == _this.address)&&(identical(other.startDateTime, _this.startDateTime) || other.startDateTime == _this.startDateTime)&&(identical(other.endDateTime, _this.endDateTime) || other.endDateTime == _this.endDateTime)&&const DeepCollectionEquality().equals(other.images, _this.images)&&(identical(other.isProcessingImage, _this.isProcessingImage) || other.isProcessingImage == _this.isProcessingImage)&&(identical(other.step, _this.step) || other.step == _this.step)&&(identical(other.createdLocation, _this.createdLocation) || other.createdLocation == _this.createdLocation)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as LocationCreateState;
  return Object.hash(runtimeType,_this.initialPosition,_this.position,_this.initialAddress,_this.title,_this.description,_this.address,_this.startDateTime,_this.endDateTime,const DeepCollectionEquality().hash(_this.images),_this.isProcessingImage,_this.step,_this.createdLocation,_this.failure);
}

@override
String toString() {
  final _this = this as LocationCreateState;
  return 'LocationCreateState(initialPosition: ${_this.initialPosition}, position: ${_this.position}, initialAddress: ${_this.initialAddress}, title: ${_this.title}, description: ${_this.description}, address: ${_this.address}, startDateTime: ${_this.startDateTime}, endDateTime: ${_this.endDateTime}, images: ${_this.images}, isProcessingImage: ${_this.isProcessingImage}, step: ${_this.step}, createdLocation: ${_this.createdLocation}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $LocationCreateStateCopyWith<$Res>  {
  factory $LocationCreateStateCopyWith(LocationCreateState value, $Res Function(LocationCreateState) _then) = _$LocationCreateStateCopyWithImpl;
@useResult
$Res call({
 LatLng? initialPosition, LatLng? position, String? initialAddress, String title, String description, String address, DateTime? startDateTime, DateTime? endDateTime, List<Uint8List> images, bool isProcessingImage, CreateStep step, Location? createdLocation, AppFailure? failure
});


$LocationCopyWith<$Res>? get createdLocation;

}
/// @nodoc
class _$LocationCreateStateCopyWithImpl<$Res>
    implements $LocationCreateStateCopyWith<$Res> {
  _$LocationCreateStateCopyWithImpl(this._self, this._then);

  final LocationCreateState _self;
  final $Res Function(LocationCreateState) _then;

/// Create a copy of LocationCreateState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? initialPosition = freezed,Object? position = freezed,Object? initialAddress = freezed,Object? title = null,Object? description = null,Object? address = null,Object? startDateTime = freezed,Object? endDateTime = freezed,Object? images = null,Object? isProcessingImage = null,Object? step = null,Object? createdLocation = freezed,Object? failure = freezed,}) {
  return _then(LocationCreateState(
initialPosition: freezed == initialPosition ? _self.initialPosition : initialPosition // ignore: cast_nullable_to_non_nullable
as LatLng?,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as LatLng?,initialAddress: freezed == initialAddress ? _self.initialAddress : initialAddress // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,startDateTime: freezed == startDateTime ? _self.startDateTime : startDateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,endDateTime: freezed == endDateTime ? _self.endDateTime : endDateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<Uint8List>,isProcessingImage: null == isProcessingImage ? _self.isProcessingImage : isProcessingImage // ignore: cast_nullable_to_non_nullable
as bool,step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as CreateStep,createdLocation: freezed == createdLocation ? _self.createdLocation : createdLocation // ignore: cast_nullable_to_non_nullable
as Location?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,
  ));
}
/// Create a copy of LocationCreateState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationCopyWith<$Res>? get createdLocation {
    if (_self.createdLocation == null) {
    return null;
  }

  return $LocationCopyWith<$Res>(_self.createdLocation!, (value) {
    return _then(_self.copyWith(createdLocation: value));
  });
}
}


/// Adds pattern-matching-related methods to [LocationCreateState].
extension LocationCreateStatePatterns on LocationCreateState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocationCreateState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocationCreateState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocationCreateState value)  $default,){
final _that = this;
switch (_that) {
case _LocationCreateState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocationCreateState value)?  $default,){
final _that = this;
switch (_that) {
case _LocationCreateState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LatLng? initialPosition,  LatLng? position,  String? initialAddress,  String title,  String description,  String address,  DateTime? startDateTime,  DateTime? endDateTime,  List<Uint8List> images,  bool isProcessingImage,  CreateStep step,  Location? createdLocation,  AppFailure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocationCreateState() when $default != null:
return $default(_that.initialPosition,_that.position,_that.initialAddress,_that.title,_that.description,_that.address,_that.startDateTime,_that.endDateTime,_that.images,_that.isProcessingImage,_that.step,_that.createdLocation,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LatLng? initialPosition,  LatLng? position,  String? initialAddress,  String title,  String description,  String address,  DateTime? startDateTime,  DateTime? endDateTime,  List<Uint8List> images,  bool isProcessingImage,  CreateStep step,  Location? createdLocation,  AppFailure? failure)  $default,) {final _that = this;
switch (_that) {
case _LocationCreateState():
return $default(_that.initialPosition,_that.position,_that.initialAddress,_that.title,_that.description,_that.address,_that.startDateTime,_that.endDateTime,_that.images,_that.isProcessingImage,_that.step,_that.createdLocation,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LatLng? initialPosition,  LatLng? position,  String? initialAddress,  String title,  String description,  String address,  DateTime? startDateTime,  DateTime? endDateTime,  List<Uint8List> images,  bool isProcessingImage,  CreateStep step,  Location? createdLocation,  AppFailure? failure)?  $default,) {final _that = this;
switch (_that) {
case _LocationCreateState() when $default != null:
return $default(_that.initialPosition,_that.position,_that.initialAddress,_that.title,_that.description,_that.address,_that.startDateTime,_that.endDateTime,_that.images,_that.isProcessingImage,_that.step,_that.createdLocation,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _LocationCreateState extends LocationCreateState {
  const _LocationCreateState({this.initialPosition, this.position, this.initialAddress, this.title = '', this.description = '', this.address = '', this.startDateTime, this.endDateTime,  List<Uint8List> images = const [], this.isProcessingImage = false, this.step = CreateStep.idle, this.createdLocation, this.failure}): _images = images,super._();
  

@override final  LatLng? initialPosition;
@override final  LatLng? position;
@override final  String? initialAddress;
@override@JsonKey() final  String title;
@override@JsonKey() final  String description;
@override@JsonKey() final  String address;
@override final  DateTime? startDateTime;
@override final  DateTime? endDateTime;
 final  List<Uint8List> _images;
@override@JsonKey() List<Uint8List> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}

@override@JsonKey() final  bool isProcessingImage;
@override@JsonKey() final  CreateStep step;
@override final  Location? createdLocation;
@override final  AppFailure? failure;

/// Create a copy of LocationCreateState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationCreateStateCopyWith<_LocationCreateState> get copyWith => __$LocationCreateStateCopyWithImpl<_LocationCreateState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationCreateState&&(identical(other.initialPosition, initialPosition) || other.initialPosition == initialPosition)&&(identical(other.position, position) || other.position == position)&&(identical(other.initialAddress, initialAddress) || other.initialAddress == initialAddress)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.address, address) || other.address == address)&&(identical(other.startDateTime, startDateTime) || other.startDateTime == startDateTime)&&(identical(other.endDateTime, endDateTime) || other.endDateTime == endDateTime)&&const DeepCollectionEquality().equals(other.images, _images)&&(identical(other.isProcessingImage, isProcessingImage) || other.isProcessingImage == isProcessingImage)&&(identical(other.step, step) || other.step == step)&&(identical(other.createdLocation, createdLocation) || other.createdLocation == createdLocation)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,initialPosition,position,initialAddress,title,description,address,startDateTime,endDateTime,const DeepCollectionEquality().hash(_images),isProcessingImage,step,createdLocation,failure);
}

@override
String toString() {
    return 'LocationCreateState(initialPosition: $initialPosition, position: $position, initialAddress: $initialAddress, title: $title, description: $description, address: $address, startDateTime: $startDateTime, endDateTime: $endDateTime, images: $images, isProcessingImage: $isProcessingImage, step: $step, createdLocation: $createdLocation, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$LocationCreateStateCopyWith<$Res> implements $LocationCreateStateCopyWith<$Res> {
  factory _$LocationCreateStateCopyWith(_LocationCreateState value, $Res Function(_LocationCreateState) _then) = __$LocationCreateStateCopyWithImpl;
@override @useResult
$Res call({
 LatLng? initialPosition, LatLng? position, String? initialAddress, String title, String description, String address, DateTime? startDateTime, DateTime? endDateTime, List<Uint8List> images, bool isProcessingImage, CreateStep step, Location? createdLocation, AppFailure? failure
});


@override $LocationCopyWith<$Res>? get createdLocation;

}
/// @nodoc
class __$LocationCreateStateCopyWithImpl<$Res>
    implements _$LocationCreateStateCopyWith<$Res> {
  __$LocationCreateStateCopyWithImpl(this._self, this._then);

  final _LocationCreateState _self;
  final $Res Function(_LocationCreateState) _then;

/// Create a copy of LocationCreateState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? initialPosition = freezed,Object? position = freezed,Object? initialAddress = freezed,Object? title = null,Object? description = null,Object? address = null,Object? startDateTime = freezed,Object? endDateTime = freezed,Object? images = null,Object? isProcessingImage = null,Object? step = null,Object? createdLocation = freezed,Object? failure = freezed,}) {
  return _then(_LocationCreateState(
initialPosition: freezed == initialPosition ? _self.initialPosition : initialPosition // ignore: cast_nullable_to_non_nullable
as LatLng?,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as LatLng?,initialAddress: freezed == initialAddress ? _self.initialAddress : initialAddress // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,startDateTime: freezed == startDateTime ? _self.startDateTime : startDateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,endDateTime: freezed == endDateTime ? _self.endDateTime : endDateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<Uint8List>,isProcessingImage: null == isProcessingImage ? _self.isProcessingImage : isProcessingImage // ignore: cast_nullable_to_non_nullable
as bool,step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as CreateStep,createdLocation: freezed == createdLocation ? _self.createdLocation : createdLocation // ignore: cast_nullable_to_non_nullable
as Location?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,
  ));
}

/// Create a copy of LocationCreateState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationCopyWith<$Res>? get createdLocation {
    if (_self.createdLocation == null) {
    return null;
  }

  return $LocationCopyWith<$Res>(_self.createdLocation!, (value) {
    return _then(_self.copyWith(createdLocation: value));
  });
}
}

// dart format on
