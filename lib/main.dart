import 'package:bookaround/interface/screen/login_screen.dart';
import 'package:bookaround/interface/screen/splash_screen.dart';
import 'package:bookaround/references.dart';
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
      routes: <String, Widget Function(BuildContext)>{
        SplashScreen.route: (BuildContext context) => SplashScreen(),
        LoginScreen.route: (BuildContext context) => LoginScreen(),
      },
    );
  }
}
