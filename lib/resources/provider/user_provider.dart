/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:13.
 * Copyright (c) 2021. All rights reserved.
 * Last modified 20/05/21, 10:07.
 */

import 'package:bookaround/models/user_model.dart';
import 'package:bookaround/references.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserProvider {
  /// Recupera un utente in base al suo [uid].
  static Future<UserModel> getUserByUid(final String uid) async {
    DocumentSnapshot<Map<String, dynamic>> rawUser = await References.usersCollection.doc(uid).get();
    UserModel user = _deserializeUser(rawUser);

    return user;
  }

  /// Recupera diversi utenti, dati gli [uids].
  static Future<List<UserModel>> getMultipleUsers(final Set<String> uids) async {
    debugPrint("Recupero gli utenti $uids.");

    final List<UserModel> users = <UserModel>[];
    for (String uid in uids) users.add(await getUserByUid(uid));
    return users;
  }

  static UserModel _deserializeUser(DocumentSnapshot<Map<String, dynamic>> rawUser) {
    UserModel user = UserModel.fromJson(rawUser.data()!);
    user.hasGoneThroughShowcase ??= false;
    user.reference = rawUser.reference;

    return user;
  }
}
