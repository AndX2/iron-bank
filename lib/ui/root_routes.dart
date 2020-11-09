import 'package:flutter/material.dart';
import 'package:iron_bank/ui/main_screen.dart';
import 'package:iron_bank/ui/splash_screen.dart';

class RootRoutes {
  static const String splash = 'splash';
  static const String main = '';

  Route<dynamic> generateRoute(RouteSettings settings) {
    final firstPathSegment = settings.name.split('/').first;

    switch (firstPathSegment) {
      case splash:
        return SplashScreenRoute();
      case main:
        return MainScreenRoute();

      default:
        return SplashScreenRoute();
    }
  }
}
