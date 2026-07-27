// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Location {

 int get id; String get title; String get description; String get address; DateTime get creationDateTime; DateTime get startDateTime; DateTime get endDateTime; LatLng get position; Image? get thumbnailImage; int get createdUserId; String get createdUsername; int get likedUserCount; int get joinedUserCount; bool? get likedByCurrentUser; bool? get joinedByCurrentUser;
/// Create a copy of Location
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationCopyWith<Location> get copyWith => _$LocationCopyWithImpl<Location>(this as Location, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Location&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.address, address) || other.address == address)&&(identical(other.creationDateTime, creationDateTime) || other.creationDateTime == creationDateTime)&&(identical(other.startDateTime, startDateTime) || other.startDateTime == startDateTime)&&(identical(other.endDateTime, endDateTime) || other.endDateTime == endDateTime)&&(identical(other.position, position) || other.position == position)&&(identical(other.thumbnailImage, thumbnailImage) || other.thumbnailImage == thumbnailImage)&&(identical(other.createdUserId, createdUserId) || other.createdUserId == createdUserId)&&(identical(other.createdUsername, createdUsername) || other.createdUsername == createdUsername)&&(identical(other.likedUserCount, likedUserCount) || other.likedUserCount == likedUserCount)&&(identical(other.joinedUserCount, joinedUserCount) || other.joinedUserCount == joinedUserCount)&&(identical(other.likedByCurrentUser, likedByCurrentUser) || other.likedByCurrentUser == likedByCurrentUser)&&(identical(other.joinedByCurrentUser, joinedByCurrentUser) || other.joinedByCurrentUser == joinedByCurrentUser));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,address,creationDateTime,startDateTime,endDateTime,position,thumbnailImage,createdUserId,createdUsername,likedUserCount,joinedUserCount,likedByCurrentUser,joinedByCurrentUser);

@override
String toString() {
  return 'Location(id: $id, title: $title, description: $description, address: $address, creationDateTime: $creationDateTime, startDateTime: $startDateTime, endDateTime: $endDateTime, position: $position, thumbnailImage: $thumbnailImage, createdUserId: $createdUserId, createdUsername: $createdUsername, likedUserCount: $likedUserCount, joinedUserCount: $joinedUserCount, likedByCurrentUser: $likedByCurrentUser, joinedByCurrentUser: $joinedByCurrentUser)';
}


}

/// @nodoc
abstract mixin class $LocationCopyWith<$Res>  {
  factory $LocationCopyWith(Location value, $Res Function(Location) _then) = _$LocationCopyWithImpl;
@useResult
$Res call({
 int id, String title, String description, String address, DateTime creationDateTime, DateTime startDateTime, DateTime endDateTime, LatLng position, Image? thumbnailImage, int createdUserId, String createdUsername, int likedUserCount, int joinedUserCount, bool? likedByCurrentUser, bool? joinedByCurrentUser
});




}
/// @nodoc
class _$LocationCopyWithImpl<$Res>
    implements $LocationCopyWith<$Res> {
  _$LocationCopyWithImpl(this._self, this._then);

  final Location _self;
  final $Res Function(Location) _then;

/// Create a copy of Location
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? address = null,Object? creationDateTime = null,Object? startDateTime = null,Object? endDateTime = null,Object? position = null,Object? thumbnailImage = freezed,Object? createdUserId = null,Object? createdUsername = null,Object? likedUserCount = null,Object? joinedUserCount = null,Object? likedByCurrentUser = freezed,Object? joinedByCurrentUser = freezed,}) {
  return _then(Location(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,creationDateTime: null == creationDateTime ? _self.creationDateTime : creationDateTime // ignore: cast_nullable_to_non_nullable
as DateTime,startDateTime: null == startDateTime ? _self.startDateTime : startDateTime // ignore: cast_nullable_to_non_nullable
as DateTime,endDateTime: null == endDateTime ? _self.endDateTime : endDateTime // ignore: cast_nullable_to_non_nullable
as DateTime,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as LatLng,thumbnailImage: freezed == thumbnailImage ? _self.thumbnailImage : thumbnailImage // ignore: cast_nullable_to_non_nullable
as Image?,createdUserId: null == createdUserId ? _self.createdUserId : createdUserId // ignore: cast_nullable_to_non_nullable
as int,createdUsername: null == createdUsername ? _self.createdUsername : createdUsername // ignore: cast_nullable_to_non_nullable
as String,likedUserCount: null == likedUserCount ? _self.likedUserCount : likedUserCount // ignore: cast_nullable_to_non_nullable
as int,joinedUserCount: null == joinedUserCount ? _self.joinedUserCount : joinedUserCount // ignore: cast_nullable_to_non_nullable
as int,likedByCurrentUser: freezed == likedByCurrentUser ? _self.likedByCurrentUser : likedByCurrentUser // ignore: cast_nullable_to_non_nullable
as bool?,joinedByCurrentUser: freezed == joinedByCurrentUser ? _self.joinedByCurrentUser : joinedByCurrentUser // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [Location].
extension LocationPatterns on Location {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({required TResult orElse(),}){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({required TResult orElse(),}) {final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  return null;

}
}

}

// dart format on
