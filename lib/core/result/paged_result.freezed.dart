// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paged_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PagedResult<T> {

 List<T> get items; bool get hasMore;
/// Create a copy of PagedResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PagedResultCopyWith<T, PagedResult<T>> get copyWith => _$PagedResultCopyWithImpl<T, PagedResult<T>>(this as PagedResult<T>, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PagedResult<T>;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PagedResult<T>&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.hasMore, _this.hasMore) || other.hasMore == _this.hasMore));
}


@override
int get hashCode {
  final _this = this as PagedResult<T>;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.items),_this.hasMore);
}

@override
String toString() {
  final _this = this as PagedResult<T>;
  return 'PagedResult<$T>(items: ${_this.items}, hasMore: ${_this.hasMore})';
}


}

/// @nodoc
abstract mixin class $PagedResultCopyWith<T,$Res>  {
  factory $PagedResultCopyWith(PagedResult<T> value, $Res Function(PagedResult<T>) _then) = _$PagedResultCopyWithImpl;
@useResult
$Res call({
 List<T> items, bool hasMore
});




}
/// @nodoc
class _$PagedResultCopyWithImpl<T,$Res>
    implements $PagedResultCopyWith<T, $Res> {
  _$PagedResultCopyWithImpl(this._self, this._then);

  final PagedResult<T> _self;
  final $Res Function(PagedResult<T>) _then;

/// Create a copy of PagedResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? hasMore = null,}) {
  return _then(PagedResult(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<T>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PagedResult].
extension PagedResultPatterns<T> on PagedResult<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PagedResult<T> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PagedResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PagedResult<T> value)  $default,){
final _that = this;
switch (_that) {
case _PagedResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PagedResult<T> value)?  $default,){
final _that = this;
switch (_that) {
case _PagedResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<T> items,  bool hasMore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PagedResult() when $default != null:
return $default(_that.items,_that.hasMore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<T> items,  bool hasMore)  $default,) {final _that = this;
switch (_that) {
case _PagedResult():
return $default(_that.items,_that.hasMore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<T> items,  bool hasMore)?  $default,) {final _that = this;
switch (_that) {
case _PagedResult() when $default != null:
return $default(_that.items,_that.hasMore);case _:
  return null;

}
}

}

/// @nodoc


class _PagedResult<T> implements PagedResult<T> {
  const _PagedResult({required  List<T> items, required this.hasMore}): _items = items;
  

 final  List<T> _items;
@override List<T> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  bool hasMore;

/// Create a copy of PagedResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PagedResultCopyWith<T, _PagedResult<T>> get copyWith => __$PagedResultCopyWithImpl<T, _PagedResult<T>>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PagedResult<T>&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),hasMore);
}

@override
String toString() {
    return 'PagedResult<$T>(items: $items, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class _$PagedResultCopyWith<T,$Res> implements $PagedResultCopyWith<T, $Res> {
  factory _$PagedResultCopyWith(_PagedResult<T> value, $Res Function(_PagedResult<T>) _then) = __$PagedResultCopyWithImpl;
@override @useResult
$Res call({
 List<T> items, bool hasMore
});




}
/// @nodoc
class __$PagedResultCopyWithImpl<T,$Res>
    implements _$PagedResultCopyWith<T, $Res> {
  __$PagedResultCopyWithImpl(this._self, this._then);

  final _PagedResult<T> _self;
  final $Res Function(_PagedResult<T>) _then;

/// Create a copy of PagedResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? hasMore = null,}) {
  return _then(_PagedResult<T>(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<T>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
