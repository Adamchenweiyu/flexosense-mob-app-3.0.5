import 'dart:async';
import 'dart:ui';

import 'package:flex_sense/application/env/env_config.dart';
import 'package:flex_sense/data/data_source/local/drift/app_database.dart';
import 'package:flex_sense/data/data_source/local/shared_prefs/shared_pref.dart';
import 'package:flex_sense/data/data_source/network/flexo_client/flexo_network_data_source.dart';
import 'package:flex_sense/data/data_source/network/network_dio.dart';
import 'package:flex_sense/data/data_source/network/schedulers/update_data_handler.dart';
import 'package:flex_sense/data/repository/imu_repo/imu_repo.dart';
import 'package:flex_sense/data/repository/imu_repo/imu_repo_impl.dart';
import 'package:flex_sense/data/repository/magnetic_repo/magnetic_repo.dart';
import 'package:flex_sense/data/repository/magnetic_repo/magnetic_repo_impl.dart';
import 'package:flex_sense/data/repository/pressure_repo/pressure_repo.dart';
import 'package:flex_sense/data/repository/pressure_repo/pressure_repo_impl.dart';
import 'package:flex_sense/data/repository/upload_repo/upload_repo.dart';
import 'package:flex_sense/data/repository/upload_repo/upload_repo_impl.dart';
import 'package:flex_sense/data/service/oauth_token_manager/oauth_token_manager.dart';
import 'package:flex_sense/data/service/oauth_token_manager/oauth_token_manager.default.dart';
import 'package:flex_sense/domain/use_case/auth/login.dart';
import 'package:flex_sense/domain/use_case/auth/refresh_token.dart';
import 'package:flex_sense/domain/use_case/upload/upload_data.dart';
import 'package:flex_sense/presentation/globals/global_states/global/global_bloc.dart';
import 'package:flex_sense/presentation/globals/global_states/system/system_bloc.dart';
import 'package:flex_sense/presentation/screens/connect_device/bloc/connect_device_screen_bloc.dart';
import 'package:flex_sense/presentation/screens/device_detail/bloc/device_detail_bloc.dart';
import 'package:flex_sense/presentation/screens/home/bloc/home_screen_bloc.dart';
import 'package:flex_sense/presentation/screens/splash/bloc/splash_screen_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

// Global service locator instance.
final serviceLocator = GetIt.instance;

FutureOr<void> injectDependencies() async {
  _registerDataSources();
  _registerRepositories();
  _registerUseCases();
  _registerStates();
}

void _registerDataSources() {
  serviceLocator.registerLazySingleton<AppDatabase>(
    () => AppDatabase(),
  );

  serviceLocator.registerSingleton<FlutterSecureStorage>(
    const FlutterSecureStorage(),
  );

  serviceLocator.registerSingleton<OauthTokenManager>(
    DefaultOauthTokenManager(serviceLocator.get<FlutterSecureStorage>()),
  );

  serviceLocator.registerSingleton<NetworkDio>(
    NetworkDio(
      baseUrl: EnvConfigApp.getEnv().endpoint,
      tokenManager: serviceLocator.get<OauthTokenManager>(),
    ),
  );

  serviceLocator.registerSingleton<FlexoNetworkDataSource>(
    FlexoNetworkDataSource(
      serviceLocator.get<NetworkDio>(),
    ),
  );

  serviceLocator.registerSingleton<SharedPref>(
    SharedPref(),
  );
}

void _registerRepositories() {
  serviceLocator.registerLazySingleton<ImuRepo>(
    () => ImuRepoImpl(
      serviceLocator.get<AppDatabase>(),
    ),
  );

  serviceLocator.registerLazySingleton<MagneticRepo>(
    () => MagneticRepoImpl(
      serviceLocator.get<AppDatabase>(),
    ),
  );

  serviceLocator.registerLazySingleton<PressureRepo>(
    () => PressureRepoImpl(
      serviceLocator.get<AppDatabase>(),
    ),
  );

  serviceLocator.registerLazySingleton<UploadRepo>(
    () => UploadRepoImpl(
      serviceLocator.get<FlexoNetworkDataSource>(),
    ),
  );
}

void _registerUseCases() {
  serviceLocator.registerLazySingleton<UploadData>(
    () => UploadData(
      serviceLocator.get<UploadRepo>(),
    ),
  );

  serviceLocator.registerLazySingleton<RefreshToken>(
    () => RefreshToken(
      serviceLocator.get<UploadRepo>(),
    ),
  );

  serviceLocator.registerLazySingleton<Login>(
    () => Login(
      serviceLocator.get<UploadRepo>(),
    ),
  );
}

void _registerStates() {
  // ******************* Global States *******************

  serviceLocator.registerSingleton<GlobalBloc>(
    GlobalBloc(),
  );

  serviceLocator.registerSingleton<UpdateDataHandler>(
    UpdateDataHandler(),
  );

  serviceLocator.registerSingleton<SystemBloc>(
    SystemBloc(
      locale: const Locale('en'),
    ),
  );

  // ******************* Screen States *******************

  serviceLocator.registerFactory<SplashScreenBloc>(() {
    return SplashScreenBloc();
  });

  serviceLocator.registerFactory<HomeScreenBloc>(() {
    return HomeScreenBloc();
  });

  serviceLocator.registerFactory<ConnectDeviceScreenBloc>(() {
    return ConnectDeviceScreenBloc();
  });

  serviceLocator.registerFactory<DeviceDetailBloc>(() {
    return DeviceDetailBloc();
  });
}
