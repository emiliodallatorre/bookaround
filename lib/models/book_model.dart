/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:13.
 * Copyright (c) 2021. All rights reserved.
 * Last modified 20/05/21, 10:07.
 */

import 'package:bookaround/models/place_model.dart';
import 'package:bookaround/models/user_model.dart';
import 'package:bookaround/references.dart';
import 'package:bookaround/resources/helper/location_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book_model.g.dart';

@JsonSerializable()
class BookModel extends ChangeNotifier {
  final String? id;
  final String? isbn, isbn13;
  final String? title;
  final List<String>? authors;
  final String? coverUrl;
  final BookType? type;
  final String userUid;
  final DateTime? addedDateTime;

  bool? highlighting, pencil, pen;
  String? note;

  @JsonKey(toJson: LocationHelper.locationToJson)
  PlaceModel? location;

  @JsonKey(toJson: LocationHelper.geoFirePointToJson, fromJson: LocationHelper.geoFirePointFromJson)
  GeoFirePoint? locationData;

  LatLng? get modelizedLocation {
    if (this.locationData == null) return null;

    return LatLng(this.locationData!.latitude, this.locationData!.longitude);
  }

  @JsonKey(ignore: true)
  UserModel? user;

  @JsonKey(ignore: true)
  List<BookModel> results = <BookModel>[];

  @JsonKey(ignore: true)
  double? distanceInKms;

  DocumentReference get reference => References.booksCollection.doc(id);

  String get authorString {
    if (this.authors!.isEmpty)
      return "";
    else if (this.authors!.length == 1)
      return this.authors!.single;
    else
      return this.authors!.reduce((value, element) => "$value, $element");
  }

  String get secureIsbn => this.isbn13 ?? this.isbn ?? "";

  BookModel({
    this.id,
    this.isbn,
    this.isbn13,
    this.title,
    this.authors,
    this.coverUrl,
    this.type,
    required this.userUid,
    this.addedDateTime,
    this.highlighting,
    this.pencil,
    this.pen,
    this.note,
    this.distanceInKms,
    this.location,
    this.user,
  });

  @override
  String toString() => "Libro $id, isbn: $isbn13, \"$title\".";

  factory BookModel.fromJson(Map<String, dynamic> parsedJson) => _$BookModelFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$BookModelToJson(this);
}

enum BookType { LOOKING, SELLING }
