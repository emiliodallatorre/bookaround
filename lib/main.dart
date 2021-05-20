/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:13.
 * Copyright (c) 2021. All rights reserved.
 * Last modified 20/05/21, 10:07.
 */

import 'package:bookaround/generated/l10n.dart';
import 'package:bookaround/interface/screen/book_editor_screen.dart';
import 'package:bookaround/interface/screen/book_screen.dart';
import 'package:bookaround/interface/screen/chat_screen.dart';
import 'package:bookaround/interface/screen/home_screen.dart';
import 'package:bookaround/interface/screen/isbn_editor_screen.dart';
import 'package:bookaround/interface/screen/login_screen.dart';
import 'package:bookaround/interface/screen/profile_editor_screen.dart';
import 'package:bookaround/interface/screen/search_screen.dart';
import 'package:bookaround/interface/screen/splash_screen.dart';
import 'package:bookaround/interface/screen/web_view_screen.dart';
import 'package:bookaround/models/settings_model.dart';
import 'package:bookaround/models/user_model.dart';
import 'package:bookaround/references.dart';
import 'package:bookaround/resources/provider/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Bookaround());
}

class Bookaround extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MaterialColor mainColor = Colors.teal;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => UserModel(uid: "")),
        ChangeNotifierProvider(create: (BuildContext context) => SettingsModel()),
        ChangeNotifierProvider(create: (BuildContext context) => LocationProvider()),
      ],
      builder: (BuildContext context, Widget? child) => OverlaySupport.global(
        child: MaterialApp(
          title: References.appName,
          theme: ThemeData(primarySwatch: mainColor, fontFamily: "Poppins"),
          darkTheme: ThemeData(
            fontFamily: "Poppins",
            brightness: Brightness.dark,
            primarySwatch: mainColor,
            accentColor: mainColor[500],
            toggleableActiveColor: mainColor[500],
            textSelectionTheme: TextSelectionThemeData(selectionColor: mainColor[200]),
          ),
          themeMode: ThemeMode.system,
          initialRoute: SplashScreen.route,
          supportedLocales: S.delegate.supportedLocales,
          localizationsDelegates: <LocalizationsDelegate>[
            S.delegate,
            GlobalMaterialLocalizations.delegate,
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
            ChatScreen.route: (BuildContext context) => ChatScreen(),
            WebViewScreen.route: (BuildContext context) => WebViewScreen(),
          },
        ),
      ),
    );
  }
}
