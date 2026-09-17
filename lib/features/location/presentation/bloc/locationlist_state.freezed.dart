// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'locationlist_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LocationSearchState {

 LoadStatus get status; String get query; List<Location> get locations; int get page; bool get hasMore; bool get isLoadingMore; LatLng? get currentPosition; LocationFilter? get filter; AppFailure? get failure;
/// Create a copy of LocationSearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationSearchStateCopyWith<LocationSearchState> get copyWith => _$LocationSearchStateCopyWithImpl<LocationSearchState>(this as LocationSearchState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LocationSearchState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationSearchState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.query, _this.query) || other.query == _this.query)&&const DeepCollectionEquality().equals(other.locations, _this.locations)&&(identical(other.page, _this.page) || other.page == _this.page)&&(identical(other.hasMore, _this.hasMore) || other.hasMore == _this.hasMore)&&(identical(other.isLoadingMore, _this.isLoadingMore) || other.isLoadingMore == _this.isLoadingMore)&&(identical(other.currentPosition, _this.currentPosition) || other.currentPosition == _this.currentPosition)&&(identical(other.filter, _this.filter) || other.filter == _this.filter)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as LocationSearchState;
  return Object.hash(runtimeType,_this.status,_this.query,const DeepCollectionEquality().hash(_this.locations),_this.page,_this.hasMore,_this.isLoadingMore,_this.currentPosition,_this.filter,_this.failure);
}

@override
String toString() {
  final _this = this as LocationSearchState;
  return 'LocationSearchState(status: ${_this.status}, query: ${_this.query}, locations: ${_this.locations}, page: ${_this.page}, hasMore: ${_this.hasMore}, isLoadingMore: ${_this.isLoadingMore}, currentPosition: ${_this.currentPosition}, filter: ${_this.filter}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $LocationSearchStateCopyWith<$Res>  {
  factory $LocationSearchStateCopyWith(LocationSearchState value, $Res Function(LocationSearchState) _then) = _$LocationSearchStateCopyWithImpl;
@useResult
$Res call({
 LoadStatus status, String query, List<Location> locations, int page, bool hasMore, bool isLoadingMore, LatLng? currentPosition, LocationFilter? filter, AppFailure? failure
});


$LocationFilterCopyWith<$Res>? get filter;

}
/// @nodoc
class _$LocationSearchStateCopyWithImpl<$Res>
    implements $LocationSearchStateCopyWith<$Res> {
  _$LocationSearchStateCopyWithImpl(this._self, this._then);

  final LocationSearchState _self;
  final $Res Function(LocationSearchState) _then;

/// Create a copy of LocationSearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? query = null,Object? locations = null,Object? page = null,Object? hasMore = null,Object? isLoadingMore = null,Object? currentPosition = freezed,Object? filter = freezed,Object? failure = freezed,}) {
  return _then(LocationSearchState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,locations: null == locations ? _self.locations : locations // ignore: cast_nullable_to_non_nullable
as List<Location>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,currentPosition: freezed == currentPosition ? _self.currentPosition : currentPosition // ignore: cast_nullable_to_non_nullable
as LatLng?,filter: freezed == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as LocationFilter?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,
  ));
}
/// Create a copy of LocationSearchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationFilterCopyWith<$Res>? get filter {
    if (_self.filter == null) {
    return null;
  }

  return $LocationFilterCopyWith<$Res>(_self.filter!, (value) {
    return _then(_self.copyWith(filter: value));
  });
}
}


