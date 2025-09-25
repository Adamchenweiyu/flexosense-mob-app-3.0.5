import 'package:freezed_annotation/freezed_annotation.dart';

part 'refresh_token_params.freezed.dart';
part 'refresh_token_params.g.dart';

@freezed
class RefreshTokenParams with _$RefreshTokenParams {
  const RefreshTokenParams._();

  const factory RefreshTokenParams({
    @JsonKey(name: 'username') required String username,
    @JsonKey(name: 'refreshToken') required String refreshToken,
  }) = _RefreshTokenParams;

  factory RefreshTokenParams.fromJson(Map<String, Object?> json) =>
      _$RefreshTokenParamsFromJson(json);
}
