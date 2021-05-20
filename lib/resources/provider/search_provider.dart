/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:07
 * Copyright (c) 2021. All rights reserved.
 * Last modified 19/03/21, 19:09
 */

import 'dart:convert';

import 'package:bookaround/models/isbn_model.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

class SearchProvider {
  static Future<List<IsbnModel>> searchBook(String query, String currentUserUid) async {
    final FirebaseFunctions functions = FirebaseFunctions.instance;
    final HttpsCallableResult result = await functions.httpsCallable("findBook").call({"uid": currentUserUid, "query": query});

    List<IsbnModel> results = (jsonDecode(result.data).map((e) => IsbnModel.fromJson(e)).toList() as List<dynamic>).cast<IsbnModel>();

    debugPrint("Ho caricato nel database la query \"$query\" per conto di $currentUserUid.");
    return results;
  }
}
