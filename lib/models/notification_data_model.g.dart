// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationDataModel _$NotificationDataModelFromJson(
        Map<String, dynamic> json) =>
    NotificationDataModel(
      type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
      notificationData: json['notificationData'] as String,
    );

Map<String, dynamic> _$NotificationDataModelToJson(
        NotificationDataModel instance) =>
    <String, dynamic>{
      'type': _$NotificationTypeEnumMap[instance.type]!,
      'notificationData': instance.notificationData,
    };

const _$NotificationTypeEnumMap = {
  NotificationType.CHAT: 'CHAT',
};
