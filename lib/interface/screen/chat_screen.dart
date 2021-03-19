import 'package:bookaround/models/messaging/chat_model.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  static const String route = "/chatScreen";

  ChatModel? _chat;

  @override
  Widget build(BuildContext context) {
    if (_chat == null) _chat = ModalRoute.of(context)!.settings.arguments as ChatModel;

    return Scaffold(
      appBar: AppBar(
        title: Text("aaa"),
      ),
    );
  }
}
