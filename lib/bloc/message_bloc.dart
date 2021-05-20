/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:13.
 * Copyright (c) 2021. All rights reserved.
 * Last modified 20/05/21, 10:07.
 */

import 'dart:async';

import 'package:bookaround/models/messaging/chat_model.dart';
import 'package:bookaround/models/messaging/message_model.dart';
import 'package:bookaround/resources/helper/chat_helper.dart';
import 'package:bookaround/resources/repository.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:rxdart/rxdart.dart';

class MessagesBloc {
  final ChatModel chat;
  final String currentUserUid;

  MessagesBloc(this.chat, this.currentUserUid);

  final PublishSubject<List<MessageModel>> _messagesFetcher = PublishSubject<List<MessageModel>>();

  Stream<List<MessageModel>> get messages => _messagesFetcher.stream;

  Future<List<MessageModel>> getChatMessages() async {
    final List<MessageModel> results = await Repository.getChatMessages(chat);

    _messagesFetcher.sink.add(results);
    debugPrint("Inviati al sink tutti i messaggi.");
    await ChatHelper.setRead(chat, this.currentUserUid);

    return results;
  }

  StreamSubscription? chatListener;
  String? subscriptionId;

  void listenForMessages() async {
    if (chatListener != null) return;

    subscriptionId = randomAlpha(4);
    chatListener = ChatHelper.listenForMessages(this.chat).listen((event) {
      debugPrint("Invio i nuovi messaggi dello stream $subscriptionId.");
      getChatMessages();
    });
  }

  void dispose() {
    debugPrint("Dispongo i messaggi dello stream $subscriptionId.");
    chatListener?.cancel();
    _messagesFetcher.close();
  }
}
