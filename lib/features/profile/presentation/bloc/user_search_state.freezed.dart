// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_search_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserSearchState {

 LoadStatus get status; String get query; List<UserProfile> get users; int get page; bool get hasMore; bool get isLoadingMore; AppFailure? get failure;
/// Create a copy of UserSearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSearchStateCopyWith<UserSearchState> get copyWith => _$UserSearchStateCopyWithImpl<UserSearchState>(this as UserSearchState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as UserSearchState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSearchState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.query, _this.query) || other.query == _this.query)&&const DeepCollectionEquality().equals(other.users, _this.users)&&(identical(other.page, _this.page) || other.page == _this.page)&&(identical(other.hasMore, _this.hasMore) || other.hasMore == _this.hasMore)&&(identical(other.isLoadingMore, _this.isLoadingMore) || other.isLoadingMore == _this.isLoadingMore)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as UserSearchState;
  return Object.hash(runtimeType,_this.status,_this.query,const DeepCollectionEquality().hash(_this.users),_this.page,_this.hasMore,_this.isLoadingMore,_this.failure);
}

@override
String toString() {
  final _this = this as UserSearchState;
  return 'UserSearchState(status: ${_this.status}, query: ${_this.query}, users: ${_this.users}, page: ${_this.page}, hasMore: ${_this.hasMore}, isLoadingMore: ${_this.isLoadingMore}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $UserSearchStateCopyWith<$Res>  {
  factory $UserSearchStateCopyWith(UserSearchState value, $Res Function(UserSearchState) _then) = _$UserSearchStateCopyWithImpl;
@useResult
$Res call({
 LoadStatus status, String query, List<UserProfile> users, int page, bool hasMore, bool isLoadingMore, AppFailure? failure
});




}
/// @nodoc
class _$UserSearchStateCopyWithImpl<$Res>
    implements $UserSearchStateCopyWith<$Res> {
  _$UserSearchStateCopyWithImpl(this._self, this._then);

  final UserSearchState _self;
  final $Res Function(UserSearchState) _then;

/// Create a copy of UserSearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? query = null,Object? users = null,Object? page = null,Object? hasMore = null,Object? isLoadingMore = null,Object? failure = freezed,}) {
  return _then(UserSearchState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,users: null == users ? _self.users : users // ignore: cast_nullable_to_non_nullable
as List<UserProfile>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserSearchState].
extension UserSearchStatePatterns on UserSearchState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserSearchState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserSearchState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserSearchState value)  $default,){
final _that = this;
switch (_that) {
case _UserSearchState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserSearchState value)?  $default,){
final _that = this;
switch (_that) {
case _UserSearchState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoadStatus status,  String query,  List<UserProfile> users,  int page,  bool hasMore,  bool isLoadingMore,  AppFailure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserSearchState() when $default != null:
return $default(_that.status,_that.query,_that.users,_that.page,_that.hasMore,_that.isLoadingMore,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoadStatus status,  String query,  List<UserProfile> users,  int page,  bool hasMore,  bool isLoadingMore,  AppFailure? failure)  $default,) {final _that = this;
switch (_that) {
case _UserSearchState():
return $default(_that.status,_that.query,_that.users,_that.page,_that.hasMore,_that.isLoadingMore,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoadStatus status,  String query,  List<UserProfile> users,  int page,  bool hasMore,  bool isLoadingMore,  AppFailure? failure)?  $default,) {final _that = this;
switch (_that) {
case _UserSearchState() when $default != null:
return $default(_that.status,_that.query,_that.users,_that.page,_that.hasMore,_that.isLoadingMore,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _UserSearchState extends UserSearchState {
  const _UserSearchState({this.status = LoadStatus.initial, this.query = '',  List<UserProfile> users = const [], this.page = 0, this.hasMore = true, this.isLoadingMore = false, this.failure}): _users = users,super._();
  

@override@JsonKey() final  LoadStatus status;
@override@JsonKey() final  String query;
 final  List<UserProfile> _users;
@override@JsonKey() List<UserProfile> get users {
  if (_users is EqualUnmodifiableListView) return _users;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_users);
}

@override@JsonKey() final  int page;
@override@JsonKey() final  bool hasMore;
@override@JsonKey() final  bool isLoadingMore;
@override final  AppFailure? failure;

/// Create a copy of UserSearchState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserSearchStateCopyWith<_UserSearchState> get copyWith => __$UserSearchStateCopyWithImpl<_UserSearchState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserSearchState&&(identical(other.status, status) || other.status == status)&&(identical(other.query, query) || other.query == query)&&const DeepCollectionEquality().equals(other.users, _users)&&(identical(other.page, page) || other.page == page)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,query,const DeepCollectionEquality().hash(_users),page,hasMore,isLoadingMore,failure);
}

@override
String toString() {
    return 'UserSearchState(status: $status, query: $query, users: $users, page: $page, hasMore: $hasMore, isLoadingMore: $isLoadingMore, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$UserSearchStateCopyWith<$Res> implements $UserSearchStateCopyWith<$Res> {
  factory _$UserSearchStateCopyWith(_UserSearchState value, $Res Function(_UserSearchState) _then) = __$UserSearchStateCopyWithImpl;
@override @useResult
$Res call({
 LoadStatus status, String query, List<UserProfile> users, int page, bool hasMore, bool isLoadingMore, AppFailure? failure
});




}
/// @nodoc
class __$UserSearchStateCopyWithImpl<$Res>
    implements _$UserSearchStateCopyWith<$Res> {
  __$UserSearchStateCopyWithImpl(this._self, this._then);

  final _UserSearchState _self;
  final $Res Function(_UserSearchState) _then;

/// Create a copy of UserSearchState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? query = null,Object? users = null,Object? page = null,Object? hasMore = null,Object? isLoadingMore = null,Object? failure = freezed,}) {
  return _then(_UserSearchState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,users: null == users ? _self._users : users // ignore: cast_nullable_to_non_nullable
as List<UserProfile>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,
  ));
}


}

// dart format on
