import 'package:bookaround/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class InitHelper {
  final BuildContext context;

  InitHelper(this.context);

  Future<void> initialize() async {
    await initializeFirebase();
    bool isLogged = await initializeUser();
    // TODO: Reimplementare.
    // if (isLogged) await NotificationsHelper.initializeNotifications(Provider.of<UserModel>(context, listen: false));
  }

  Future<void> initializeFirebase() async => await Firebase.initializeApp();

  Future<bool> initializeUser() async {
    try {
      final String uid = FirebaseAuth.instance.currentUser.uid;
      if (uid == null)
        throw ("Utente non loggato!");
      else {
        await Provider.of<UserModel>(context, listen: false).updateFromServer(uid: uid);
        return true;
      }
    } catch (e) {
      debugPrint("L'utente non è loggato.");
      return false;
    }
  }
}
