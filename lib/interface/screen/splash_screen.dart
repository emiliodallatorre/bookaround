import 'package:bookaround/interface/screen/home_screen.dart';
import 'package:bookaround/interface/screen/login_screen.dart';
import 'package:bookaround/references.dart';
import 'package:bookaround/resources/helper/init_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  static const String route = "/splashScreen";

  @override
  Widget build(BuildContext context) {
    DateTime firstFrame = DateTime.now();

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await InitHelper(context).initialize().then((bool isLogged) async {
        // Fa durare la splash screen almeno 4 secondi.
        Duration elapsedTime = DateTime.now().difference(firstFrame);
        if (elapsedTime < Duration(seconds: 4)) await Future.delayed(Duration(seconds: 4) - elapsedTime);

        if (isLogged)
          Navigator.of(context).pushReplacementNamed(HomeScreen.route);
        else
          Navigator.of(context).pushReplacementNamed(LoginScreen.route);
      });
    });

    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(References.appName, style: GoogleFonts.lobster(textStyle: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 64.0))),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
