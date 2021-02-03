import 'package:bookaround/models/book_model.dart';
import 'package:flutter/material.dart';

class BookListElement extends StatelessWidget {
  final BookModel book;

  const BookListElement({Key key, @required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(book.title),
      subtitle: Text(book.authorString),
    );
  }
}
