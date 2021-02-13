import 'package:json_annotation/json_annotation.dart';

part 'isbn_model.g.dart';

@JsonSerializable()
class IsbnModel {
  final String id;
  final String isbn;
  String title;
  List<String> authors;
  String image;
  final String authorUid;

  String get authorString {
    if (this.authors == null || (this.authors?.isEmpty ?? false))
      return "";
    else
      return this.authors.reduce((value, element) => "$value, $element") ?? "";
  }

  IsbnModel({
    this.id,
    this.isbn,
    this.title,
    this.authors,
    this.image,
    this.authorUid,
  });

  @override
  String toString() => "Isbn $isbn.";

  factory IsbnModel.fromJson(Map<String, dynamic> parsedJson) => _$IsbnModelFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$IsbnModelToJson(this);
}
