import 'package:bookaround/interface/screen/login_screen.dart';
import 'package:bookaround/resources/helper/init_helper.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const String route = "/splashScreen";

  @override
  Widget build(BuildContext context) {
    DateTime firstFrame = DateTime.now();
    InitHelper.initialize().whenComplete(() async {
      // Fa durare la splash screen almeno 4 secondi.
      Duration elapsedTime = DateTime.now().difference(firstFrame);
      if (elapsedTime < Duration(seconds: 4)) await Future.delayed(Duration(seconds: 4) - elapsedTime);

      Navigator.of(context).pushReplacementNamed(LoginScreen.route);
    });

    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
