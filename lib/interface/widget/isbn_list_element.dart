import 'package:bookaround/models/isbn_model.dart';
import 'package:flutter/material.dart';

class IsbnListElement extends StatelessWidget {
  final IsbnModel isbn;

  const IsbnListElement({Key key, @required this.isbn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(this.isbn.title),
    );
  }
}
