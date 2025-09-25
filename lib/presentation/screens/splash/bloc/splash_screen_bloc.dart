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
    _setupLocale(context);
    _loginHardCodeUser();
  }

  void _setupLocale(BuildContext context) {
    Intl.defaultLocale = LocaleEnum.vi.getValueForDateTimeFormat;
    context.read<SystemBloc>().changeLocaleData(LocaleEnum.en);
  }

  Future<void> _loginHardCodeUser() async {
    try {
      final loginFunc = serviceLocator.get<Login>();

      final res = await loginFunc.call(
        const LoginParams(
          email: 'vo.khactuyen@gmail.com',
          password: 'ipc@12Ipc',
        ),
      );

      final accessTokenData = JwtDecoder.decode(res.accessToken);
      final userId = accessTokenData['username'];

      serviceLocator.get<OauthTokenManager>().saveUserId(userId);
      serviceLocator.get<UpdateDataHandler>().startSyncingData();

      AppStateHelper.handleInitialization();
    } catch (error) {
      Log.e('splash_screen_bloc loginHardCodeUser $error');
    }
  }
}
