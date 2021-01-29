import 'package:bookaround/bloc/book_bloc.dart';
import 'package:bookaround/generated/l10n.dart';
import 'package:bookaround/interface/widget/book_list_element.dart';
import 'package:bookaround/models/book_model.dart';
import 'package:bookaround/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BooksPage extends StatelessWidget {
  final BooksBloc _booksBloc = BooksBloc();
  final BookType type;

  BooksPage({Key key, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<BookModel>>(
      stream: _booksBloc.books,
      builder: (BuildContext context, AsyncSnapshot<List<BookModel>> booksSnapshot) {
        if (booksSnapshot.hasData) {
          if (booksSnapshot.data.isNotEmpty)
            return ListView.builder(
              itemCount: booksSnapshot.data.length,
              itemBuilder: (BuildContext context, int index) => BookListElement(book: booksSnapshot.data.elementAt(index)),
            );

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(S.current.noBooks, style: Theme.of(context).textTheme.bodyText1),
            ),
          );
        }

        _booksBloc.getUserBooks(Provider.of<UserModel>(context).uid, this.type);
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
