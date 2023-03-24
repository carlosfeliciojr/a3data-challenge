import 'package:flutter/material.dart';

class NavigationUtil extends Navigator {
  const NavigationUtil._();
  static const instance = NavigationUtil._();

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext? getContext() => navigatorKey.currentContext;

  static Future<dynamic> goTo({required String routeName}) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  static back() {
    return navigatorKey.currentState!.pop();
  }
}
