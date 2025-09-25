
import 'package:flex_sense/application/util/logger.dart';
import 'package:flex_sense/presentation/navigation/app_navigation.dart';
import 'package:flex_sense/presentation/navigation/app_routes.dart';

enum AppState {
  ready,
}

class AppStateHelper {
  static void handleInitialization() {
    final state = _getInitialState();
    handleState(state);
  }

  static AppState _getInitialState() {
    return AppState.ready;
  }

  static void handleState(
    AppState state,
  ) {
    try {
      final context = AppNavigation.navigatorKey.currentContext!;
      switch (state) {
        case AppState.ready:
          AppNavigation.popAllAndRouteTo(context, AppRoutes.home);
          break;
        default:
          break;
      }
    } catch (error) {
      Log.e('app_state_helper handleState $error');
    }
  }
}
