// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookModel _$BookModelFromJson(Map<String, dynamic> json) {
  return BookModel(
    id: json['id'] as String,
    isbn: json['isbn'] as String,
    title: json['title'] as String,
    authors: (json['authors'] as List)?.map((e) => e as String)?.toList(),
    coverUrl: json['coverUrl'] as String,
    type: _$enumDecodeNullable(_$BookTypeEnumMap, json['type']),
    userUid: json['userUid'] as String,
    addedDateTime: json['addedDateTime'] == null ? null : DateTime.parse(json['addedDateTime'] as String),
    highlighting: json['highlighting'] as bool,
    pencil: json['pencil'] as bool,
    pen: json['pen'] as bool,
    note: json['note'] as String,
    location: json['location'] == null ? null : LocationModel.fromJson(json['location'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BookModelToJson(BookModel instance) => <String, dynamic>{
      'id': instance.id,
      'isbn': instance.isbn,
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
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries.singleWhere((e) => e.value == source, orElse: () => null)?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$BookTypeEnumMap = {
  BookType.LOOKING: 'LOOKING',
  BookType.SELLING: 'SELLING',
};
