import 'package:bookaround/models/messaging/chat_model.dart';
import 'package:bookaround/models/user_model.dart';
import 'package:bookaround/resources/helper/chat_helper.dart';
import 'package:bookaround/resources/repository.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ChatsBloc {
  final UserModel currentUser;

  ChatsBloc(this.currentUser);

  final _chatsFetcher = PublishSubject<List<ChatModel>>();

  Stream<List<ChatModel>> get chats => _chatsFetcher.stream;

  Future<List<ChatModel>> getUserChats() async {
    List<ChatModel> results = await Repository.getUserChats(this.currentUser);

    _chatsFetcher.sink.add(results);
    debugPrint("Inviate al sink tutte le chat.");

    return results;
  }

  void listenForChats() async {
    ChatHelper.listenForChats(this.currentUser).listen((event) {
      debugPrint("C\'è stato un aggiornamento nelle chat dell'utente...");
      getUserChats();
    });
  }

  void dispose() {
    _chatsFetcher.close();
  }
}
