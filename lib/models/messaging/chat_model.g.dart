// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) {
  return ChatModel(
    id: json['id'] as String,
    creationDateTime: json['creationDateTime'] == null
        ? null
        : DateTime.parse(json['creationDateTime'] as String),
    lastMessageDateTime: json['lastMessageDateTime'] == null
        ? null
        : DateTime.parse(json['lastMessageDateTime'] as String),
    participants:
        (json['participants'] as List)?.map((e) => e as String)?.toList(),
    lastMessage: json['lastMessage'] == null
        ? null
        : MessageModel.fromJson(json['lastMessage'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) => <String, dynamic>{
      'id': instance.id,
      'creationDateTime': instance.creationDateTime?.toIso8601String(),
      'lastMessageDateTime': instance.lastMessageDateTime?.toIso8601String(),
      'participants': instance.participants,
      'lastMessage': instance.lastMessage,
    };