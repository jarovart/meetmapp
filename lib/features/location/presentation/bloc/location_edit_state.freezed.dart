// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_edit_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LocationEditState {

 Location? get original; LoadStatus get status; String get title; String get description; String get address; LatLng? get position; DateTime? get startDateTime; DateTime? get endDateTime; List<ImageEntry> get images; bool get isProcessingImage; bool get isSaving; bool get isSaved; AppFailure? get failure;
/// Create a copy of LocationEditState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationEditStateCopyWith<LocationEditState> get copyWith => _$LocationEditStateCopyWithImpl<LocationEditState>(this as LocationEditState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LocationEditState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationEditState&&(identical(other.original, _this.original) || other.original == _this.original)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.address, _this.address) || other.address == _this.address)&&(identical(other.position, _this.position) || other.position == _this.position)&&(identical(other.startDateTime, _this.startDateTime) || other.startDateTime == _this.startDateTime)&&(identical(other.endDateTime, _this.endDateTime) || other.endDateTime == _this.endDateTime)&&const DeepCollectionEquality().equals(other.images, _this.images)&&(identical(other.isProcessingImage, _this.isProcessingImage) || other.isProcessingImage == _this.isProcessingImage)&&(identical(other.isSaving, _this.isSaving) || other.isSaving == _this.isSaving)&&(identical(other.isSaved, _this.isSaved) || other.isSaved == _this.isSaved)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as LocationEditState;
  return Object.hash(runtimeType,_this.original,_this.status,_this.title,_this.description,_this.address,_this.position,_this.startDateTime,_this.endDateTime,const DeepCollectionEquality().hash(_this.images),_this.isProcessingImage,_this.isSaving,_this.isSaved,_this.failure);
}

@override
String toString() {
  final _this = this as LocationEditState;
  return 'LocationEditState(original: ${_this.original}, status: ${_this.status}, title: ${_this.title}, description: ${_this.description}, address: ${_this.address}, position: ${_this.position}, startDateTime: ${_this.startDateTime}, endDateTime: ${_this.endDateTime}, images: ${_this.images}, isProcessingImage: ${_this.isProcessingImage}, isSaving: ${_this.isSaving}, isSaved: ${_this.isSaved}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $LocationEditStateCopyWith<$Res>  {
  factory $LocationEditStateCopyWith(LocationEditState value, $Res Function(LocationEditState) _then) = _$LocationEditStateCopyWithImpl;
@useResult
$Res call({
 Location? original, LoadStatus status, String title, String description, String address, LatLng? position, DateTime? startDateTime, DateTime? endDateTime, List<ImageEntry> images, bool isProcessingImage, bool isSaving, bool isSaved, AppFailure? failure
});


$LocationCopyWith<$Res>? get original;

}
/// @nodoc
class _$LocationEditStateCopyWithImpl<$Res>
    implements $LocationEditStateCopyWith<$Res> {
  _$LocationEditStateCopyWithImpl(this._self, this._then);

  final LocationEditState _self;
  final $Res Function(LocationEditState) _then;

/// Create a copy of LocationEditState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? original = freezed,Object? status = null,Object? title = null,Object? description = null,Object? address = null,Object? position = freezed,Object? startDateTime = freezed,Object? endDateTime = freezed,Object? images = null,Object? isProcessingImage = null,Object? isSaving = null,Object? isSaved = null,Object? failure = freezed,}) {
  return _then(LocationEditState(
original: freezed == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as Location?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as LatLng?,startDateTime: freezed == startDateTime ? _self.startDateTime : startDateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,endDateTime: freezed == endDateTime ? _self.endDateTime : endDateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<ImageEntry>,isProcessingImage: null == isProcessingImage ? _self.isProcessingImage : isProcessingImage // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isSaved: null == isSaved ? _self.isSaved : isSaved // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,
  ));
}
/// Create a copy of LocationEditState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationCopyWith<$Res>? get original {
    if (_self.original == null) {
    return null;
  }

  return $LocationCopyWith<$Res>(_self.original!, (value) {
    return _then(_self.copyWith(original: value));
  });
}
}


