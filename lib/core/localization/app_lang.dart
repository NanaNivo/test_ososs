import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:test_ososs/core/localization/app_localization.dart';




enum AppLanguages { es, en }

class LocalizationManager {

 static Locale localeFactory(AppLanguages lang) {
    switch (lang) {
      case AppLanguages.en:
        return const Locale('en', '');
      case AppLanguages.es:
        return const Locale('es', '');
      default:
        return const Locale('en', '');
    }
  }

  static get createLocalizationsDelegates => [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    DefaultCupertinoLocalizations.delegate,
  ];

 static get createSupportedLocals => const [
   Locale('en', ''), // English
   Locale('es', ''), // Arabic
 ];
}

extension Translation on String {
  String tr(BuildContext context) =>
      AppLocalizations.of(context).text(this);
}
