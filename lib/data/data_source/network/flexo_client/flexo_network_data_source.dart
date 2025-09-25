import 'dart:io';

import 'package:flex_sense/data/data_source/network/flexo_client/flexo_network_urls.dart';
import 'package:flex_sense/data/data_source/network/models/requests/auth/login_params.dart';
import 'package:flex_sense/data/data_source/network/models/requests/auth/refresh_token_params.dart';
import 'package:flex_sense/data/data_source/network/models/responses/auth/login_response.dart';
import 'package:flex_sense/data/data_source/network/models/responses/auth/token_response.dart';
import 'package:flex_sense/data/data_source/network/models/responses/response.dart';
import 'package:flex_sense/data/data_source/network/network_dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'flexo_network_data_source.g.dart';

@RestApi()
abstract class FlexoNetworkDataSource {
  factory FlexoNetworkDataSource(NetworkDio dio, {String baseUrl}) =
      _FlexoNetworkDataSource;

  @GET(FlexoNetworkUrls.report)
  Future<Res<String>> getReport();

  @POST(FlexoNetworkUrls.upload)
  Future<void> upload(@Part() File file);

  @POST(FlexoNetworkUrls.refreshToken)
  Future<Res<TokenResponse>> refreshToken(@Body() RefreshTokenParams params);

  @POST(FlexoNetworkUrls.login)
  Future<Res<LoginResponse>> login(@Body() LoginParams params);
}
