import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flex_sense/application/exception/base_exception.dart';
import 'package:flex_sense/application/exception/exceptions.dart';
import 'package:flex_sense/data/data_source/network/flexo_client/flexo_network_urls.dart';
import 'package:flex_sense/data/service/oauth_token_manager/oauth_token_manager.dart';

class NetworkDio extends DioForNative implements Interceptor {
  final OauthTokenManager _tokenManager;

  NetworkDio._(
    this._tokenManager,
    BaseOptions options,
  ) : super(options);

  factory NetworkDio({
    required OauthTokenManager tokenManager,
    required String baseUrl,
    Map<String, dynamic> headers = const {},
  }) {
    final BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      headers: headers,
      contentType: 'application/json; charset=utf-8',
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(minutes: 5),
    );

    final instance = NetworkDio._(tokenManager, options);

    instance.interceptors.add(instance);

    return instance;
  }

  void setLocale(String locale) {
    options.headers['locale'] = locale;
  }

  @override
  void onRequest(
    RequestOptions originalOptions,
    RequestInterceptorHandler handler,
  ) async {
    print('NetworkDio onRequest: ${originalOptions.data}');
    final options = originalOptions.copyWith();
    if (FlexoNetworkUrls.requireAuthentication(options.path)) {
      try {
        options.headers = await _tokenManager.getAuthenticatedHeaders(options.headers);
      } catch (e) {
        // serviceLocator.get<AuthBloc>().add(const AuthUnAuthorizedAccount());
        return handler.reject(UnauthorizedException());
      }
    }

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    print('NetworkDio onResponse: $response');
    if (response.requestOptions.path == FlexoNetworkUrls.login && response.data is Map) {
      final accessToken = response.data['data']?['sessionToken'];
      final refreshToken = response.data['data']?['refreshToken'];

      await Future.wait([
        _tokenManager.saveAccessToken(accessToken),
        _tokenManager.saveRefreshToken(refreshToken),
      ]);
    }

    // if (response.requestOptions.path == SSONetworkUrls.signUpVerifyCode && response.data is Map) {
    //   final accessToken = response.data['data']?['accessToken'];
    //   final refreshToken = response.data['data']?['refreshToken'];

    //   await Future.wait([
    //     _tokenManager.saveAccessToken(accessToken),
    //     _tokenManager.saveRefreshToken(refreshToken),
    //   ]);
    // }

    // if (response.requestOptions.path == SSONetworkUrls.logout) {
    //   await _tokenManager.removeAllTokens();
    // }

    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    print('NetworkDio onError: $err');
    final errorType = err.type;
    final responseData = err.response?.data;

    // if (err.requestOptions.path == SSONetworkUrls.logout) {
    //   await _tokenManager.removeAllTokens();
    // }

    if (err.error is SocketException || errorType == DioExceptionType.connectionError) {
      return handler.next(NetworkException());
    }

    if (errorType == DioExceptionType.connectionTimeout ||
        errorType == DioExceptionType.receiveTimeout ||
        errorType == DioExceptionType.sendTimeout) {
      return handler.next(UnknownException());
    }

    // Skipping unknown error
    if (responseData is! Map) {
      return handler.next(err);
    }

    if (responseData['messageCode'] == UnauthorizedException.messageCode) {
      await _tokenManager.removeAllTokens();
      return handler.next(UnauthorizedException(data: err.response?.data));
    }


    return handler.next(err);
  }
}
