// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceModel _$LocationModelFromJson(Map<String, dynamic> json) {
  return PlaceModel(
    id: json['id'] as String,
    description: json['description'] as String,
    placeId: json['placeId'] as String,
    placeReference: json['placeReference'] as String,
  );
}

Map<String, dynamic> _$LocationModelToJson(PlaceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'placeId': instance.placeId,
      'placeReference': instance.placeReference,
    };
