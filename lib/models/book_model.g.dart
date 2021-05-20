/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:13.
 * Copyright (c) 2021. All rights reserved.
 * Last modified 20/05/21, 10:07.
 */

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookModel _$BookModelFromJson(Map<String, dynamic> json) {
  return BookModel(
    id: json['id'] as String?,
    isbn: json['isbn'] as String?,
    isbn13: json['isbn13'] as String?,
    title: json['title'] as String?,
    authors: (json['authors'] as List<dynamic>?)?.map((e) => e as String).toList(),
    coverUrl: json['coverUrl'] as String?,
    type: _$enumDecodeNullable(_$BookTypeEnumMap, json['type']),
    userUid: json['userUid'] as String,
    addedDateTime: json['addedDateTime'] == null ? null : DateTime.parse(json['addedDateTime'] as String),
    highlighting: json['highlighting'] as bool?,
    pencil: json['pencil'] as bool?,
    pen: json['pen'] as bool?,
    note: json['note'] as String?,
    location: json['location'] == null ? null : PlaceModel.fromJson(json['location'] as Map<String, dynamic>),
  )..locationData = json['locationData'] as Map<String, dynamic>?;
}

Map<String, dynamic> _$BookModelToJson(BookModel instance) => <String, dynamic>{
      'id': instance.id,
      'isbn': instance.isbn,
      'isbn13': instance.isbn13,
      'title': instance.title,
      'authors': instance.authors,
      'coverUrl': instance.coverUrl,
      'type': _$BookTypeEnumMap[instance.type],
      'userUid': instance.userUid,
      'addedDateTime': instance.addedDateTime?.toIso8601String(),
      'highlighting': instance.highlighting,
      'pencil': instance.pencil,
      'pen': instance.pen,
      'note': instance.note,
      'location': LocationHelper.locationToJson(instance.location),
      'locationData': instance.locationData,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$BookTypeEnumMap = {
  BookType.LOOKING: 'LOOKING',
  BookType.SELLING: 'SELLING',
};
