import 'package:bookaround/models/location_model.dart';
import 'package:bookaround/resources/helper/location_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book_model.g.dart';

@JsonSerializable()
class BookModel extends ChangeNotifier {
  final String id;
  final String isbn;
  final String title;
  final List<String> authors;
  final String coverUrl;
  final BookType type;
  final String userUid;
  final DateTime addedDateTime;

  bool highlighting, pencil, pen;
  String note;

  @JsonKey(toJson: LocationHelper.locationToJson)
  LocationModel location;

  @JsonKey(ignore: true)
  DocumentReference reference;

  String get authorString => this.authors.reduce((value, element) => "$value, $element");

  BookModel({
    this.id,
    this.isbn,
    this.title,
    this.authors,
    this.coverUrl,
    this.type,
    this.userUid,
    this.addedDateTime,
    this.reference,
    this.highlighting,
    this.pencil,
    this.pen,
    this.note,
    this.location,
  });

  @override
  String toString() => "Libro $id.";

  factory BookModel.fromJson(Map<String, dynamic> parsedJson) => _$BookModelFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$BookModelToJson(this);
}

enum BookType { LOOKING, SELLING }
