/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:13.
 * Copyright (c) 2021. All rights reserved.
 * Last modified 20/05/21, 10:07.
 */

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
