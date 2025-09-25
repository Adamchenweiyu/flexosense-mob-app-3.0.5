import 'package:flex_sense/presentation/navigation/observer/app_nav_observer.dart';
import 'package:flutter/material.dart';

class RouteObserverManager {
  static List<NavigatorObserver> listRouteObserver = [
    AppNavObserver(),
  ];
}
