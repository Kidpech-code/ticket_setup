import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:ticket_setup/Screen/Home/home_screen.dart';

import '../../Config/router.dart';
import '../../Config/text_theme.dart';
import '../../Config/theme_data.dart';
import '../../ViewModel/lang.dart';
import '../../ViewModel/navigation.dart';
import '../../ViewModel/theme.dart';

class App extends StatelessWidget {
  final NavigationService navigationService;

  const App({super.key, required this.navigationService});

  @override
  Widget build(BuildContext context) {
    return Consumer2<LocaleProvider, ThemeProvider>(
      builder: (context, localeProvider, themeProvider, child) {
        if (!localeProvider.isLocaleLoaded) {
          return MaterialApp(home: Container());
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightColorScheme,
            textTheme: buildTextTheme(lightColorScheme, context),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkColorScheme,
            textTheme: buildTextTheme(darkColorScheme, context),
          ),
          themeMode: themeProvider.themeMode,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: const TextScaler.linear(
                  1.0,
                ),
                alwaysUse24HourFormat: true,
              ),
              child: child!,
            );
          },
          locale: localeProvider.locale,
          localizationsDelegates: const [
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('th', 'TH'),
          ],
          navigatorKey: navigationService.navigatorKey,
          onGenerateRoute: AppRouter.generateRoute,
          home: const HomeScreen(),
        );
      },
    );
  }
}
