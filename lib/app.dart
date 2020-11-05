import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'AppLocalizations.dart';

class App {
  MaterialApp mtApp;
  App(String title, Widget page, BuildContext context) {
    mtApp = MaterialApp(
      supportedLocales: [
        Locale("fa", "IR"),
        Locale("en", "US"),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      onGenerateTitle: (context) =>
          AppLocalizations.of(context).translate(title),
      home: page,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
    );
  }
}
