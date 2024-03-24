import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeService {
  final Box _box = Hive.box('settings_theme');
  final String _key = 'isDarkMode';

  bool get isDarkMode => _box.get(_key, defaultValue: false);

  void toggleTheme(bool isDark) {
    _box.put(_key, isDark);
  }
}

class ThemeProvider with ChangeNotifier {
  final ThemeService _themeService = ThemeService();

  bool get isDarkMode => _themeService.isDarkMode;

  void toggleTheme(bool isDark) {
    _themeService.toggleTheme(isDark);
    notifyListeners();
  }

  ThemeMode get themeMode => isDarkMode ? ThemeMode.dark : ThemeMode.light;

  dynamic icon = MaterialStateProperty.resolveWith<Icon?>((Set<MaterialState> states) {
    if (states.contains(MaterialState.selected)) {
      return const Icon(Icons.dark_mode);
    } else {
      return const Icon(Icons.light_mode);
    }
  });
}
