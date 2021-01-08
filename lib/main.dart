import 'package:bank_app_demo_fstt/Controllers/MyUserController.dart';
import 'package:bank_app_demo_fstt/Pages/HomePage.dart';
import 'package:flutter/material.dart';

import 'generated/l10n.dart';

void main() {
  MyUserControllers.init();
  runApp(MaterialApp(
    locale: Locale('en_US'),
    localizationsDelegates: [
      S.delegate,
    ],
    supportedLocales: S.delegate.supportedLocales,
    home: MyHomePage(),
    title: "Demo bank app",
  ));
}
