import 'package:flutter/material.dart';

class AuthorHelper {
  static List<String> parseAuthors(String? rawAuthors) {
    if(rawAuthors == null) return <String>[];

    List<String> authors = rawAuthors.split(",");
    authors = authors.map((e) => e.trim()).toList();

    debugPrint("Ho trasformato \"$rawAuthors\" in ${authors.toString()}.");
    return authors;
  }
}
