// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isbn_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IsbnModel _$IsbnModelFromJson(Map<String, dynamic> json) {
  return IsbnModel(
    id: json['id'] as String,
    isbn: json['isbn'] as String,
    isbn13: json['isbn13'] as String,
    title: json['title'] as String,
    authors: (json['authors'] as List)?.map((e) => e as String)?.toList(),
    image: json['image'] as String,
    authorUid: json['authorUid'] as String,
  );
}

Map<String, dynamic> _$IsbnModelToJson(IsbnModel instance) => <String, dynamic>{
      'id': instance.id,
      'isbn': instance.isbn,
      'isbn13': instance.isbn13,
      'title': instance.title,
      'authors': instance.authors,
      'image': instance.image,
      'authorUid': instance.authorUid,
    };
