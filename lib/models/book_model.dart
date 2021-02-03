import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book_model.g.dart';

@JsonSerializable()
class BookModel {
  final String id;
  final String isbn;
  final String title;
  final List<String> author;
  final String coverUrl;
  final BookType type;
  final String userUid;
  final DateTime addedDateTime;

  @JsonKey(ignore: true)
  DocumentReference reference;

  BookModel({
    this.id,
    this.isbn,
    this.title,
    this.author,
    this.coverUrl,
    this.type,
    this.userUid,
    this.addedDateTime,
    this.reference,
  });

  @override
  String toString() => "Libro $id.";

  factory BookModel.fromJson(Map<String, dynamic> parsedJson) => _$BookModelFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$BookModelToJson(this);
}

enum BookType { LOOKING, SELLING }