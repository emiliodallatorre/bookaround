/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:07
 * Copyright (c) 2021. All rights reserved.
 * Last modified 18/04/21, 20:03
 */

import 'package:bookaround/bloc/book_bloc.dart';
import 'package:bookaround/generated/l10n.dart';
import 'package:bookaround/interface/widget/book_list_element.dart';
import 'package:bookaround/interface/widget/centered_text.dart';
import 'package:bookaround/keys.dart';
import 'package:bookaround/models/book_model.dart';
import 'package:bookaround/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

class BookSellPage extends StatefulWidget {
  final BookType? type;

  BookSellPage({Key? key, this.type}) : super(key: key);

  @override
  _BookSellPageState createState() => _BookSellPageState();
}

class _BookSellPageState extends State<BookSellPage> {
  @override
  void initState() {
    if (!Provider.of<UserModel>(context, listen: false).hasGoneThroughShowcase!)
      WidgetsBinding.instance!.addPostFrameCallback((_) => ShowCaseWidget.of(context)?.startShowCase([
            Keys.floatingActionButtonKey,
            Keys.chatKey,
            Keys.searchBottomKey,
            Keys.searchTopKey,
          ]));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => await sellBooksBloc.getUserBooks(Provider.of<UserModel>(context, listen: false).uid!),
      child: StreamBuilder<List<BookModel>>(
        stream: sellBooksBloc.books,
        builder: (BuildContext context, AsyncSnapshot<List<BookModel>> booksSnapshot) {
          if (booksSnapshot.hasData) {
            if (booksSnapshot.data!.isNotEmpty)
              return ListView.builder(
                itemCount: booksSnapshot.data!.length,
                itemBuilder: (BuildContext context, int index) => BookListElement.sell(book: booksSnapshot.data!.elementAt(index)),
              );
            else
              return CenteredText(label: S.current.noBooks);
          }

          sellBooksBloc.getUserBooks(Provider.of<UserModel>(context, listen: false).uid!);
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
