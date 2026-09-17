// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LocationListState {

 LoadStatus get status; List<Location> get locations; int get page; bool get hasMore; bool get isLoadingMore; AppFailure? get failure;
/// Create a copy of LocationListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationListStateCopyWith<LocationListState> get copyWith => _$LocationListStateCopyWithImpl<LocationListState>(this as LocationListState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LocationListState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationListState&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.locations, _this.locations)&&(identical(other.page, _this.page) || other.page == _this.page)&&(identical(other.hasMore, _this.hasMore) || other.hasMore == _this.hasMore)&&(identical(other.isLoadingMore, _this.isLoadingMore) || other.isLoadingMore == _this.isLoadingMore)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as LocationListState;
  return Object.hash(runtimeType,_this.status,const DeepCollectionEquality().hash(_this.locations),_this.page,_this.hasMore,_this.isLoadingMore,_this.failure);
}

@override
String toString() {
  final _this = this as LocationListState;
  return 'LocationListState(status: ${_this.status}, locations: ${_this.locations}, page: ${_this.page}, hasMore: ${_this.hasMore}, isLoadingMore: ${_this.isLoadingMore}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $LocationListStateCopyWith<$Res>  {
  factory $LocationListStateCopyWith(LocationListState value, $Res Function(LocationListState) _then) = _$LocationListStateCopyWithImpl;
@useResult
$Res call({
 LoadStatus status, List<Location> locations, int page, bool hasMore, bool isLoadingMore, AppFailure? failure
});




}
/// @nodoc
class _$LocationListStateCopyWithImpl<$Res>
    implements $LocationListStateCopyWith<$Res> {
  _$LocationListStateCopyWithImpl(this._self, this._then);

  final LocationListState _self;
  final $Res Function(LocationListState) _then;

/// Create a copy of LocationListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? locations = null,Object? page = null,Object? hasMore = null,Object? isLoadingMore = null,Object? failure = freezed,}) {
  return _then(LocationListState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,locations: null == locations ? _self.locations : locations // ignore: cast_nullable_to_non_nullable
as List<Location>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,
  ));
}

}


/// Adds pattern-matching-related methods to [LocationListState].
extension LocationListStatePatterns on LocationListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocationListState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocationListState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocationListState value)  $default,){
final _that = this;
switch (_that) {
case _LocationListState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocationListState value)?  $default,){
final _that = this;
switch (_that) {
case _LocationListState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoadStatus status,  List<Location> locations,  int page,  bool hasMore,  bool isLoadingMore,  AppFailure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocationListState() when $default != null:
return $default(_that.status,_that.locations,_that.page,_that.hasMore,_that.isLoadingMore,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoadStatus status,  List<Location> locations,  int page,  bool hasMore,  bool isLoadingMore,  AppFailure? failure)  $default,) {final _that = this;
switch (_that) {
case _LocationListState():
return $default(_that.status,_that.locations,_that.page,_that.hasMore,_that.isLoadingMore,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoadStatus status,  List<Location> locations,  int page,  bool hasMore,  bool isLoadingMore,  AppFailure? failure)?  $default,) {final _that = this;
switch (_that) {
case _LocationListState() when $default != null:
return $default(_that.status,_that.locations,_that.page,_that.hasMore,_that.isLoadingMore,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _LocationListState implements LocationListState {
  const _LocationListState({this.status = LoadStatus.initial,  List<Location> locations = const [], this.page = 0, this.hasMore = true, this.isLoadingMore = false, this.failure}): _locations = locations;
  

@override@JsonKey() final  LoadStatus status;
 final  List<Location> _locations;
@override@JsonKey() List<Location> get locations {
  if (_locations is EqualUnmodifiableListView) return _locations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_locations);
}

@override@JsonKey() final  int page;
@override@JsonKey() final  bool hasMore;
@override@JsonKey() final  bool isLoadingMore;
@override final  AppFailure? failure;

/// Create a copy of LocationListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationListStateCopyWith<_LocationListState> get copyWith => __$LocationListStateCopyWithImpl<_LocationListState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationListState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.locations, _locations)&&(identical(other.page, page) || other.page == page)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_locations),page,hasMore,isLoadingMore,failure);
}

@override
String toString() {
    return 'LocationListState(status: $status, locations: $locations, page: $page, hasMore: $hasMore, isLoadingMore: $isLoadingMore, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$LocationListStateCopyWith<$Res> implements $LocationListStateCopyWith<$Res> {
  factory _$LocationListStateCopyWith(_LocationListState value, $Res Function(_LocationListState) _then) = __$LocationListStateCopyWithImpl;
@override @useResult
$Res call({
 LoadStatus status, List<Location> locations, int page, bool hasMore, bool isLoadingMore, AppFailure? failure
});




}
/// @nodoc
class __$LocationListStateCopyWithImpl<$Res>
    implements _$LocationListStateCopyWith<$Res> {
  __$LocationListStateCopyWithImpl(this._self, this._then);

  final _LocationListState _self;
  final $Res Function(_LocationListState) _then;

/// Create a copy of LocationListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? locations = null,Object? page = null,Object? hasMore = null,Object? isLoadingMore = null,Object? failure = freezed,}) {
  return _then(_LocationListState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,locations: null == locations ? _self._locations : locations // ignore: cast_nullable_to_non_nullable
as List<Location>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,
  ));
}


}

// dart format on
