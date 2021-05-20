/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:13.
 * Copyright (c) 2021. All rights reserved.
 * Last modified 20/05/21, 10:07.
 */

import 'package:bookaround/generated/l10n.dart';
import 'package:bookaround/interface/widget/book_cover.dart';
import 'package:bookaround/models/book_model.dart';
import 'package:flutter/material.dart';

class ConfirmSearchRemovalBottomSheet<bool> extends StatelessWidget {
  final BookModel book;

  const ConfirmSearchRemovalBottomSheet({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        shrinkWrap: true,
        children: [
          BookCover(book: book, horizontalPadding: false),
          Text(S.current.removeBookSearch, style: Theme.of(context).textTheme.headline6),
          Text(S.current.removeBookSearchExtended),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Spacer(),
              TextButton(child: Text(S.current.undo), onPressed: () => Navigator.of(context).pop(false)),
              ElevatedButton(child: Text(S.current.ok), onPressed: () => Navigator.of(context).pop(true)),
            ],
          ),
        ],
      ),
    );
  }
}
