import 'dart:io';

import 'package:bookaround/models/user_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationsHelper {
  static Future<void> initializeNotifications(UserModel currentUser) async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

    if (Platform.isIOS) await firebaseMessaging.requestPermission();
    await firebaseMessaging.subscribeToTopic(currentUser.uid!);

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      debugPrint(event.toString());
    });

    debugPrint("Inizializzate con successo le notifiche di Firebase.");
  }

  static Future<void> deinitializeNotifications() async => await FirebaseMessaging.instance.deleteToken();
}
