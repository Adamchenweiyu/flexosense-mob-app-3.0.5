import 'package:flex_sense/application/util/logger.dart';
import 'package:flex_sense/data/data_source/network/models/requests/auth/login_params.dart';
import 'package:flex_sense/data/data_source/network/schedulers/update_data_handler.dart';
import 'package:flex_sense/data/di/service_locator.dart';
import 'package:flex_sense/data/service/oauth_token_manager/oauth_token_manager.dart';
import 'package:flex_sense/domain/use_case/auth/login.dart';
import 'package:flex_sense/presentation/base_bloc/base_cubit.dart';
import 'package:flex_sense/presentation/globals/global_states/system/system_bloc.dart';
import 'package:flex_sense/presentation/l10n/locale_enum.dart';
import 'package:flex_sense/presentation/navigation/app_state/app_state_helper.dart';
import 'package:flex_sense/presentation/screens/splash/bloc/splash_screen_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class SplashScreenBloc extends BaseCubit<SplashScreenState> {
  SplashScreenBloc() : super(SplashScreenState());

  void setUpAppConfiguration(BuildContext context) {
    print('=== setUpAppConfiguration called ===');
    _setupLocale(context);
    print('Locale setup completed');
    _loginHardCodeUser();
    print('Login process initiated');
  }

  void _setupLocale(BuildContext context) {
    Intl.defaultLocale = LocaleEnum.vi.getValueForDateTimeFormat;
    context.read<SystemBloc>().changeLocaleData(LocaleEnum.en);
  }

  Future<void> _loginHardCodeUser() async {
    try {
      print('=== Starting hardcoded login ===');
      final loginFunc = serviceLocator.get<Login>();

      print('Calling login API...');
      final res = await loginFunc.call(
        const LoginParams(
          email: 'markTest@flexosense.com',
          password: 'newPassword1@',
        ),
      );

      print('Login successful!');
      print('Access token received: ${res.accessToken.substring(0, 50)}...');

      final accessTokenData = JwtDecoder.decode(res.accessToken);
      final userId = accessTokenData['username'];
      print('User ID extracted: $userId');

      await serviceLocator.get<OauthTokenManager>().saveUserId(userId);
      print('User ID saved to secure storage');

      print('Starting data sync...');
      final updateDataHandler = serviceLocator.get<UpdateDataHandler>();
      print('UpdateDataHandler retrieved: ${updateDataHandler.runtimeType}');
      updateDataHandler.startSyncingData();
      print('Data sync started successfully');

      // Add a small delay to ensure sync is properly initialized
      await Future.delayed(const Duration(seconds: 2));
      print('Delay completed, proceeding with app initialization...');

      print('Handling app initialization...');
      AppStateHelper.handleInitialization();
      print('App initialization completed');
    } catch (error) {
      print('=== Login failed ===');
      print('Error: $error');
      print('Error type: ${error.runtimeType}');
      Log.e('splash_screen_bloc loginHardCodeUser $error');
    }
  }
}
