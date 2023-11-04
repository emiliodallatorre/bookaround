/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:13.
 * Copyright (c) 2021. All rights reserved.
 * Last modified 20/05/21, 10:07.
 */

import 'package:bookaround/bloc/book_bloc.dart';
import 'package:bookaround/generated/l10n.dart';
import 'package:bookaround/interface/screen/book_screen.dart';
import 'package:bookaround/interface/widget/confirm_search_removal_bottom_sheet.dart';
import 'package:bookaround/models/book_model.dart';
import 'package:bookaround/models/user_model.dart';
import 'package:bookaround/references.dart';
import 'package:bookaround/resources/helper/book_helper.dart';
import 'package:bookaround/resources/provider/location_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookListElement extends StatelessWidget {
  final BookModel book;
  final Color? color;
  final bool showPosition;
  final List<BookModel>? results;

  final BookListElementType widgetType;

  const BookListElement.sell({
    Key? key,
    required this.book,
  })  : this.widgetType = BookListElementType.SELL,
        this.color = null,
        this.showPosition = false,
        this.results = null,
        super(key: key);

  const BookListElement.wanted({
    Key? key,
    required this.book,
    required this.color,
    required this.results,
  })  : this.widgetType = BookListElementType.WANTED,
        this.showPosition = false,
        super(key: key);

  const BookListElement.result({
    Key? key,
    required this.book,
    this.showPosition = false,
  })  : this.widgetType = BookListElementType.RESULT_WANTED,
        this.color = null,
        this.results = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (this.widgetType) {
      case BookListElementType.SELL:
        return buildClassicWidget(context);
      case BookListElementType.WANTED:
        // debugPrint(results.toString());
        return buildExpandableWidget(context);
      case BookListElementType.RESULT_WANTED:
        return buildResultWidget(context);
    }
  }

  Widget buildClassicWidget(BuildContext context) {
    return ListTile(
      title: Text(this.book.title!),
      subtitle: Text(this.book.authorString),
      leading: AspectRatio(
        aspectRatio: 1.0,
        child: CachedNetworkImage(
          imageUrl: this.book.coverUrl!,
          // Ignora i potenziali errori di immagine.
          errorWidget: (BuildContext context, String stackTrace, dynamic error) => CachedNetworkImage(imageUrl: References.noCover),
          placeholder: (BuildContext context, String imageUrl) => Center(child: CircularProgressIndicator()),
        ),
      ),
      trailing: Builder(
        builder: (BuildContext context) {
          switch (this.widgetType) {
            case BookListElementType.SELL:
              break;
            case BookListElementType.WANTED:
              return Icon(Icons.circle, color: this.color);
            case BookListElementType.RESULT_WANTED:
              if (this.showPosition)
                return Text(Provider.of<LocationProvider>(context).getDistance(this.book.modelizedLocation!).toStringAsFixed(1) + S.current.km);
              break;
          }

          return SizedBox.shrink();
        },
      ),
      onTap: this.book.type == BookType.LOOKING ? null : () => Navigator.of(context).pushNamed(BookScreen.route, arguments: this.book),
    );
  }

  Widget buildExpandableWidget(BuildContext context) {
    return GestureDetector(
      onLongPress: () async {
        bool wantsToRemove = (await showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) => ConfirmSearchRemovalBottomSheet(book: this.book),
            )) ??
            false;

        if (wantsToRemove) {
          await BookHelper.removeBookFromSearch(this.book.id!);
          await searchBookBloc.getUserBooks(Provider.of<UserModel>(context, listen: false).uid!, Provider.of<UserModel>(context, listen: false).blockedUids!,
              Provider.of<LocationProvider>(context, listen: false).lastKnownLocation);
        }
      },
      child: ExpansionTile(
        title: Text(this.book.title!),
        subtitle: Text(this.book.authorString),
        leading: AspectRatio(
          aspectRatio: 1.0,
          child: CachedNetworkImage(
            imageUrl: this.book.coverUrl!,
            // Ignora i potenziali errori di immagine.
            errorWidget: (BuildContext context, String stackTrace, dynamic error) => CachedNetworkImage(imageUrl: References.noCover),
            placeholder: (BuildContext context, String imageUrl) => Center(child: CircularProgressIndicator()),
          ),
        ),
        children: <Widget>[
          if (this.results!.isEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(S.current.noResults),
            ),
          ...List.generate(
            this.results!.length,
            (int index) => BookListElement.result(book: this.results!.elementAt(index)),
          ),
        ],
      ),
    );
  }

  Widget buildResultWidget(BuildContext context) {
    return ListTile(
      title: Text(this.book.location!.description!),
      subtitle: Text(this.book.user!.displayName),
      trailing: Text(this.book.distanceInKms != null ? this.book.distanceInKms!.toStringAsFixed(1) + S.current.km : ""),
      onTap: () => Navigator.of(context).pushNamed(BookScreen.route, arguments: this.book),
    );
  }
}

enum BookListElementType { SELL, WANTED, RESULT_WANTED }
