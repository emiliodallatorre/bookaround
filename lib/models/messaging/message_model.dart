/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:13.
 * Copyright (c) 2021. All rights reserved.
 * Last modified 20/05/21, 10:07.
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

@JsonSerializable()
class MessageModel {
  String? id;
  String? senderUid;
  String body;
  DateTime? sentDateTime;
  MessageType? messageType;
  String? videoThumbUrl;

  @JsonKey(ignore: true)
  DocumentReference? reference;

  // TODO: Modificare nel caso dei media allegati.
  String get displayableBody => body;

  MessageModel({
    this.id,
    this.senderUid,
    required this.body,
    this.sentDateTime,
    this.messageType,
    this.videoThumbUrl,
  });

  @override
  String toString() => "Messaggio: ${this.body}, da: ${this.senderUid}.";

  factory MessageModel.fromJson(Map<String, dynamic> parsedJson) => _$MessageModelFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}

enum MessageType { TEXT, IMAGE, VIDEO }
