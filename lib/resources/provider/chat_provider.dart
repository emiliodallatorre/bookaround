import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:bookaround/models/messaging/message_model.dart';
import 'package:bookaround/models/messaging/chat_model.dart';
import 'package:bookaround/models/user_model.dart';
import 'package:bookaround/references.dart';
import 'package:bookaround/resources/provider/user_provider.dart';

class ChatProvider {
  static Future<ChatModel> getChat(List<String> participantUids, String currentUserUid) async {
    final FirebaseFunctions functions = FirebaseFunctions.instance;
    final HttpsCallableResult result = await functions.httpsCallable("getChatId").call({"uid": currentUserUid, "participants": participantUids});
    final String chatId = result.data as String;

    return await getChatById(chatId, currentUserUid);
  }

  static Future<ChatModel> getChatById(String chatId, String currentUserUid) async {
    final DocumentSnapshot rawChat = await References.chatsCollection.doc(chatId).get();
    final ChatModel chat = ChatModel.fromJson(rawChat.data());

    chat.reference = rawChat.reference;
    chat.participants.removeWhere((String participantUid) => participantUid == currentUserUid);
    chat.participantsUsers = <UserModel>[];
    for (String uid in chat.participants) chat.participantsUsers.add(await UserProvider.getUserByUid(uid));

    return chat;
  }

  static Future<List<MessageModel>> getChatMessages(ChatModel chat) async {
    final List<DocumentSnapshot> rawMessages = (await chat.messagesReference.get()).docs;
    final List<MessageModel> messages = rawMessages.map((DocumentSnapshot rawMessage) => MessageModel.fromJson(rawMessage.data())..reference = rawMessage.reference).toList();

    messages.sort((b, a) => a.sentDateTime.compareTo(b.sentDateTime));

    return messages;
  }

  static Future<List<ChatModel>> getUserChats(UserModel user) async {
    final List<DocumentSnapshot> rawChats = (await References.chatsCollection.where("participants", arrayContains: user.uid).get()).docs;
    final List<ChatModel> chats = <ChatModel>[];

    for (int index = 0; index < rawChats.length; index++) {
      ChatModel chat = ChatModel.fromJson(rawChats.elementAt(index).data());

      // Ignoriamo le chat vuote di cui abbiamo solo un id.
      if (chat.lastMessage == null) continue;

      chat.reference = rawChats.elementAt(index).reference;
      chat.participants.removeWhere((String participantUid) => participantUid == user.uid);
      chat.participantsUsers = <UserModel>[];
      for (String uid in chat.participants) chat.participantsUsers.add(await UserProvider.getUserByUid(uid));

      chats.add(chat);
    }

    chats.sort((b, a) => a.lastMessageDateTime.compareTo(b.lastMessageDateTime));

    return chats;
  }
}