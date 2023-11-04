/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:13.
 * Copyright (c) 2021. All rights reserved.
 * Last modified 20/05/21, 10:07.
 */

import 'package:bookaround/firebase_options.dart';
import 'package:bookaround/interface/screen/login_screen.dart';
import 'package:bookaround/models/settings_model.dart';
import 'package:bookaround/models/user_model.dart';
import 'package:bookaround/resources/helper/notifications_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class InitHelper {
  final BuildContext context;

  InitHelper(this.context);

  Future<bool> initialize() async {
    if (Firebase.apps.isEmpty) {
      await initializeFirebase();
    }

    initializeCrashlytics();

    bool isLogged = await initializeUser();
    if (isLogged) await NotificationsHelper.initializeNotifications(Provider.of<UserModel>(context, listen: false), context);

    await Provider.of<SettingsModel>(context, listen: false).updateFromMemory();

    return isLogged;
  }

  static void initializeCrashlytics() async {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    debugPrint("Crashlytics inizializzato.");
  }

  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  Future<bool> initializeUser() async {
    try {
      final String? uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null)
        throw ("Utente non loggato!");
      else {
        debugPrint("L'uid dell'utente è $uid.");
        await Provider.of<UserModel>(context, listen: false).updateFromServer(uid: uid);
        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("L'utente non è loggato.");
      return false;
    }
  }

  Future<void> deinitialize() async {
    Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.route, (route) => false);

    await FirebaseAuth.instance.signOut();
    await FirebaseMessaging.instance.deleteToken();
    await Provider.of<UserModel>(context, listen: false).updateFromServer(uid: null, empty: true);
  }
}
