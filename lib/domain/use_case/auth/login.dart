import 'dart:async';

import 'package:flex_sense/data/data_source/network/models/requests/auth/login_params.dart';
import 'package:flex_sense/data/data_source/network/models/responses/auth/login_response.dart';
import 'package:flex_sense/data/repository/upload_repo/upload_repo.dart';
import 'package:flex_sense/domain/use_case/use_case.dart';

class Login extends UseCase<LoginResponse, LoginParams> {
  final UploadRepo _uploadRepo;

  const Login(this._uploadRepo);

  @override
  Future<LoginResponse> call(LoginParams params) async {
    return await _uploadRepo.login(params);
  }
}
