import 'package:bookaround/generated/l10n.dart';
import 'package:bookaround/interface/screen/book_editor_screen.dart';
import 'package:bookaround/interface/screen/book_screen.dart';
import 'package:bookaround/interface/screen/home_screen.dart';
import 'package:bookaround/interface/screen/isbn_editor_screen.dart';
import 'package:bookaround/interface/screen/login_screen.dart';
import 'package:bookaround/interface/screen/profile_editor_screen.dart';
import 'package:bookaround/interface/screen/search_screen.dart';
import 'package:bookaround/interface/screen/splash_screen.dart';
import 'package:bookaround/models/settings_model.dart';
import 'package:bookaround/models/user_model.dart';
import 'package:bookaround/references.dart';
import 'package:bookaround/resources/provider/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Bookaround());
}

class Bookaround extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => UserModel()),
        ChangeNotifierProvider(create: (BuildContext context) => SettingsModel()),
        ChangeNotifierProvider(create: (BuildContext context) => LocationProvider()),
      ],
      builder: (BuildContext context, Widget child) => MaterialApp(
        title: References.appName,
        theme: ThemeData(primarySwatch: Colors.teal, fontFamily: "Poppins"),
        darkTheme: ThemeData(
          fontFamily: "Poppins",
          brightness: Brightness.dark,
          primarySwatch: Colors.orange,
          accentColor: Colors.orange[500],
          toggleableActiveColor: Colors.orange[500],
          textSelectionColor: Colors.orange[200],
        ),
        themeMode: ThemeMode.system,
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
          HomeScreen.route: (BuildContext context) => HomeScreen(),
          ProfileEditorScreen.route: (BuildContext context) => ProfileEditorScreen(),
          BookEditorScreen.route: (BuildContext context) => BookEditorScreen(),
          IsbnEditorScreen.route: (BuildContext context) => IsbnEditorScreen(),
          SearchScreen.route: (BuildContext context) => SearchScreen(),
          BookScreen.route: (BuildContext context) => BookScreen(),
        },
      ),
    );
  }
}
