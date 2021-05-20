/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:07
 * Copyright (c) 2021. All rights reserved.
 * Last modified 29/04/21, 22:13
 */

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceModel _$PlaceModelFromJson(Map<String, dynamic> json) {
  return PlaceModel(
    id: json['id'] as String?,
    description: json['description'] as String?,
    placeId: json['placeId'] as String?,
    placeReference: json['placeReference'] as String?,
  );
}

Map<String, dynamic> _$PlaceModelToJson(PlaceModel instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'placeId': instance.placeId,
      'placeReference': instance.placeReference,
    };
