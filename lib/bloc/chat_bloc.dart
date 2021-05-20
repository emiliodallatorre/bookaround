/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:07
 * Copyright (c) 2021. All rights reserved.
 * Last modified 07/04/21, 19:17
 */

import 'dart:async';

import 'package:bookaround/models/messaging/chat_model.dart';
import 'package:bookaround/models/user_model.dart';
import 'package:bookaround/resources/helper/chat_helper.dart';
import 'package:bookaround/resources/repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:rxdart/rxdart.dart';

class ChatBloc extends ChangeNotifier {
  final UserModel currentUser;
  final Stream<QuerySnapshot> chatStream;

  ChatBloc(this.currentUser) : chatStream = ChatHelper.listenForChats(currentUser);

  final BehaviorSubject<List<ChatModel>> _chatsFetcher = BehaviorSubject<List<ChatModel>>();

  Stream<List<ChatModel>> get chats => _chatsFetcher.stream;

  Future<List<ChatModel>> getUserChats() async {
    List<ChatModel> results = await Repository.getUserChats(this.currentUser);

    _chatsFetcher.sink.add(results);
    debugPrint("Inviate al sink tutte le chat.");

    return results;
  }

  StreamSubscription? chatsListener;
  String? subscriptionId;

  void listenForChats() async {
    if (chatsListener != null) return;

    subscriptionId = randomString(4);
    chatsListener = chatStream.listen((event) async {
      debugPrint("Siamo nello stream $subscriptionId.");
      getUserChats();
      notifyListeners();
    });
  }

  bool get hasUnreadChats {
    if (_chatsFetcher.hasValue) return _chatsFetcher.value!.any((ChatModel chat) => chat.hasUnreadMessages);
    return false;
  }

  @override
  void dispose() {
    chatsListener?.cancel();
    _chatsFetcher.close();
    debugPrint("Ho disposto il ChatBloc().");

    super.dispose();
  }
}
