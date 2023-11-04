// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportModel _$ReportModelFromJson(Map<String, dynamic> json) => ReportModel(
      id: json['id'] as String,
      type: $enumDecode(_$ReportTypeEnumMap, json['type']),
      content: json['content'] as String,
      reporterUid: json['reporterUid'] as String,
    );

Map<String, dynamic> _$ReportModelToJson(ReportModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$ReportTypeEnumMap[instance.type]!,
      'content': instance.content,
      'reporterUid': instance.reporterUid,
    };

const _$ReportTypeEnumMap = {
  ReportType.BOOK: 'BOOK',
  ReportType.USER: 'USER',
};
