import 'package:flutter/material.dart';

class AuthorHelper {
  static List<String> parseAuthors(String rawAuthors) {
    List<String> authors = rawAuthors.split(",");
    authors = authors.map((e) => e.trim()).toList();

    debugPrint("Ho trasformato \"$rawAuthors\" in ${authors.toString()}.");
    return authors;
  }
}
