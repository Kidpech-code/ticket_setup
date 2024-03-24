// Router model (MVVM)
import 'package:flutter/material.dart';
import '../Screen/Home/home_screen.dart';
import '../Screen/Setting/setting_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      
      case '/setting':
        return MaterialPageRoute(builder: (_) => const SettingApp());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('No route defined for '),
            ),
          ),
          settings: settings,
        );
    }
  }
}
