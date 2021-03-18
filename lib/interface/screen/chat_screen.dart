import 'package:bookaround/models/messaging/chat_model.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  static const String route = "/chatScreen";

  ChatModel chat;

  @override
  Widget build(BuildContext context) {
    if (chat == null) chat = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("aaa"),
      ),
    );
  }
}
