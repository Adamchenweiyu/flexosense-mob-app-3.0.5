// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Res<T> _$ResFromJson<T>(
    Map<String, dynamic> json, T Function(Object?) fromJsonT) {
  return ResData<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$Res<T> {
  @JsonKey(name: 'data')
  T get data => throw _privateConstructorUsedError;

  /// Serializes this Res to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;

  /// Create a copy of Res
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ResCopyWith<T, Res<T>> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResCopyWith<T, $Res> {
  factory $ResCopyWith(Res<T> value, $Res Function(Res<T>) then) =
      _$ResCopyWithImpl<T, $Res, Res<T>>;
  @useResult
  $Res call({@JsonKey(name: 'data') T data});
}

/// @nodoc
class _$ResCopyWithImpl<T, $Res, $Val extends Res<T>>
    implements $ResCopyWith<T, $Res> {
  _$ResCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Res
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ResDataImplCopyWith<T, $Res>
    implements $ResCopyWith<T, $Res> {
  factory _$$ResDataImplCopyWith(
          _$ResDataImpl<T> value, $Res Function(_$ResDataImpl<T>) then) =
      __$$ResDataImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'data') T data});
}

/// @nodoc
class __$$ResDataImplCopyWithImpl<T, $Res>
    extends _$ResCopyWithImpl<T, $Res, _$ResDataImpl<T>>
    implements _$$ResDataImplCopyWith<T, $Res> {
  __$$ResDataImplCopyWithImpl(
      _$ResDataImpl<T> _value, $Res Function(_$ResDataImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of Res
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$ResDataImpl<T>(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _$ResDataImpl<T> implements ResData<T> {
  const _$ResDataImpl({@JsonKey(name: 'data') required this.data});

  factory _$ResDataImpl.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$$ResDataImplFromJson(json, fromJsonT);

  @override
  @JsonKey(name: 'data')
  final T data;

  @override
  String toString() {
    return 'Res<$T>(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResDataImpl<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  /// Create a copy of Res
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResDataImplCopyWith<T, _$ResDataImpl<T>> get copyWith =>
      __$$ResDataImplCopyWithImpl<T, _$ResDataImpl<T>>(this, _$identity);

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$ResDataImplToJson<T>(this, toJsonT);
  }
}

abstract class ResData<T> implements Res<T> {
  const factory ResData({@JsonKey(name: 'data') required final T data}) =
      _$ResDataImpl<T>;

  factory ResData.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =
      _$ResDataImpl<T>.fromJson;

  @override
  @JsonKey(name: 'data')
  T get data;

  /// Create a copy of Res
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResDataImplCopyWith<T, _$ResDataImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
