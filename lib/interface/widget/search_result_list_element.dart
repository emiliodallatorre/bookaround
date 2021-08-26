/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:13.
 * Copyright (c) 2021. All rights reserved.
 * Last modified 20/05/21, 10:07.
 */

import 'package:bookaround/bloc/book_bloc.dart';
import 'package:bookaround/generated/l10n.dart';
import 'package:bookaround/models/book_model.dart';
import 'package:bookaround/models/isbn_model.dart';
import 'package:bookaround/models/user_model.dart';
import 'package:bookaround/references.dart';
import 'package:bookaround/resources/helper/book_helper.dart';
import 'package:bookaround/resources/provider/location_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';

class SearchResultListElement extends StatelessWidget {
  final IsbnModel? isbn;

  const SearchResultListElement({Key? key, @required this.isbn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(this.isbn!.title!),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (this.isbn!.authorString.isNotEmpty) Text(this.isbn!.authorString),
          Text(S.current.isbn + ": " + this.isbn!.sureIsbn),
        ],
      ),
      leading: AspectRatio(
        aspectRatio: 1.0,
        child: CachedNetworkImage(
          imageUrl: this.isbn!.sureImage,
          // Ignora i potenziali errori di immagine.
          errorWidget: (BuildContext context, String stackTrace, dynamic error) => CachedNetworkImage(imageUrl: References.noCover),
          placeholder: (BuildContext context, String imageUrl) => Center(child: CircularProgressIndicator()),
        ),
      ),
      trailing: IconButton(
        icon: Icon(Icons.add),
        onPressed: () async {
          BookModel searchingBook = BookModel(
            isbn: this.isbn!.isbn,
            isbn13: this.isbn!.isbn13,
            addedDateTime: DateTime.now(),
            authors: this.isbn!.authors,
            title: this.isbn!.title,
            coverUrl: this.isbn!.image,
            id: randomAlphaNumeric(20),
            userUid: Provider.of<UserModel>(context, listen: false).uid!,
            type: BookType.LOOKING,
          );

          BookHelper.createBookSearch(searchingBook);
          searchBookBloc.getUserBooks(Provider.of<UserModel>(context, listen: false).uid!, Provider.of<UserModel>(context, listen: false).blockedUids!, Provider.of<LocationProvider>(context, listen: false).lastKnownLocation);

          Navigator.of(context).pop();
        },
      ),
    );
  }
}
