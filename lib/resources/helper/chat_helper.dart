import 'package:bookaround/models/messaging/chat_model.dart';
import 'package:bookaround/models/messaging/message_model.dart';
import 'package:bookaround/models/user_model.dart';
import 'package:bookaround/references.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class ChatHelper {
  static Future<void> sendMessage(ChatModel chat, MessageModel message, String currentUserUid) async {
    message.id = randomAlphaNumeric(20);
    message.senderUid = currentUserUid;
    message.sentDateTime = DateTime.now();

    await chat.messagesReference.doc(message.id).set(message.toJson());

    debugPrint("Ho inviato il messaggio ${message.id}.");
  }

  static Stream<QuerySnapshot> listenForMessages(ChatModel chat) {
    return chat.messagesReference.snapshots();
  }

  static Stream<QuerySnapshot> listenForChats(UserModel user) {
    return References.chatsCollection.where("participants", arrayContains: user.uid).snapshots();
  }
}
