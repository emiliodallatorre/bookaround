import 'package:bookaround/interface/screen/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const String route = "/splashScreen";

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 4)).whenComplete(() => Navigator.of(context).pushReplacementNamed(LoginScreen.route));

    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
