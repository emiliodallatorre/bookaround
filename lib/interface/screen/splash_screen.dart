/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:13.
 * Copyright (c) 2021. All rights reserved.
 * Last modified 20/05/21, 10:07.
 */

import 'package:bookaround/generated/l10n.dart';
import 'package:bookaround/interface/screen/home_screen.dart';
import 'package:bookaround/interface/screen/login_screen.dart';
import 'package:bookaround/interface/screen/profile_editor_screen.dart';
import 'package:bookaround/models/user_model.dart';
import 'package:bookaround/references.dart';
import 'package:bookaround/resources/helper/init_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static const String route = "/splashScreen";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // debugPrint(S.delegate.supportedLocales.toString());

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final DateTime firstFrame = DateTime.now();

      await InitHelper(context).initialize().then((bool isLogged) async {
        // Fa durare la splash screen almeno 4 secondi.
        Duration elapsedTime = DateTime.now().difference(firstFrame);
        if (elapsedTime < Duration(seconds: 2)) await Future.delayed(Duration(seconds: 2) - elapsedTime);

        if (isLogged && Provider.of<UserModel>(context, listen: false).name != null)
          Navigator.of(context).pushReplacementNamed(HomeScreen.route);
        else if (isLogged && Provider.of<UserModel>(context, listen: false).name == null)
          Navigator.of(context).pushReplacementNamed(ProfileEditorScreen.route);
        else
          Navigator.of(context).pushReplacementNamed(LoginScreen.route);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
