import 'package:json_annotation/json_annotation.dart';

part 'notification_data_model.g.dart';

@JsonSerializable()
class NotificationDataModel {
  final NotificationType type;
  final String notificationData;

  NotificationDataModel({
    required this.type,
    required this.notificationData,
  });

  factory NotificationDataModel.fromJson(Map<String, dynamic> parsedJson) => _$NotificationDataModelFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$NotificationDataModelToJson(this);
}

enum NotificationType { CHAT }
