// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceModel _$PlaceModelFromJson(Map<String, dynamic> json) => PlaceModel(
      id: json['id'] as String?,
      description: json['description'] as String?,
      placeId: json['placeId'] as String?,
      placeReference: json['placeReference'] as String?,
    );

Map<String, dynamic> _$PlaceModelToJson(PlaceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'placeId': instance.placeId,
      'placeReference': instance.placeReference,
    };
