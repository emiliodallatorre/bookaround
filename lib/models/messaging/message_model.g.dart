// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      id: json['id'] as String?,
      senderUid: json['senderUid'] as String?,
      body: json['body'] as String,
      sentDateTime: json['sentDateTime'] == null
          ? null
          : DateTime.parse(json['sentDateTime'] as String),
      messageType:
          $enumDecodeNullable(_$MessageTypeEnumMap, json['messageType']),
      videoThumbUrl: json['videoThumbUrl'] as String?,
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'senderUid': instance.senderUid,
      'body': instance.body,
      'sentDateTime': instance.sentDateTime?.toIso8601String(),
      'messageType': _$MessageTypeEnumMap[instance.messageType],
      'videoThumbUrl': instance.videoThumbUrl,
    };

const _$MessageTypeEnumMap = {
  MessageType.TEXT: 'TEXT',
  MessageType.IMAGE: 'IMAGE',
  MessageType.VIDEO: 'VIDEO',
};
