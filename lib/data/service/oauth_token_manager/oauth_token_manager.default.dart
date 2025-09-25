import 'package:flex_sense/application/exception/exceptions.dart';
import 'package:flex_sense/application/util/date_time_utils.dart';
import 'package:flex_sense/data/data_source/network/models/requests/auth/refresh_token_params.dart';
import 'package:flex_sense/data/data_source/network/models/responses/auth/token_response.dart';
import 'package:flex_sense/data/di/service_locator.dart';
import 'package:flex_sense/data/service/oauth_token_manager/oauth_token_manager.dart';
import 'package:flex_sense/domain/use_case/auth/refresh_token.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class DefaultOauthTokenManager extends OauthTokenManager {
  static const String _prefix = '@@oauth-token';

  final String key;
  final FlutterSecureStorage _storage;

  const DefaultOauthTokenManager._(this.key, this._storage);

  const DefaultOauthTokenManager(FlutterSecureStorage storage, [String key = 'default'])
      : this._(key, storage);

  String get _accessTokenKey => '$_prefix/$key/accessToken';
  String get _refreshTokenKey => '$_prefix/$key/refreshToken';
  String get _userIdKey => '$_prefix/$key/userId';

  @override
  Future<Map<String, dynamic>?> getAuthenticatedHeaders(Map<String, dynamic> headers) async {
    final accessToken = await getAccessToken();
    var attempts = 3;

    if (accessToken == null) {
      return headers;
    }

    final tokenExpiredTime = JwtDecoder.getExpirationDate(accessToken);
    // if (kDebugMode) {
    print('tokenExpiredTime: $tokenExpiredTime');
    // }

    if (tokenExpiredTime.isExpiredToken()) {
      while (attempts > 0) {
        try {
          final newAccessToken = await _refreshNewToken();
          return {
            ...headers,
            'Authorization': 'Bearer $newAccessToken',
          };
        } catch (e) {
          attempts--;
        }
      }

      throw UnauthorizedException();
    }

    return {
      ...headers,
      'Authorization': 'Bearer $accessToken',
    };
  }

  Future<String> _refreshNewToken() async {
    final refreshToken = await getRefreshToken();
    final tokenExpiredTime = JwtDecoder.getExpirationDate(refreshToken ?? '');
    if (kDebugMode) {
      print('refreshToken tokenExpiredTime: $tokenExpiredTime');
    }
    final refreshTokenFunc = serviceLocator.get<RefreshToken>();
    final userId = await getUserId();

    final TokenResponse(
      accessToken: newAccessToken,
      refreshToken: newRefreshToken,
    ) = await refreshTokenFunc(
      RefreshTokenParams(
        username: userId ?? '',
        refreshToken: refreshToken ?? '',
      ),
    );

    await saveAccessToken(newAccessToken);
    await saveRefreshToken(newRefreshToken);

    return newAccessToken;
  }

  @override
  Future<String?> getAccessToken() async {
    return _storage.read(key: _accessTokenKey).onError((_, __) => null);
  }

  @override
  Future<String?> getRefreshToken() async {
    return _storage.read(key: _refreshTokenKey).onError((_, __) => null);
  }

  @override
  Future<void> saveAccessToken(String? token) {
    return _storage.write(key: _accessTokenKey, value: token);
  }

  @override
  Future<void> saveRefreshToken(String? token) {
    return _storage.write(key: _refreshTokenKey, value: token);
  }

  @override
  Future<void> removeAllTokens() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }

  @override
  Future<void> saveUserId(String userId) {
    return _storage.write(key: _userIdKey, value: userId);
  }

  @override
  Future<String?> getUserId() async {
    return _storage.read(key: _userIdKey).onError((_, __) => null);
  }
}
