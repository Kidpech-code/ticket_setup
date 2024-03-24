import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../ViewModel/lang.dart';

TextTheme buildTextTheme(ColorScheme colorScheme, BuildContext context) {
  final localeLanguage = Provider.of<LocaleProvider>(context);

  String fontFamily() {
    switch (localeLanguage.locale.languageCode) {
      case 'th':
        return 'Noto Sans Thai';
      case 'en':
        return 'Kanit';
      case 'la':
        return 'Noto Sans Lao';
      default:
        return 'Kanit';
    }
  }

  TextStyle textStyle(String fontName) => GoogleFonts.getFont(fontName);

  return TextTheme(
    displayLarge: textStyle(fontFamily()).copyWith(fontSize: 57, color: colorScheme.onBackground, fontWeight: FontWeight.w400),
    displayMedium: textStyle(fontFamily()).copyWith(fontSize: 45, color: colorScheme.onBackground, fontWeight: FontWeight.w400),
    displaySmall: textStyle(fontFamily()).copyWith(fontSize: 36, color: colorScheme.onBackground, fontWeight: FontWeight.w400),
    headlineLarge: textStyle(fontFamily()).copyWith(fontSize: 32, color: colorScheme.onBackground, fontWeight: FontWeight.w400),
    headlineMedium: textStyle(fontFamily()).copyWith(fontSize: 28, color: colorScheme.onBackground, fontWeight: FontWeight.w400),
    headlineSmall: textStyle(fontFamily()).copyWith(fontSize: 24, color: colorScheme.onBackground, fontWeight: FontWeight.w400),
    titleLarge: textStyle(fontFamily()).copyWith(fontSize: 22, color: colorScheme.onBackground, fontWeight: FontWeight.w400),
    titleMedium: textStyle(fontFamily()).copyWith(fontSize: 16, color: colorScheme.onBackground, fontWeight: FontWeight.w500),
    titleSmall: textStyle(fontFamily()).copyWith(fontSize: 14, color: colorScheme.onBackground, fontWeight: FontWeight.w500),
    bodyLarge: textStyle(fontFamily()).copyWith(fontSize: 16, color: colorScheme.onBackground, fontWeight: FontWeight.w400),
    bodyMedium: textStyle(fontFamily()).copyWith(fontSize: 14, color: colorScheme.onBackground, fontWeight: FontWeight.w400),
    bodySmall: textStyle(fontFamily()).copyWith(fontSize: 12, color: colorScheme.onBackground, fontWeight: FontWeight.w400),
    labelLarge: textStyle(fontFamily()).copyWith(fontSize: 14, color: colorScheme.onBackground, fontWeight: FontWeight.w500),
    labelMedium: textStyle(fontFamily()).copyWith(fontSize: 12, color: colorScheme.onBackground, fontWeight: FontWeight.w500),
    labelSmall: textStyle(fontFamily()).copyWith(fontSize: 11, color: colorScheme.onBackground, fontWeight: FontWeight.w500),
  );
}
