import 'package:dio/dio.dart';

abstract class BaseException<T> extends DioException implements Exception {
  @override
  // ignore: overridden_fields
  final String message;
  final String? code;
  final T? data;

  BaseException(
    this.message, {
    this.code,
    this.data,
    super.response,
    super.stackTrace,
    super.type,
    RequestOptions? requestOptions,
  }) : super(
          message: message,
          error: data,
          requestOptions: requestOptions ?? RequestOptions(path: ''),
        );

  static BaseException from(Object? error) {
    return error is BaseException ? error : UnknownException(error);
  }

  @override
  String toString() {
    return '$runtimeType'
        '('
        'message: $message'
        '${code != null ? ', code: $code' : ''}'
        '${data != null ? ', data: $data' : ''}'
        ')';
  }
}

class UnknownException extends BaseException {
  UnknownException([Object? error]) : super('Unknown Error', data: error);
}

class NetworkException extends BaseException {
  NetworkException() : super('Network Error');
}
