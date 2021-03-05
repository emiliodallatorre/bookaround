import 'package:bookaround/generated/l10n.dart';
import 'package:bookaround/interface/widget/book_cover.dart';
import 'package:bookaround/models/book_model.dart';
import 'package:flutter/material.dart';

class BookScreen extends StatelessWidget {
  static const String route = "/bookScreen";

  BookModel book;

  @override
  Widget build(BuildContext context) {
    if (book == null) book = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      children: [
        BookCover(book: book, horizontalPadding: false),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(S.current.pencil)),
                      Checkbox(value: book.pencil, onChanged: null),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: Text(S.current.pen)),
                      Checkbox(value: book.pen, onChanged: null),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: Text(S.current.highlight)),
                      Checkbox(value: book.highlighting, onChanged: null),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        if (book.note.isNotEmpty) Text(S.current.note, style: Theme.of(context).textTheme.caption),
        if (book.note.isNotEmpty) Text(book.note),
      ],
    );
  }
}