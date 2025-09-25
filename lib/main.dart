import 'dart:io';

import 'package:flex_sense/data/data_source/local/drift/app_database.dart';
import 'package:flex_sense/data/di/service_locator.dart';
import 'package:flex_sense/data/service/database_monitor_service.dart';
import 'package:flex_sense/data/service/database_queue_service.dart';
import 'package:flex_sense/presentation/globals/global_states/global/global_bloc.dart';
import 'package:flex_sense/presentation/l10n/support_locales.dart';
import 'package:flex_sense/plugin/ble_state/ble_state_plugin.dart';
import 'package:flex_sense/plugin/device_core/device_core_plugin.dart';
import 'package:flex_sense/presentation/globals/providers/global_bloc_provider.dart';
import 'package:flex_sense/presentation/navigation/app_navigation.dart';
import 'package:flex_sense/presentation/navigation/app_routes.dart';
import 'package:flex_sense/presentation/navigation/observer/route_observer_manager.dart';
import 'package:flex_sense/application/resource/styles/theme_manager.dart';
import 'package:flex_sense/application/util/app_version_utils.dart';
import 'package:flutter/material.dart';
import 'package:media_store_plus/media_store_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize service locator
  await injectDependencies();

  // Initialize database queue service
  await serviceLocator.get<DatabaseQueueService>().initialize(
    serviceLocator.get<AppDatabase>(),
  );

  // Start database monitoring
  serviceLocator.get<DatabaseMonitorService>().startMonitoring();

  // Register Flutter plugins
  BleStatePlugin.subscribeBluetoothStateEvents();
  DeviceCorePlugin.subscribeEvents();
  serviceLocator.get<GlobalBloc>().subscribeDeviceEventListener();

  // Initialize app version
  await AppVersionUtils.initialize();

  if (Platform.isAndroid) {
    await MediaStore.ensureInitialized(); //  ← must be awaited
    MediaStore.appFolder = 'FlexoSense'; // 👈 set once
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GlobalBlocProviders(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        // Localization
        localizationsDelegates: localeDelegates,
        supportedLocales: supportLocales,

        // Theme
        themeMode: ThemeMode.light,
        theme: ThemeApp.getTheme(),

        // Navigation
        navigatorKey: AppNavigation.navigatorKey,
        onGenerateRoute: AppNavigation.getRoutes,
        initialRoute: AppRoutes.splash,
        navigatorObservers: RouteObserverManager.listRouteObserver,
      ),
    );
  }
}
