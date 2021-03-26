import 'package:bookaround/models/book_model.dart';
import 'package:bookaround/models/messaging/chat_model.dart';
import 'package:bookaround/models/messaging/message_model.dart';
import 'package:bookaround/models/user_model.dart';
import 'package:bookaround/resources/provider/book_provider.dart';
import 'package:bookaround/resources/provider/chat_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Repository {
  /// Funzioni da BookProvider.
  static Future<List<BookModel>> getUserBooks(String uid) async => await BookProvider.getUserBooks(uid);

  static Future<List<BookModel>> getNearbyBooks(List<String>? wanted, LatLng rawLastKnownLocation) async => await BookProvider.getNearbyBooks(wanted, rawLastKnownLocation);

  static Future<List<BookModel>> getWantedBooks(List<String> wanted, LatLng? currentPosition) async => await BookProvider.getWantedBooks(wanted, currentPosition);

  /// Funzioni da ChatProvider.
  static Future<ChatModel> getChat(String recipientUid, String currentUserUid) async => await ChatProvider.getChat(recipientUid, currentUserUid);

  static Future<List<MessageModel>> getChatMessages(ChatModel chat) async => await ChatProvider.getChatMessages(chat);

  static Future<List<ChatModel>> getUserChats(UserModel user) async => await ChatProvider.getUserChats(user);
}
