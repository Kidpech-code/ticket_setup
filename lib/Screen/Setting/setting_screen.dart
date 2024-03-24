import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ViewModel/lang.dart';
import '../../ViewModel/theme.dart';

class SettingApp extends StatelessWidget {
  const SettingApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeLanguage = Provider.of<LocaleProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(localeLanguage.translate('hello'), style: Theme.of(context).textTheme.headlineLarge),
            Text(localeLanguage.translate('welcome'), style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 20),
            DropdownButton(
              value: localeLanguage.currentLanguageCode,
              items: localeLanguage.supportedLanguages.map<DropdownMenuItem<String>>((lang) {
                return DropdownMenuItem(
                  value: lang['code'] as String,
                  child: Text(lang['name'] as String),
                );
              }).toList(),
              onChanged: (value) {
                localeLanguage.setLanguage(value as String);
              },
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text(
                localeLanguage.translate('button.confirm'),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                foregroundColor: Theme.of(context).colorScheme.onSecondary,
              ),
              child: Text(
                localeLanguage.translate('button.cancel'),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Theme Mode:', style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(width: 10),
                Switch(
                  thumbIcon: themeProvider.icon,
                  value: themeProvider.isDarkMode,
                  onChanged: (value) {
                    themeProvider.toggleTheme(value);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Home Screen'),
                  SizedBox(width: 8.0),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
