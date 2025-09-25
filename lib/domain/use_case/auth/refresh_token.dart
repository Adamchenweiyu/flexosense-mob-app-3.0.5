import 'dart:async';

import 'package:flex_sense/data/data_source/network/models/requests/auth/refresh_token_params.dart';
import 'package:flex_sense/data/data_source/network/models/responses/auth/token_response.dart';
import 'package:flex_sense/data/repository/upload_repo/upload_repo.dart';
import 'package:flex_sense/domain/use_case/use_case.dart';



class RefreshToken extends UseCase<TokenResponse, RefreshTokenParams> {
  final UploadRepo _uploadRepo;

  const RefreshToken(this._uploadRepo);

  @override
  Future<TokenResponse> call(RefreshTokenParams params) async {
    return await _uploadRepo.refreshToken(params);
  }
}