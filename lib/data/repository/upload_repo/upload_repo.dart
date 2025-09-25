import 'dart:io';

import 'package:flex_sense/data/data_source/network/models/requests/auth/login_params.dart';
import 'package:flex_sense/data/data_source/network/models/requests/auth/refresh_token_params.dart';
import 'package:flex_sense/data/data_source/network/models/responses/auth/login_response.dart';
import 'package:flex_sense/data/data_source/network/models/responses/auth/token_response.dart';

abstract class UploadRepo {
  Future<void> uploadFile(File csvFile);

  Future<TokenResponse> refreshToken(RefreshTokenParams params);

  Future<LoginResponse> login(LoginParams params);
}
