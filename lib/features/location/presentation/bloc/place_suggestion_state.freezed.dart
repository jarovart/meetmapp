// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'place_suggestion_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlaceSuggestionState {

 List<Place> get suggestions; bool get isLoading; AppFailure? get failure;
/// Create a copy of PlaceSuggestionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceSuggestionStateCopyWith<PlaceSuggestionState> get copyWith => _$PlaceSuggestionStateCopyWithImpl<PlaceSuggestionState>(this as PlaceSuggestionState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PlaceSuggestionState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceSuggestionState&&const DeepCollectionEquality().equals(other.suggestions, _this.suggestions)&&(identical(other.isLoading, _this.isLoading) || other.isLoading == _this.isLoading)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as PlaceSuggestionState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.suggestions),_this.isLoading,_this.failure);
}

@override
String toString() {
  final _this = this as PlaceSuggestionState;
  return 'PlaceSuggestionState(suggestions: ${_this.suggestions}, isLoading: ${_this.isLoading}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $PlaceSuggestionStateCopyWith<$Res>  {
  factory $PlaceSuggestionStateCopyWith(PlaceSuggestionState value, $Res Function(PlaceSuggestionState) _then) = _$PlaceSuggestionStateCopyWithImpl;
@useResult
$Res call({
 List<Place> suggestions, bool isLoading, AppFailure? failure
});




}
/// @nodoc
class _$PlaceSuggestionStateCopyWithImpl<$Res>
    implements $PlaceSuggestionStateCopyWith<$Res> {
  _$PlaceSuggestionStateCopyWithImpl(this._self, this._then);

  final PlaceSuggestionState _self;
  final $Res Function(PlaceSuggestionState) _then;

/// Create a copy of PlaceSuggestionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? suggestions = null,Object? isLoading = null,Object? failure = freezed,}) {
  return _then(PlaceSuggestionState(
suggestions: null == suggestions ? _self.suggestions : suggestions // ignore: cast_nullable_to_non_nullable
as List<Place>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlaceSuggestionState].
extension PlaceSuggestionStatePatterns on PlaceSuggestionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaceSuggestionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaceSuggestionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaceSuggestionState value)  $default,){
final _that = this;
switch (_that) {
case _PlaceSuggestionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaceSuggestionState value)?  $default,){
final _that = this;
switch (_that) {
case _PlaceSuggestionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Place> suggestions,  bool isLoading,  AppFailure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaceSuggestionState() when $default != null:
return $default(_that.suggestions,_that.isLoading,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Place> suggestions,  bool isLoading,  AppFailure? failure)  $default,) {final _that = this;
switch (_that) {
case _PlaceSuggestionState():
return $default(_that.suggestions,_that.isLoading,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Place> suggestions,  bool isLoading,  AppFailure? failure)?  $default,) {final _that = this;
switch (_that) {
case _PlaceSuggestionState() when $default != null:
return $default(_that.suggestions,_that.isLoading,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _PlaceSuggestionState implements PlaceSuggestionState {
  const _PlaceSuggestionState({ List<Place> suggestions = const [], this.isLoading = false, this.failure}): _suggestions = suggestions;
  

 final  List<Place> _suggestions;
@override@JsonKey() List<Place> get suggestions {
  if (_suggestions is EqualUnmodifiableListView) return _suggestions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_suggestions);
}

@override@JsonKey() final  bool isLoading;
@override final  AppFailure? failure;

/// Create a copy of PlaceSuggestionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceSuggestionStateCopyWith<_PlaceSuggestionState> get copyWith => __$PlaceSuggestionStateCopyWithImpl<_PlaceSuggestionState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceSuggestionState&&const DeepCollectionEquality().equals(other.suggestions, _suggestions)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_suggestions),isLoading,failure);
}

@override
String toString() {
    return 'PlaceSuggestionState(suggestions: $suggestions, isLoading: $isLoading, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$PlaceSuggestionStateCopyWith<$Res> implements $PlaceSuggestionStateCopyWith<$Res> {
  factory _$PlaceSuggestionStateCopyWith(_PlaceSuggestionState value, $Res Function(_PlaceSuggestionState) _then) = __$PlaceSuggestionStateCopyWithImpl;
@override @useResult
$Res call({
 List<Place> suggestions, bool isLoading, AppFailure? failure
});




}
/// @nodoc
class __$PlaceSuggestionStateCopyWithImpl<$Res>
    implements _$PlaceSuggestionStateCopyWith<$Res> {
  __$PlaceSuggestionStateCopyWithImpl(this._self, this._then);

  final _PlaceSuggestionState _self;
  final $Res Function(_PlaceSuggestionState) _then;

/// Create a copy of PlaceSuggestionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? suggestions = null,Object? isLoading = null,Object? failure = freezed,}) {
  return _then(_PlaceSuggestionState(
suggestions: null == suggestions ? _self._suggestions : suggestions // ignore: cast_nullable_to_non_nullable
as List<Place>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,
  ));
}


}

// dart format on
