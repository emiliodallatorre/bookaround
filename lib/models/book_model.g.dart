// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookModel _$BookModelFromJson(Map<String, dynamic> json) => BookModel(
      id: json['id'] as String?,
      isbn: json['isbn'] as String?,
      isbn13: json['isbn13'] as String?,
      title: json['title'] as String?,
      authors:
          (json['authors'] as List<dynamic>?)?.map((e) => e as String).toList(),
      coverUrl: json['coverUrl'] as String?,
      type: $enumDecodeNullable(_$BookTypeEnumMap, json['type']),
      userUid: json['userUid'] as String,
      addedDateTime: json['addedDateTime'] == null
          ? null
          : DateTime.parse(json['addedDateTime'] as String),
      highlighting: json['highlighting'] as bool?,
      pencil: json['pencil'] as bool?,
      pen: json['pen'] as bool?,
      note: json['note'] as String?,
      location: json['location'] == null
          ? null
          : PlaceModel.fromJson(json['location'] as Map<String, dynamic>),
    )..locationData = json['locationData'] as Map<String, dynamic>?;

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

const _$BookTypeEnumMap = {
  BookType.LOOKING: 'LOOKING',
  BookType.SELLING: 'SELLING',
};
