// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dio/dio.dart';

import 'package:flex_sense/application/exception/base_exception.dart';
import 'package:flex_sense/application/exception/exceptions.dart';
import 'package:flex_sense/data/data_source/network/flexo_client/flexo_network_data_source.dart';
import 'package:flex_sense/data/data_source/network/models/requests/auth/login_params.dart';
import 'package:flex_sense/data/data_source/network/models/requests/auth/refresh_token_params.dart';
import 'package:flex_sense/data/data_source/network/models/responses/auth/login_response.dart';
import 'package:flex_sense/data/data_source/network/models/responses/auth/token_response.dart';
import 'package:flex_sense/data/data_source/network/models/responses/response.dart';
import 'package:flex_sense/data/repository/upload_repo/upload_repo.dart';

class UploadRepoImpl extends UploadRepo {
  final FlexoNetworkDataSource _flexoNetworkDataSource;

  UploadRepoImpl(this._flexoNetworkDataSource);

  @override
  Future<void> uploadFile(File csvFile) async {
    try {
      await _flexoNetworkDataSource.upload(csvFile);
    } on BaseException {
      print('BaseException');
      rethrow;
    } on DioException {
      print('DioException');
      throw UnauthorizedException();
    } catch (e) {
      print('e: $e');
      throw UnknownException(e);
    }
  }

  @override
  Future<TokenResponse> refreshToken(RefreshTokenParams params) async {
    try {
      final Res(data: tokenReponse) =
          await _flexoNetworkDataSource.refreshToken(params);
      return tokenReponse;
    } on BaseException {
      rethrow;
    } on DioException catch (e) {
      throw UnknownException(e);
    } catch (e) {
      throw UnknownException(e);
    }
  }

  @override
  Future<LoginResponse> login(LoginParams params) async {
    try {
      final Res(data: account) = await _flexoNetworkDataSource.login(params);

      // final oldUserId = await localDataSource.getUserId();

      // // Clear the old data when changing user
      // if (oldUserId != account.userId) {
      //   await localDataSource.clearUserInfo();
      //   await localDataSource.setUserId(account.userId);
      //   await localDataSource.setUserEmail(account.email);
      //   // provider.get<NotificationService>().clearAllNotifications();
      // }

      return account;
    } on BaseException {
      rethrow;
    } on DioException catch (e) {
      final messageCode = e.response?.data is Map //
          ? e.response?.data['messageCode']
          : null;

      // if (messageCode == DataInvalidException.messageCode) {
      //   throw DataInvalidException();
      // }

      // if (messageCode == AccountDeletedException.messageCode) {
      //   throw AccountDeletedException();
      // }

      // if (messageCode == AccountNotVerifiedException.messageCode) {
      //   throw AccountNotVerifiedException();
      // }

      // if (messageCode == AccountDoesNotExistException.messageCode) {
      //   throw AccountDoesNotExistException();
      // }

      // if (messageCode == IncorrectEmailOrPasswordException.messageCode) {
      //   throw IncorrectEmailOrPasswordException();
      // }

      throw UnknownException(e);
    } catch (e) {
      throw UnknownException(e);
    }
  }
}
