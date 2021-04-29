import 'package:bookaround/models/messaging/message_model.dart';

class SerializationHelper {
  static Map<String, dynamic>? messageToJson(MessageModel? message) => message?.toJson();
}
