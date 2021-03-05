import 'package:bookaround/models/messaging/chat_model.dart';
import 'package:bookaround/models/messaging/message_model.dart';
import 'package:bookaround/resources/helper/chat_helper.dart';
import 'package:bookaround/resources/repository.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class MessagesBloc {
  final ChatModel chat;

  MessagesBloc(this.chat);

  final PublishSubject<List<MessageModel>> _messagesFetcher = PublishSubject<List<MessageModel>>();

  Stream<List<MessageModel>> get messages => _messagesFetcher.stream;

  Future<List<MessageModel>> getChatMessages() async {
    List<MessageModel> results = await Repository.getChatMessages(chat);

    _messagesFetcher.sink.add(results);
    debugPrint("Inviate al sink tutti i messaggi.");

    return results;
  }

  void listenForMessages() async {
    ChatHelper.listenForMessages(this.chat).listen((event) => getChatMessages());
  }

  void dispose() {
    _messagesFetcher.close();
  }
}
