// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_locations_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MyLocationsState {

 LoadStatus get status; List<Location> get locations; int get page; bool get hasMore; bool get isLoadingMore; Set<int> get pendingRemovalIds; AppFailure? get failure;
/// Create a copy of MyLocationsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyLocationsStateCopyWith<MyLocationsState> get copyWith => _$MyLocationsStateCopyWithImpl<MyLocationsState>(this as MyLocationsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MyLocationsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyLocationsState&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.locations, _this.locations)&&(identical(other.page, _this.page) || other.page == _this.page)&&(identical(other.hasMore, _this.hasMore) || other.hasMore == _this.hasMore)&&(identical(other.isLoadingMore, _this.isLoadingMore) || other.isLoadingMore == _this.isLoadingMore)&&const DeepCollectionEquality().equals(other.pendingRemovalIds, _this.pendingRemovalIds)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as MyLocationsState;
  return Object.hash(runtimeType,_this.status,const DeepCollectionEquality().hash(_this.locations),_this.page,_this.hasMore,_this.isLoadingMore,const DeepCollectionEquality().hash(_this.pendingRemovalIds),_this.failure);
}

@override
String toString() {
  final _this = this as MyLocationsState;
  return 'MyLocationsState(status: ${_this.status}, locations: ${_this.locations}, page: ${_this.page}, hasMore: ${_this.hasMore}, isLoadingMore: ${_this.isLoadingMore}, pendingRemovalIds: ${_this.pendingRemovalIds}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $MyLocationsStateCopyWith<$Res>  {
  factory $MyLocationsStateCopyWith(MyLocationsState value, $Res Function(MyLocationsState) _then) = _$MyLocationsStateCopyWithImpl;
@useResult
$Res call({
 LoadStatus status, List<Location> locations, int page, bool hasMore, bool isLoadingMore, Set<int> pendingRemovalIds, AppFailure? failure
});




}
/// @nodoc
class _$MyLocationsStateCopyWithImpl<$Res>
    implements $MyLocationsStateCopyWith<$Res> {
  _$MyLocationsStateCopyWithImpl(this._self, this._then);

  final MyLocationsState _self;
  final $Res Function(MyLocationsState) _then;

/// Create a copy of MyLocationsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? locations = null,Object? page = null,Object? hasMore = null,Object? isLoadingMore = null,Object? pendingRemovalIds = null,Object? failure = freezed,}) {
  return _then(MyLocationsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,locations: null == locations ? _self.locations : locations // ignore: cast_nullable_to_non_nullable
as List<Location>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,pendingRemovalIds: null == pendingRemovalIds ? _self.pendingRemovalIds : pendingRemovalIds // ignore: cast_nullable_to_non_nullable
as Set<int>,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,
  ));
}

}


/// Adds pattern-matching-related methods to [MyLocationsState].
extension MyLocationsStatePatterns on MyLocationsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MyLocationsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MyLocationsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MyLocationsState value)  $default,){
final _that = this;
switch (_that) {
case _MyLocationsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MyLocationsState value)?  $default,){
final _that = this;
switch (_that) {
case _MyLocationsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoadStatus status,  List<Location> locations,  int page,  bool hasMore,  bool isLoadingMore,  Set<int> pendingRemovalIds,  AppFailure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MyLocationsState() when $default != null:
return $default(_that.status,_that.locations,_that.page,_that.hasMore,_that.isLoadingMore,_that.pendingRemovalIds,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoadStatus status,  List<Location> locations,  int page,  bool hasMore,  bool isLoadingMore,  Set<int> pendingRemovalIds,  AppFailure? failure)  $default,) {final _that = this;
switch (_that) {
case _MyLocationsState():
return $default(_that.status,_that.locations,_that.page,_that.hasMore,_that.isLoadingMore,_that.pendingRemovalIds,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoadStatus status,  List<Location> locations,  int page,  bool hasMore,  bool isLoadingMore,  Set<int> pendingRemovalIds,  AppFailure? failure)?  $default,) {final _that = this;
switch (_that) {
case _MyLocationsState() when $default != null:
return $default(_that.status,_that.locations,_that.page,_that.hasMore,_that.isLoadingMore,_that.pendingRemovalIds,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _MyLocationsState extends MyLocationsState {
  const _MyLocationsState({this.status = LoadStatus.initial,  List<Location> locations = const [], this.page = 0, this.hasMore = true, this.isLoadingMore = false,  Set<int> pendingRemovalIds = const <int>{}, this.failure}): _locations = locations,_pendingRemovalIds = pendingRemovalIds,super._();
  

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
 final  Set<int> _pendingRemovalIds;
@override@JsonKey() Set<int> get pendingRemovalIds {
  if (_pendingRemovalIds is EqualUnmodifiableSetView) return _pendingRemovalIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_pendingRemovalIds);
}

@override final  AppFailure? failure;

/// Create a copy of MyLocationsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MyLocationsStateCopyWith<_MyLocationsState> get copyWith => __$MyLocationsStateCopyWithImpl<_MyLocationsState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MyLocationsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.locations, _locations)&&(identical(other.page, page) || other.page == page)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&const DeepCollectionEquality().equals(other.pendingRemovalIds, _pendingRemovalIds)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_locations),page,hasMore,isLoadingMore,const DeepCollectionEquality().hash(_pendingRemovalIds),failure);
}

@override
String toString() {
    return 'MyLocationsState(status: $status, locations: $locations, page: $page, hasMore: $hasMore, isLoadingMore: $isLoadingMore, pendingRemovalIds: $pendingRemovalIds, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$MyLocationsStateCopyWith<$Res> implements $MyLocationsStateCopyWith<$Res> {
  factory _$MyLocationsStateCopyWith(_MyLocationsState value, $Res Function(_MyLocationsState) _then) = __$MyLocationsStateCopyWithImpl;
@override @useResult
$Res call({
 LoadStatus status, List<Location> locations, int page, bool hasMore, bool isLoadingMore, Set<int> pendingRemovalIds, AppFailure? failure
});




}
/// @nodoc
class __$MyLocationsStateCopyWithImpl<$Res>
    implements _$MyLocationsStateCopyWith<$Res> {
  __$MyLocationsStateCopyWithImpl(this._self, this._then);

  final _MyLocationsState _self;
  final $Res Function(_MyLocationsState) _then;

/// Create a copy of MyLocationsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? locations = null,Object? page = null,Object? hasMore = null,Object? isLoadingMore = null,Object? pendingRemovalIds = null,Object? failure = freezed,}) {
  return _then(_MyLocationsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,locations: null == locations ? _self._locations : locations // ignore: cast_nullable_to_non_nullable
as List<Location>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,pendingRemovalIds: null == pendingRemovalIds ? _self._pendingRemovalIds : pendingRemovalIds // ignore: cast_nullable_to_non_nullable
as Set<int>,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,
  ));
}


}

// dart format on