/// Adds pattern-matching-related methods to [LocationEditState].
extension LocationEditStatePatterns on LocationEditState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocationEditState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocationEditState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocationEditState value)  $default,){
final _that = this;
switch (_that) {
case _LocationEditState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocationEditState value)?  $default,){
final _that = this;
switch (_that) {
case _LocationEditState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Location? original,  LoadStatus status,  String title,  String description,  String address,  LatLng? position,  DateTime? startDateTime,  DateTime? endDateTime,  List<ImageEntry> images,  bool isProcessingImage,  bool isSaving,  bool isSaved,  AppFailure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocationEditState() when $default != null:
return $default(_that.original,_that.status,_that.title,_that.description,_that.address,_that.position,_that.startDateTime,_that.endDateTime,_that.images,_that.isProcessingImage,_that.isSaving,_that.isSaved,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Location? original,  LoadStatus status,  String title,  String description,  String address,  LatLng? position,  DateTime? startDateTime,  DateTime? endDateTime,  List<ImageEntry> images,  bool isProcessingImage,  bool isSaving,  bool isSaved,  AppFailure? failure)  $default,) {final _that = this;
switch (_that) {
case _LocationEditState():
return $default(_that.original,_that.status,_that.title,_that.description,_that.address,_that.position,_that.startDateTime,_that.endDateTime,_that.images,_that.isProcessingImage,_that.isSaving,_that.isSaved,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Location? original,  LoadStatus status,  String title,  String description,  String address,  LatLng? position,  DateTime? startDateTime,  DateTime? endDateTime,  List<ImageEntry> images,  bool isProcessingImage,  bool isSaving,  bool isSaved,  AppFailure? failure)?  $default,) {final _that = this;
switch (_that) {
case _LocationEditState() when $default != null:
return $default(_that.original,_that.status,_that.title,_that.description,_that.address,_that.position,_that.startDateTime,_that.endDateTime,_that.images,_that.isProcessingImage,_that.isSaving,_that.isSaved,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _LocationEditState extends LocationEditState {
  const _LocationEditState({this.original, this.status = LoadStatus.initial, this.title = '', this.description = '', this.address = '', this.position, this.startDateTime, this.endDateTime,  List<ImageEntry> images = const [], this.isProcessingImage = false, this.isSaving = false, this.isSaved = false, this.failure}): _images = images,super._();
  

@override final  Location? original;
@override@JsonKey() final  LoadStatus status;
@override@JsonKey() final  String title;
@override@JsonKey() final  String description;
@override@JsonKey() final  String address;
@override final  LatLng? position;
@override final  DateTime? startDateTime;
@override final  DateTime? endDateTime;
 final  List<ImageEntry> _images;
@override@JsonKey() List<ImageEntry> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}

@override@JsonKey() final  bool isProcessingImage;
@override@JsonKey() final  bool isSaving;
@override@JsonKey() final  bool isSaved;
@override final  AppFailure? failure;

/// Create a copy of LocationEditState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationEditStateCopyWith<_LocationEditState> get copyWith => __$LocationEditStateCopyWithImpl<_LocationEditState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationEditState&&(identical(other.original, original) || other.original == original)&&(identical(other.status, status) || other.status == status)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.address, address) || other.address == address)&&(identical(other.position, position) || other.position == position)&&(identical(other.startDateTime, startDateTime) || other.startDateTime == startDateTime)&&(identical(other.endDateTime, endDateTime) || other.endDateTime == endDateTime)&&const DeepCollectionEquality().equals(other.images, _images)&&(identical(other.isProcessingImage, isProcessingImage) || other.isProcessingImage == isProcessingImage)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.isSaved, isSaved) || other.isSaved == isSaved)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,original,status,title,description,address,position,startDateTime,endDateTime,const DeepCollectionEquality().hash(_images),isProcessingImage,isSaving,isSaved,failure);
}

@override
String toString() {
    return 'LocationEditState(original: $original, status: $status, title: $title, description: $description, address: $address, position: $position, startDateTime: $startDateTime, endDateTime: $endDateTime, images: $images, isProcessingImage: $isProcessingImage, isSaving: $isSaving, isSaved: $isSaved, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$LocationEditStateCopyWith<$Res> implements $LocationEditStateCopyWith<$Res> {
  factory _$LocationEditStateCopyWith(_LocationEditState value, $Res Function(_LocationEditState) _then) = __$LocationEditStateCopyWithImpl;
@override @useResult
$Res call({
 Location? original, LoadStatus status, String title, String description, String address, LatLng? position, DateTime? startDateTime, DateTime? endDateTime, List<ImageEntry> images, bool isProcessingImage, bool isSaving, bool isSaved, AppFailure? failure
});


@override $LocationCopyWith<$Res>? get original;

}
/// @nodoc
class __$LocationEditStateCopyWithImpl<$Res>
    implements _$LocationEditStateCopyWith<$Res> {
  __$LocationEditStateCopyWithImpl(this._self, this._then);

  final _LocationEditState _self;
  final $Res Function(_LocationEditState) _then;

/// Create a copy of LocationEditState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? original = freezed,Object? status = null,Object? title = null,Object? description = null,Object? address = null,Object? position = freezed,Object? startDateTime = freezed,Object? endDateTime = freezed,Object? images = null,Object? isProcessingImage = null,Object? isSaving = null,Object? isSaved = null,Object? failure = freezed,}) {
  return _then(_LocationEditState(
original: freezed == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as Location?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as LatLng?,startDateTime: freezed == startDateTime ? _self.startDateTime : startDateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,endDateTime: freezed == endDateTime ? _self.endDateTime : endDateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<ImageEntry>,isProcessingImage: null == isProcessingImage ? _self.isProcessingImage : isProcessingImage // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isSaved: null == isSaved ? _self.isSaved : isSaved // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,
  ));
}

/// Create a copy of LocationEditState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationCopyWith<$Res>? get original {
    if (_self.original == null) {
    return null;
  }

  return $LocationCopyWith<$Res>(_self.original!, (value) {
    return _then(_self.copyWith(original: value));
  });
}
}

// dart format on
