// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SettingsProfile {

 int get id; Locale? get locale; AppDesign get design; DateTime get updatedAt;
/// Create a copy of SettingsProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsProfileCopyWith<SettingsProfile> get copyWith => _$SettingsProfileCopyWithImpl<SettingsProfile>(this as SettingsProfile, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SettingsProfile;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsProfile&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.locale, _this.locale) || other.locale == _this.locale)&&(identical(other.design, _this.design) || other.design == _this.design)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}


@override
int get hashCode {
  final _this = this as SettingsProfile;
  return Object.hash(runtimeType,_this.id,_this.locale,_this.design,_this.updatedAt);
}

@override
String toString() {
  final _this = this as SettingsProfile;
  return 'SettingsProfile(id: ${_this.id}, locale: ${_this.locale}, design: ${_this.design}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $SettingsProfileCopyWith<$Res>  {
  factory $SettingsProfileCopyWith(SettingsProfile value, $Res Function(SettingsProfile) _then) = _$SettingsProfileCopyWithImpl;
@useResult
$Res call({
 int id, Locale? locale, AppDesign design, DateTime updatedAt
});




}
/// @nodoc
class _$SettingsProfileCopyWithImpl<$Res>
    implements $SettingsProfileCopyWith<$Res> {
  _$SettingsProfileCopyWithImpl(this._self, this._then);

  final SettingsProfile _self;
  final $Res Function(SettingsProfile) _then;

/// Create a copy of SettingsProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? locale = freezed,Object? design = null,Object? updatedAt = null,}) {
  return _then(SettingsProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,locale: freezed == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as Locale?,design: null == design ? _self.design : design // ignore: cast_nullable_to_non_nullable
as AppDesign,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [SettingsProfile].
extension SettingsProfilePatterns on SettingsProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettingsProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettingsProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettingsProfile value)  $default,){
final _that = this;
switch (_that) {
case _SettingsProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettingsProfile value)?  $default,){
final _that = this;
switch (_that) {
case _SettingsProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  Locale? locale,  AppDesign design,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettingsProfile() when $default != null:
return $default(_that.id,_that.locale,_that.design,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  Locale? locale,  AppDesign design,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _SettingsProfile():
return $default(_that.id,_that.locale,_that.design,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  Locale? locale,  AppDesign design,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _SettingsProfile() when $default != null:
return $default(_that.id,_that.locale,_that.design,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _SettingsProfile implements SettingsProfile {
  const _SettingsProfile({required this.id, required this.locale, required this.design, required this.updatedAt});
  

@override final  int id;
@override final  Locale? locale;
@override final  AppDesign design;
@override final  DateTime updatedAt;

/// Create a copy of SettingsProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsProfileCopyWith<_SettingsProfile> get copyWith => __$SettingsProfileCopyWithImpl<_SettingsProfile>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.design, design) || other.design == design)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,locale,design,updatedAt);
}

@override
String toString() {
    return 'SettingsProfile(id: $id, locale: $locale, design: $design, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$SettingsProfileCopyWith<$Res> implements $SettingsProfileCopyWith<$Res> {
  factory _$SettingsProfileCopyWith(_SettingsProfile value, $Res Function(_SettingsProfile) _then) = __$SettingsProfileCopyWithImpl;
@override @useResult
$Res call({
 int id, Locale? locale, AppDesign design, DateTime updatedAt
});




}
/// @nodoc
class __$SettingsProfileCopyWithImpl<$Res>
    implements _$SettingsProfileCopyWith<$Res> {
  __$SettingsProfileCopyWithImpl(this._self, this._then);

  final _SettingsProfile _self;
  final $Res Function(_SettingsProfile) _then;

/// Create a copy of SettingsProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? locale = freezed,Object? design = null,Object? updatedAt = null,}) {
  return _then(_SettingsProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,locale: freezed == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as Locale?,design: null == design ? _self.design : design // ignore: cast_nullable_to_non_nullable
as AppDesign,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
