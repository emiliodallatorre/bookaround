// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) {
  return MessageModel(
    id: json['id'] as String,
    senderUid: json['senderUid'] as String,
    body: json['body'] as String,
    sentDateTime: json['sentDateTime'] == null
        ? null
        : DateTime.parse(json['sentDateTime'] as String),
    receivedDateTime: json['receivedDateTime'] == null
        ? null
        : DateTime.parse(json['receivedDateTime'] as String),
    messageType:
        _$enumDecodeNullable(_$MessageTypeEnumMap, json['messageType']),
    videoThumbUrl: json['videoThumbUrl'] as String,
  );
}

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'senderUid': instance.senderUid,
      'body': instance.body,
      'sentDateTime': instance.sentDateTime?.toIso8601String(),
      'receivedDateTime': instance.receivedDateTime?.toIso8601String(),
      'messageType': _$MessageTypeEnumMap[instance.messageType],
      'videoThumbUrl': instance.videoThumbUrl,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$MessageTypeEnumMap = {
  MessageType.TEXT: 'TEXT',
  MessageType.IMAGE: 'IMAGE',
  MessageType.VIDEO: 'VIDEO',
};
