// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isbn_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IsbnModel _$IsbnModelFromJson(Map<String, dynamic> json) {
  return IsbnModel(
    id: json['id'] as String,
    isbn: json['isbn'] as String,
    title: json['title'] as String,
    authors: (json['authors'] as List)?.map((e) => e as String)?.toList(),
    coverUrl: json['coverUrl'] as String,
    authorUid: json['authorUid'] as String,
  );
}

Map<String, dynamic> _$IsbnModelToJson(IsbnModel instance) => <String, dynamic>{
      'id': instance.id,
      'isbn': instance.isbn,
      'title': instance.title,
      'authors': instance.authors,
      'coverUrl': instance.coverUrl,
      'authorUid': instance.authorUid,
    };