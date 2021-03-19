import 'package:bookaround/models/messaging/message_model.dart';
import 'package:bookaround/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_model.g.dart';

@JsonSerializable()
class ChatModel {
  final String? id;
  final DateTime? creationDateTime, lastMessageDateTime;
  final List<String>? participants;
  final MessageModel? lastMessage;

  @JsonKey(ignore: true)
  DocumentReference? reference;

  @JsonKey(ignore: true)
  List<UserModel>? participantsUsers;

  CollectionReference get messagesReference => reference!.collection("messages");

  UserModel get recipient => participantsUsers!.single;

  ChatModel({
    this.id,
    this.creationDateTime,
    this.lastMessageDateTime,
    this.participants,
    this.lastMessage,
  });

  @override
  String toString() => "Chat fra ${participants.toString()}.";

  factory ChatModel.fromJson(Map<String, dynamic> parsedJson) => _$ChatModelFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);
}
