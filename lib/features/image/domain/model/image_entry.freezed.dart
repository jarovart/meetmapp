// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ImageEntry {

 Uint8List get bytes;
/// Create a copy of ImageEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImageEntryCopyWith<ImageEntry> get copyWith => _$ImageEntryCopyWithImpl<ImageEntry>(this as ImageEntry, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ImageEntry;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageEntry&&const DeepCollectionEquality().equals(other.bytes, _this.bytes));
}


@override
int get hashCode {
  final _this = this as ImageEntry;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.bytes));
}

@override
String toString() {
  final _this = this as ImageEntry;
  return 'ImageEntry(bytes: ${_this.bytes})';
}


}

/// @nodoc
abstract mixin class $ImageEntryCopyWith<$Res>  {
  factory $ImageEntryCopyWith(ImageEntry value, $Res Function(ImageEntry) _then) = _$ImageEntryCopyWithImpl;
@useResult
$Res call({
 Uint8List bytes
});




}
/// @nodoc
class _$ImageEntryCopyWithImpl<$Res>
    implements $ImageEntryCopyWith<$Res> {
  _$ImageEntryCopyWithImpl(this._self, this._then);

  final ImageEntry _self;
  final $Res Function(ImageEntry) _then;

/// Create a copy of ImageEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bytes = null,}) {
  return _then(_self.copyWith(
bytes: null == bytes ? _self.bytes : bytes // ignore: cast_nullable_to_non_nullable
as Uint8List,
  ));
}

}


/// Adds pattern-matching-related methods to [ImageEntry].
extension ImageEntryPatterns on ImageEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ExistingImage value)?  existing,TResult Function( AddedImage value)?  added,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ExistingImage() when existing != null:
return existing(_that);case AddedImage() when added != null:
return added(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ExistingImage value)  existing,required TResult Function( AddedImage value)  added,}){
final _that = this;
switch (_that) {
case ExistingImage():
return existing(_that);case AddedImage():
return added(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ExistingImage value)?  existing,TResult? Function( AddedImage value)?  added,}){
final _that = this;
switch (_that) {
case ExistingImage() when existing != null:
return existing(_that);case AddedImage() when added != null:
return added(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int id,  Uint8List bytes)?  existing,TResult Function( Uint8List bytes)?  added,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ExistingImage() when existing != null:
return existing(_that.id,_that.bytes);case AddedImage() when added != null:
return added(_that.bytes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int id,  Uint8List bytes)  existing,required TResult Function( Uint8List bytes)  added,}) {final _that = this;
switch (_that) {
case ExistingImage():
return existing(_that.id,_that.bytes);case AddedImage():
return added(_that.bytes);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int id,  Uint8List bytes)?  existing,TResult? Function( Uint8List bytes)?  added,}) {final _that = this;
switch (_that) {
case ExistingImage() when existing != null:
return existing(_that.id,_that.bytes);case AddedImage() when added != null:
return added(_that.bytes);case _:
  return null;

}
}

}

/// @nodoc


class ExistingImage extends ImageEntry {
  const ExistingImage({required this.id, required this.bytes}): super._();
  

 final  int id;
@override final  Uint8List bytes;

/// Create a copy of ImageEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExistingImageCopyWith<ExistingImage> get copyWith => _$ExistingImageCopyWithImpl<ExistingImage>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ExistingImage&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.bytes, bytes));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,const DeepCollectionEquality().hash(bytes));
}

@override
String toString() {
    return 'ImageEntry.existing(id: $id, bytes: $bytes)';
}


}

/// @nodoc
abstract mixin class $ExistingImageCopyWith<$Res> implements $ImageEntryCopyWith<$Res> {
  factory $ExistingImageCopyWith(ExistingImage value, $Res Function(ExistingImage) _then) = _$ExistingImageCopyWithImpl;
@override @useResult
$Res call({
 int id, Uint8List bytes
});




}
/// @nodoc
class _$ExistingImageCopyWithImpl<$Res>
    implements $ExistingImageCopyWith<$Res> {
  _$ExistingImageCopyWithImpl(this._self, this._then);

  final ExistingImage _self;
  final $Res Function(ExistingImage) _then;

/// Create a copy of ImageEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? bytes = null,}) {
  return _then(ExistingImage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,bytes: null == bytes ? _self.bytes : bytes // ignore: cast_nullable_to_non_nullable
as Uint8List,
  ));
}


}

/// @nodoc


class AddedImage extends ImageEntry {
  const AddedImage({required this.bytes}): super._();
  

@override final  Uint8List bytes;

/// Create a copy of ImageEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddedImageCopyWith<AddedImage> get copyWith => _$AddedImageCopyWithImpl<AddedImage>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is AddedImage&&const DeepCollectionEquality().equals(other.bytes, bytes));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(bytes));
}

@override
String toString() {
    return 'ImageEntry.added(bytes: $bytes)';
}


}

/// @nodoc
abstract mixin class $AddedImageCopyWith<$Res> implements $ImageEntryCopyWith<$Res> {
  factory $AddedImageCopyWith(AddedImage value, $Res Function(AddedImage) _then) = _$AddedImageCopyWithImpl;
@override @useResult
$Res call({
 Uint8List bytes
});




}
/// @nodoc
class _$AddedImageCopyWithImpl<$Res>
    implements $AddedImageCopyWith<$Res> {
  _$AddedImageCopyWithImpl(this._self, this._then);

  final AddedImage _self;
  final $Res Function(AddedImage) _then;

/// Create a copy of ImageEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bytes = null,}) {
  return _then(AddedImage(
bytes: null == bytes ? _self.bytes : bytes // ignore: cast_nullable_to_non_nullable
as Uint8List,
  ));
}


}

// dart format on
