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
    author: (json['author'] as List)?.map((e) => e as String)?.toList(),
    coverUrl: json['coverUrl'] as String,
    type: _$enumDecodeNullable(_$BookTypeEnumMap, json['type']),
    userUid: json['userUid'] as String,
    addedDateTime: json['addedDateTime'] == null
        ? null
        : DateTime.parse(json['addedDateTime'] as String),
  );
}

Map<String, dynamic> _$BookModelToJson(BookModel instance) => <String, dynamic>{
      'id': instance.id,
      'isbn': instance.isbn,
      'title': instance.title,
      'author': instance.author,
      'coverUrl': instance.coverUrl,
      'type': _$BookTypeEnumMap[instance.type],
      'userUid': instance.userUid,
      'addedDateTime': instance.addedDateTime?.toIso8601String(),
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

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

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
