// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationModel _$LocationModelFromJson(Map<String, dynamic> json) {
  return LocationModel(
    id: json['id'] as String,
    description: json['description'] as String,
    placeId: json['placeId'] as String,
    placeReference: json['placeReference'] as String,
  );
}

Map<String, dynamic> _$LocationModelToJson(LocationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'placeId': instance.placeId,
      'placeReference': instance.placeReference,
    };
