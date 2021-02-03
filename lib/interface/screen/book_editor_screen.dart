import 'package:bookaround/bloc/book_bloc.dart';
import 'package:bookaround/generated/l10n.dart';
import 'package:bookaround/models/book_model.dart';
import 'package:bookaround/models/user_model.dart';
import 'package:bookaround/resources/helper/book_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookEditorScreen extends StatefulWidget {
  static const String route = "/bookEditorScreen";

  @override
  _BookEditorScreenState createState() => _BookEditorScreenState();
}

class _BookEditorScreenState extends State<BookEditorScreen> {
  BookModel book;

  @override
  Widget build(BuildContext context) {
    if (book == null) book = ModalRoute.of(context).settings.arguments;

    return WillPopScope(
      onWillPop: () async {
        await BookHelper.updateBook(book);
        await sellBooksBloc.getUserBooks(Provider.of<UserModel>(context, listen: false).uid, BookType.SELLING);

        return true;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: _buildBody(context),
        persistentFooterButtons: [
          ElevatedButton(
            child: Text(S.current.save),
            onPressed: Navigator.of(context).pop,
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              Expanded(child: Image.network(book.coverUrl)),
              VerticalDivider(),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Text(book.title, style: Theme.of(context).textTheme.headline6),
                    Text(book.authorString, style: Theme.of(context).textTheme.caption),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(indent: 16.0, endIndent: 16.0),
        CheckboxListTile(
          value: book.pencil,
          onChanged: (bool value) => setState(() => book.pencil = value),
          title: Text(S.current.pencil),
        ),
        CheckboxListTile(
          value: book.highlighting,
          onChanged: (bool value) => setState(() => book.highlighting = value),
          title: Text(S.current.highlight),
        ),
        CheckboxListTile(
          value: book.pen,
          onChanged: (bool value) => setState(() => book.pen = value),
          title: Text(S.current.pen),
        ),
      ],
    );
  }
}
