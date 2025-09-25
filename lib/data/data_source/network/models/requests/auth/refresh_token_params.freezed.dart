// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'refresh_token_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RefreshTokenParams _$RefreshTokenParamsFromJson(Map<String, dynamic> json) {
  return _RefreshTokenParams.fromJson(json);
}

/// @nodoc
mixin _$RefreshTokenParams {
  @JsonKey(name: 'username')
  String get username => throw _privateConstructorUsedError;
  @JsonKey(name: 'refreshToken')
  String get refreshToken => throw _privateConstructorUsedError;

  /// Serializes this RefreshTokenParams to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RefreshTokenParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RefreshTokenParamsCopyWith<RefreshTokenParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RefreshTokenParamsCopyWith<$Res> {
  factory $RefreshTokenParamsCopyWith(
          RefreshTokenParams value, $Res Function(RefreshTokenParams) then) =
      _$RefreshTokenParamsCopyWithImpl<$Res, RefreshTokenParams>;
  @useResult
  $Res call(
      {@JsonKey(name: 'username') String username,
      @JsonKey(name: 'refreshToken') String refreshToken});
}

/// @nodoc
class _$RefreshTokenParamsCopyWithImpl<$Res, $Val extends RefreshTokenParams>
    implements $RefreshTokenParamsCopyWith<$Res> {
  _$RefreshTokenParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RefreshTokenParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? refreshToken = null,
  }) {
    return _then(_value.copyWith(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RefreshTokenParamsImplCopyWith<$Res>
    implements $RefreshTokenParamsCopyWith<$Res> {
  factory _$$RefreshTokenParamsImplCopyWith(_$RefreshTokenParamsImpl value,
          $Res Function(_$RefreshTokenParamsImpl) then) =
      __$$RefreshTokenParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'username') String username,
      @JsonKey(name: 'refreshToken') String refreshToken});
}

/// @nodoc
class __$$RefreshTokenParamsImplCopyWithImpl<$Res>
    extends _$RefreshTokenParamsCopyWithImpl<$Res, _$RefreshTokenParamsImpl>
    implements _$$RefreshTokenParamsImplCopyWith<$Res> {
  __$$RefreshTokenParamsImplCopyWithImpl(_$RefreshTokenParamsImpl _value,
      $Res Function(_$RefreshTokenParamsImpl) _then)
      : super(_value, _then);

  /// Create a copy of RefreshTokenParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? refreshToken = null,
  }) {
    return _then(_$RefreshTokenParamsImpl(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RefreshTokenParamsImpl extends _RefreshTokenParams {
  const _$RefreshTokenParamsImpl(
      {@JsonKey(name: 'username') required this.username,
      @JsonKey(name: 'refreshToken') required this.refreshToken})
      : super._();

  factory _$RefreshTokenParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$RefreshTokenParamsImplFromJson(json);

  @override
  @JsonKey(name: 'username')
  final String username;
  @override
  @JsonKey(name: 'refreshToken')
  final String refreshToken;

  @override
  String toString() {
    return 'RefreshTokenParams(username: $username, refreshToken: $refreshToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RefreshTokenParamsImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, username, refreshToken);

  /// Create a copy of RefreshTokenParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RefreshTokenParamsImplCopyWith<_$RefreshTokenParamsImpl> get copyWith =>
      __$$RefreshTokenParamsImplCopyWithImpl<_$RefreshTokenParamsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RefreshTokenParamsImplToJson(
      this,
    );
  }
}

abstract class _RefreshTokenParams extends RefreshTokenParams {
  const factory _RefreshTokenParams(
          {@JsonKey(name: 'username') required final String username,
          @JsonKey(name: 'refreshToken') required final String refreshToken}) =
      _$RefreshTokenParamsImpl;
  const _RefreshTokenParams._() : super._();

  factory _RefreshTokenParams.fromJson(Map<String, dynamic> json) =
      _$RefreshTokenParamsImpl.fromJson;

  @override
  @JsonKey(name: 'username')
  String get username;
  @override
  @JsonKey(name: 'refreshToken')
  String get refreshToken;

  /// Create a copy of RefreshTokenParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RefreshTokenParamsImplCopyWith<_$RefreshTokenParamsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
