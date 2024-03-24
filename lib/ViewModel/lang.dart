import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../Config/locales_language.dart';

class LocaleProvider with ChangeNotifier {
  LocalesLanguage localesLanguage = LocalesLanguage();
  Locale? _locale;
  var _localizedStrings = {};

  LocaleProvider() {
    _loadSavedLocale();
  }
  Locale get locale => _locale ?? const Locale('la');
  bool get isLocaleLoaded => _locale != null;

  String _currentLanguageCode = '';
  String get currentLanguageCode => _locale?.languageCode ?? 'la';

  Future<void> _loadSavedLocale() async {
    final box = await Hive.openBox('settings_language');
    var localeCode = box.get('localeCode', defaultValue: 'la');
    _locale = Locale(localeCode);
    await loadLanguage();
  }

  Future<void> loadLanguage() async {
    String jsonString = await rootBundle.loadString('assets/lang/${_locale?.languageCode}.json');
    _localizedStrings = _localizedStrings = json.decode(jsonString);
    notifyListeners();
  }

  String translate(String key) {
    final keys = key.split('.');
    dynamic value = _localizedStrings;

    for (String k in keys) {
      if (value is Map<String, dynamic>) {
        value = value[k];
      } else {
        break;
      }
    }

    if (value is String) {
      return value;
    } else {
      return '';
    }
  }

  void setLanguage(String newLanguageCode) async {
    _currentLanguageCode = newLanguageCode;
    _locale = Locale(newLanguageCode);
    final box = await Hive.openBox('settings_language');
    await box.put('localeCode', newLanguageCode);
    await loadLanguage();
    notifyListeners();
  }

  String get currentLanguageName {
    return localesLanguage.getLanguageName(_currentLanguageCode);
  }

  List get supportedLanguages => localesLanguage.supportedLanguages;
}
