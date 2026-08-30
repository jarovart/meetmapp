// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_image.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppImage {

 int get id; String get imageUrl;
/// Create a copy of AppImage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppImageCopyWith<AppImage> get copyWith => _$AppImageCopyWithImpl<AppImage>(this as AppImage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppImage&&(identical(other.id, id) || other.id == id)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}


@override
int get hashCode => Object.hash(runtimeType,id,imageUrl);

@override
String toString() {
  return 'AppImage(id: $id, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class $AppImageCopyWith<$Res>  {
  factory $AppImageCopyWith(AppImage value, $Res Function(AppImage) _then) = _$AppImageCopyWithImpl;
@useResult
$Res call({
 int id, String imageUrl
});




}
/// @nodoc
class _$AppImageCopyWithImpl<$Res>
    implements $AppImageCopyWith<$Res> {
  _$AppImageCopyWithImpl(this._self, this._then);

  final AppImage _self;
  final $Res Function(AppImage) _then;

/// Create a copy of AppImage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? imageUrl = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AppImage].
extension AppImagePatterns on AppImage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppImage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppImage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppImage value)  $default,){
final _that = this;
switch (_that) {
case _AppImage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppImage value)?  $default,){
final _that = this;
switch (_that) {
case _AppImage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String imageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppImage() when $default != null:
return $default(_that.id,_that.imageUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String imageUrl)  $default,) {final _that = this;
switch (_that) {
case _AppImage():
return $default(_that.id,_that.imageUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String imageUrl)?  $default,) {final _that = this;
switch (_that) {
case _AppImage() when $default != null:
return $default(_that.id,_that.imageUrl);case _:
  return null;

}
}

}

/// @nodoc


class _AppImage implements AppImage {
  const _AppImage({required this.id, required this.imageUrl});
  

@override final  int id;
@override final  String imageUrl;

/// Create a copy of AppImage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppImageCopyWith<_AppImage> get copyWith => __$AppImageCopyWithImpl<_AppImage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppImage&&(identical(other.id, id) || other.id == id)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}


@override
int get hashCode => Object.hash(runtimeType,id,imageUrl);

@override
String toString() {
  return 'AppImage(id: $id, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$AppImageCopyWith<$Res> implements $AppImageCopyWith<$Res> {
  factory _$AppImageCopyWith(_AppImage value, $Res Function(_AppImage) _then) = __$AppImageCopyWithImpl;
@override @useResult
$Res call({
 int id, String imageUrl
});




}
/// @nodoc
class __$AppImageCopyWithImpl<$Res>
    implements _$AppImageCopyWith<$Res> {
  __$AppImageCopyWithImpl(this._self, this._then);

  final _AppImage _self;
  final $Res Function(_AppImage) _then;

/// Create a copy of AppImage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? imageUrl = null,}) {
  return _then(_AppImage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
