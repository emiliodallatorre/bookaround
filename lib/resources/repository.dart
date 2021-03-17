import 'package:bookaround/models/book_model.dart';
import 'package:bookaround/models/messaging/chat_model.dart';
import 'package:bookaround/models/messaging/message_model.dart';
import 'package:bookaround/models/user_model.dart';
import 'package:bookaround/resources/provider/book_provider.dart';
import 'package:bookaround/resources/provider/chat_provider.dart';

class Repository {
  /// Funzioni da BookProvider.
  static Future<List<BookModel>> getUserBooks(String uid) async => await BookProvider.getUserBooks(uid);

  /// Funzioni da ChatProvider.
  static Future<ChatModel> getChat(String recipientUid, String currentUserUid) async => await ChatProvider.getChat(recipientUid, currentUserUid);

  static Future<List<MessageModel>> getChatMessages(ChatModel chat) async => await ChatProvider.getChatMessages(chat);

  static Future<List<ChatModel>> getUserChats(UserModel user) async => await ChatProvider.getUserChats(user);
}
