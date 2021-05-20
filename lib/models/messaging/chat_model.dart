/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:13.
 * Copyright (c) 2021. All rights reserved.
 * Last modified 20/05/21, 10:07.
 */

import 'package:bookaround/models/messaging/message_model.dart';
import 'package:bookaround/models/user_model.dart';
import 'package:bookaround/resources/helper/serialization_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_model.g.dart';

@JsonSerializable()
class ChatModel {
  final String? id;
  final DateTime? creationDateTime, lastMessageDateTime;
  final Set<String>? participants;
  @JsonKey(toJson: SerializationHelper.messageToJson)
  final MessageModel? lastMessage;

  @JsonKey(ignore: true)
  DocumentReference? reference;

  @JsonKey(ignore: true)
  List<UserModel>? participantsUsers;

  @JsonKey(ignore: true)
  DateTime? lastAccess;

  CollectionReference get messagesReference => reference!.collection("messages");

  UserModel get recipient => participantsUsers!.single;

  bool get hasUnreadMessages {
    if (!participants!.contains(lastMessage!.senderUid)) return false;
    if (lastAccess != null && lastMessageDateTime != null) return lastAccess!.isBefore(lastMessageDateTime!);

    debugPrint("Segno la chat come non letta per insufficienza di dati.");
    return true;
  }

  ChatModel({
    this.id,
    this.creationDateTime,
    this.lastMessageDateTime,
    this.participants,
    this.lastMessage,
    this.lastAccess,
  });

  @override
  String toString() => "Chat fra ${participants.toString()}.";

  factory ChatModel.fromJson(Map<String, dynamic> parsedJson) => _$ChatModelFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);
}