/// Adds pattern-matching-related methods to [LocationSearchState].
extension LocationSearchStatePatterns on LocationSearchState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocationSearchState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocationSearchState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocationSearchState value)  $default,){
final _that = this;
switch (_that) {
case _LocationSearchState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocationSearchState value)?  $default,){
final _that = this;
switch (_that) {
case _LocationSearchState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoadStatus status,  String query,  List<Location> locations,  int page,  bool hasMore,  bool isLoadingMore,  LatLng? currentPosition,  LocationFilter? filter,  AppFailure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocationSearchState() when $default != null:
return $default(_that.status,_that.query,_that.locations,_that.page,_that.hasMore,_that.isLoadingMore,_that.currentPosition,_that.filter,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoadStatus status,  String query,  List<Location> locations,  int page,  bool hasMore,  bool isLoadingMore,  LatLng? currentPosition,  LocationFilter? filter,  AppFailure? failure)  $default,) {final _that = this;
switch (_that) {
case _LocationSearchState():
return $default(_that.status,_that.query,_that.locations,_that.page,_that.hasMore,_that.isLoadingMore,_that.currentPosition,_that.filter,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoadStatus status,  String query,  List<Location> locations,  int page,  bool hasMore,  bool isLoadingMore,  LatLng? currentPosition,  LocationFilter? filter,  AppFailure? failure)?  $default,) {final _that = this;
switch (_that) {
case _LocationSearchState() when $default != null:
return $default(_that.status,_that.query,_that.locations,_that.page,_that.hasMore,_that.isLoadingMore,_that.currentPosition,_that.filter,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _LocationSearchState implements LocationSearchState {
  const _LocationSearchState({this.status = LoadStatus.initial, this.query = '',  List<Location> locations = const [], this.page = 0, this.hasMore = true, this.isLoadingMore = false, this.currentPosition, this.filter, this.failure}): _locations = locations;
  

@override@JsonKey() final  LoadStatus status;
@override@JsonKey() final  String query;
 final  List<Location> _locations;
@override@JsonKey() List<Location> get locations {
  if (_locations is EqualUnmodifiableListView) return _locations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_locations);
}

@override@JsonKey() final  int page;
@override@JsonKey() final  bool hasMore;
@override@JsonKey() final  bool isLoadingMore;
@override final  LatLng? currentPosition;
@override final  LocationFilter? filter;
@override final  AppFailure? failure;

/// Create a copy of LocationSearchState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationSearchStateCopyWith<_LocationSearchState> get copyWith => __$LocationSearchStateCopyWithImpl<_LocationSearchState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationSearchState&&(identical(other.status, status) || other.status == status)&&(identical(other.query, query) || other.query == query)&&const DeepCollectionEquality().equals(other.locations, _locations)&&(identical(other.page, page) || other.page == page)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.currentPosition, currentPosition) || other.currentPosition == currentPosition)&&(identical(other.filter, filter) || other.filter == filter)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,query,const DeepCollectionEquality().hash(_locations),page,hasMore,isLoadingMore,currentPosition,filter,failure);
}

@override
String toString() {
    return 'LocationSearchState(status: $status, query: $query, locations: $locations, page: $page, hasMore: $hasMore, isLoadingMore: $isLoadingMore, currentPosition: $currentPosition, filter: $filter, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$LocationSearchStateCopyWith<$Res> implements $LocationSearchStateCopyWith<$Res> {
  factory _$LocationSearchStateCopyWith(_LocationSearchState value, $Res Function(_LocationSearchState) _then) = __$LocationSearchStateCopyWithImpl;
@override @useResult
$Res call({
 LoadStatus status, String query, List<Location> locations, int page, bool hasMore, bool isLoadingMore, LatLng? currentPosition, LocationFilter? filter, AppFailure? failure
});


@override $LocationFilterCopyWith<$Res>? get filter;

}
/// @nodoc
class __$LocationSearchStateCopyWithImpl<$Res>
    implements _$LocationSearchStateCopyWith<$Res> {
  __$LocationSearchStateCopyWithImpl(this._self, this._then);

  final _LocationSearchState _self;
  final $Res Function(_LocationSearchState) _then;

/// Create a copy of LocationSearchState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? query = null,Object? locations = null,Object? page = null,Object? hasMore = null,Object? isLoadingMore = null,Object? currentPosition = freezed,Object? filter = freezed,Object? failure = freezed,}) {
  return _then(_LocationSearchState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,locations: null == locations ? _self._locations : locations // ignore: cast_nullable_to_non_nullable
as List<Location>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,currentPosition: freezed == currentPosition ? _self.currentPosition : currentPosition // ignore: cast_nullable_to_non_nullable
as LatLng?,filter: freezed == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as LocationFilter?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,
  ));
}

/// Create a copy of LocationSearchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationFilterCopyWith<$Res>? get filter {
    if (_self.filter == null) {
    return null;
  }

  return $LocationFilterCopyWith<$Res>(_self.filter!, (value) {
    return _then(_self.copyWith(filter: value));
  });
}
}

// dart format on
