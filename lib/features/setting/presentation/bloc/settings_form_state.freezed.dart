// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_form_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SettingsFormState {

 LoadStatus get status; AppSettings get draft; AppSettings get saved; bool get isSaving; AppFailure? get failure;
/// Create a copy of SettingsFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsFormStateCopyWith<SettingsFormState> get copyWith => _$SettingsFormStateCopyWithImpl<SettingsFormState>(this as SettingsFormState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SettingsFormState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsFormState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.draft, _this.draft) || other.draft == _this.draft)&&(identical(other.saved, _this.saved) || other.saved == _this.saved)&&(identical(other.isSaving, _this.isSaving) || other.isSaving == _this.isSaving)&&(identical(other.failure, _this.failure) || other.failure == _this.failure));
}


@override
int get hashCode {
  final _this = this as SettingsFormState;
  return Object.hash(runtimeType,_this.status,_this.draft,_this.saved,_this.isSaving,_this.failure);
}

@override
String toString() {
  final _this = this as SettingsFormState;
  return 'SettingsFormState(status: ${_this.status}, draft: ${_this.draft}, saved: ${_this.saved}, isSaving: ${_this.isSaving}, failure: ${_this.failure})';
}


}

/// @nodoc
abstract mixin class $SettingsFormStateCopyWith<$Res>  {
  factory $SettingsFormStateCopyWith(SettingsFormState value, $Res Function(SettingsFormState) _then) = _$SettingsFormStateCopyWithImpl;
@useResult
$Res call({
 LoadStatus status, AppSettings draft, AppSettings saved, bool isSaving, AppFailure? failure
});


$AppSettingsCopyWith<$Res> get draft;$AppSettingsCopyWith<$Res> get saved;

}
/// @nodoc
class _$SettingsFormStateCopyWithImpl<$Res>
    implements $SettingsFormStateCopyWith<$Res> {
  _$SettingsFormStateCopyWithImpl(this._self, this._then);

  final SettingsFormState _self;
  final $Res Function(SettingsFormState) _then;

/// Create a copy of SettingsFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? draft = null,Object? saved = null,Object? isSaving = null,Object? failure = freezed,}) {
  return _then(SettingsFormState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as AppSettings,saved: null == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as AppSettings,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,
  ));
}
/// Create a copy of SettingsFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppSettingsCopyWith<$Res> get draft {
  
  return $AppSettingsCopyWith<$Res>(_self.draft, (value) {
    return _then(_self.copyWith(draft: value));
  });
}/// Create a copy of SettingsFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppSettingsCopyWith<$Res> get saved {
  
  return $AppSettingsCopyWith<$Res>(_self.saved, (value) {
    return _then(_self.copyWith(saved: value));
  });
}
}


/// Adds pattern-matching-related methods to [SettingsFormState].
extension SettingsFormStatePatterns on SettingsFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettingsFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettingsFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettingsFormState value)  $default,){
final _that = this;
switch (_that) {
case _SettingsFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettingsFormState value)?  $default,){
final _that = this;
switch (_that) {
case _SettingsFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoadStatus status,  AppSettings draft,  AppSettings saved,  bool isSaving,  AppFailure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettingsFormState() when $default != null:
return $default(_that.status,_that.draft,_that.saved,_that.isSaving,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoadStatus status,  AppSettings draft,  AppSettings saved,  bool isSaving,  AppFailure? failure)  $default,) {final _that = this;
switch (_that) {
case _SettingsFormState():
return $default(_that.status,_that.draft,_that.saved,_that.isSaving,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoadStatus status,  AppSettings draft,  AppSettings saved,  bool isSaving,  AppFailure? failure)?  $default,) {final _that = this;
switch (_that) {
case _SettingsFormState() when $default != null:
return $default(_that.status,_that.draft,_that.saved,_that.isSaving,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _SettingsFormState extends SettingsFormState {
  const _SettingsFormState({this.status = LoadStatus.initial, required this.draft, required this.saved, this.isSaving = false, this.failure}): super._();
  

@override@JsonKey() final  LoadStatus status;
@override final  AppSettings draft;
@override final  AppSettings saved;
@override@JsonKey() final  bool isSaving;
@override final  AppFailure? failure;

/// Create a copy of SettingsFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsFormStateCopyWith<_SettingsFormState> get copyWith => __$SettingsFormStateCopyWithImpl<_SettingsFormState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsFormState&&(identical(other.status, status) || other.status == status)&&(identical(other.draft, draft) || other.draft == draft)&&(identical(other.saved, saved) || other.saved == saved)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,draft,saved,isSaving,failure);
}

@override
String toString() {
    return 'SettingsFormState(status: $status, draft: $draft, saved: $saved, isSaving: $isSaving, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$SettingsFormStateCopyWith<$Res> implements $SettingsFormStateCopyWith<$Res> {
  factory _$SettingsFormStateCopyWith(_SettingsFormState value, $Res Function(_SettingsFormState) _then) = __$SettingsFormStateCopyWithImpl;
@override @useResult
$Res call({
 LoadStatus status, AppSettings draft, AppSettings saved, bool isSaving, AppFailure? failure
});


@override $AppSettingsCopyWith<$Res> get draft;@override $AppSettingsCopyWith<$Res> get saved;

}
/// @nodoc
class __$SettingsFormStateCopyWithImpl<$Res>
    implements _$SettingsFormStateCopyWith<$Res> {
  __$SettingsFormStateCopyWithImpl(this._self, this._then);

  final _SettingsFormState _self;
  final $Res Function(_SettingsFormState) _then;

/// Create a copy of SettingsFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? draft = null,Object? saved = null,Object? isSaving = null,Object? failure = freezed,}) {
  return _then(_SettingsFormState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoadStatus,draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as AppSettings,saved: null == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as AppSettings,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as AppFailure?,
  ));
}

/// Create a copy of SettingsFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppSettingsCopyWith<$Res> get draft {
  
  return $AppSettingsCopyWith<$Res>(_self.draft, (value) {
    return _then(_self.copyWith(draft: value));
  });
}/// Create a copy of SettingsFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppSettingsCopyWith<$Res> get saved {
  
  return $AppSettingsCopyWith<$Res>(_self.saved, (value) {
    return _then(_self.copyWith(saved: value));
  });
}
}

// dart format on
