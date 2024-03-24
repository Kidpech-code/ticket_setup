import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'Screen/App/app.dart';
import 'ViewModel/catalog.dart';
import 'ViewModel/lang.dart';
import 'ViewModel/navigation.dart';
import 'ViewModel/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var navigationService = NavigationService();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  await Hive.openBox('settings_language');
  await Hive.openBox('settings_theme');
  await Hive.openBox('cartBox');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LocaleProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CatalogViewModel(),
        ),
      ],
      child: App(navigationService: navigationService),
    ),
  );
}
