import 'package:flex_sense/application/exception/base_exception.dart';

class SSOServiceException extends BaseException {
  // SSO_ERROR_500_001: "Something went wrong."
  static const String messageCode = 'SSO_ERROR_500_001';
  SSOServiceException({String? message, super.code, super.data})
      : super(message ?? 'Unknown Error');
}

class UnauthorizedException extends SSOServiceException {
  // SSO_ERROR_401_001: “Invalid or expired token provided.”
  static const String messageCode = 'SSO_ERROR_401_001';

  UnauthorizedException({super.code, super.data})
      : super(message: 'Unauthorized');
}
