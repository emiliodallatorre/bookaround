/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:13.
 * Copyright (c) 2021. All rights reserved.
 * Last modified 20/05/21, 10:07.
 */

import 'package:bookaround/references.dart';
import 'package:json_annotation/json_annotation.dart';

part 'isbn_model.g.dart';

@JsonSerializable()
class IsbnModel {
  final String? id;
  final String? isbn, isbn13;
  String? title;
  List<String>? authors;
  @Deprecated("Usare sureImage.")
  String? image;
  final String? authorUid;

  String get authorString {
    if (this.authors == null)
      return "";
    else if (this.authors!.isEmpty)
      return "";
    else
      return this.authors!.reduce((value, element) => "$value, $element");
  }

  String get sureIsbn => this.isbn13 ?? this.isbn ?? "";

  String get sureImage => this.image ?? References.noCover;

  IsbnModel({
    this.id,
    this.isbn,
    this.isbn13,
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
