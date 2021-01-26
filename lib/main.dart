import 'package:bookaround/generated/l10n.dart';
import 'package:bookaround/interface/screen/login_screen.dart';
import 'package:bookaround/interface/screen/splash_screen.dart';
import 'package:bookaround/references.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Bookaround());
}

class Bookaround extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: References.appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: SplashScreen.route,
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: <LocalizationsDelegate>[
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        /*
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,*/
      ],
      routes: <String, Widget Function(BuildContext)>{
        SplashScreen.route: (BuildContext context) => SplashScreen(),
        LoginScreen.route: (BuildContext context) => LoginScreen(),
      },
    );
  }
}
