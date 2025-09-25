
import 'package:flex_sense/application/util/logger.dart';
import 'package:flex_sense/presentation/navigation/app_navigation.dart';
import 'package:flex_sense/presentation/navigation/app_routes.dart';

enum AppState {
  ready,
}

class AppStateHelper {
  static void handleInitialization() {
    print('=== AppStateHelper.handleInitialization called ===');
    final state = _getInitialState();
    print('Initial state: $state');
    handleState(state);
  }

  static AppState _getInitialState() {
    return AppState.ready;
  }

  static void handleState(
    AppState state,
  ) {
    try {
      print('=== AppStateHelper.handleState called ===');
      print('State: $state');
      final context = AppNavigation.navigatorKey.currentContext!;
      print('Context retrieved successfully');
      switch (state) {
        case AppState.ready:
          print('Navigating to home screen...');
          AppNavigation.popAllAndRouteTo(context, AppRoutes.home);
          print('Navigation completed');
          break;
        default:
          print('Unknown state: $state');
          break;
      }
    } catch (error) {
      print('AppStateHelper.handleState error: $error');
      Log.e('app_state_helper handleState $error');
    }
  }
}
