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
    await initializeFirebase();

    await initializeCrashlytics();

    bool isLogged = await initializeUser();
    if (isLogged) await NotificationsHelper.initializeNotifications(Provider.of<UserModel>(context, listen: false));

    await Provider.of<SettingsModel>(context, listen: false).updateFromMemory();

    return isLogged;
  }

  Future<void> initializeFirebase() async => await Firebase.initializeApp();

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

  Future<void> initializeCrashlytics() async {
    if (kDebugMode)
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    else
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  }

  Future<void> deinitialize() async {
    Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.route, (route) => false);

    await FirebaseAuth.instance.signOut();
    await FirebaseMessaging.instance.deleteToken();
    await Provider.of<UserModel>(context, listen: false).updateFromServer(uid: null, empty: true);
  }
}
