/*
 * Created by Emilio Dalla Torre on 17/08/21, 14:30.
 * Copyright (c) 2021. All rights reserved.
 * Last modified 17/08/21, 14:30.
 */

import 'package:json_annotation/json_annotation.dart';

part 'report_model.g.dart';

@JsonSerializable()
class ReportModel {
  final String id;
  final ReportType type;
  final String content;
  final String reporterUid;

  ReportModel({
    required this.id,
    required this.type,
    required this.content,
    required this.reporterUid,
  });

  factory ReportModel.fromJson(Map<String, dynamic> parsedJson) => _$ReportModelFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$ReportModelToJson(this);
}

enum ReportType { BOOK, USER }
