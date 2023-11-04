/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:13.
 * Copyright (c) 2021. All rights reserved.
 * Last modified 20/05/21, 10:07.
 */

import 'dart:io';

import 'package:bookaround/models/notification_data_model.dart';
import 'package:bookaround/models/user_model.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class NotificationsHelper {
  static Future<void> initializeNotifications(UserModel currentUser, BuildContext context) async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

    if (Platform.isIOS) await firebaseMessaging.requestPermission();
    await firebaseMessaging.subscribeToTopic(currentUser.uid!);

    FirebaseMessaging.onMessage.listen((RemoteMessage event) => onNotification(event, context));

    debugPrint("Inizializzate con successo le notifiche di Firebase.");
  }

  static Future<void> deinitializeNotifications() async => await FirebaseMessaging.instance.deleteToken();

  static Future<void> onNotification(RemoteMessage event, BuildContext context) async {
    try {
      final NotificationDataModel notificationData = NotificationDataModel.fromJson(event.data);

      switch (notificationData.type) {
        case NotificationType.CHAT:
          showSimpleNotification(
            Text(event.notification!.title!),
            subtitle: Text(event.notification!.body!),
          );
          break;
      }
    } catch (e, stack) {
      debugPrint("Errore nella gestione delle notifiche: $e");
      FirebaseCrashlytics.instance.recordError(e, stack);

      debugPrint("Notifica ricevuta: ${event.data}");
    }
  }
}
