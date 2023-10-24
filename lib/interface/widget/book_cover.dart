/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:13.
 * Copyright (c) 2021. All rights reserved.
 * Last modified 20/05/21, 10:07.
 */

import 'package:bookaround/generated/l10n.dart';
import 'package:bookaround/models/book_model.dart';
import 'package:bookaround/references.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BookCover extends StatelessWidget {
  final BookModel? book;
  final bool horizontalPadding;

  const BookCover({Key? key, @required this.book, this.horizontalPadding = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding ? 16.0 : 0.0, vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: CachedNetworkImage(
                    imageUrl: this.book!.coverUrl!,
                    // Ignora i potenziali errori di immagine.
                    errorWidget: (BuildContext context, String stackTrace, dynamic error) => CachedNetworkImage(imageUrl: References.noCover),
                    placeholder: (BuildContext context, String imageUrl) => Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),
              VerticalDivider(),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(this.book!.title!, style: Theme.of(context).textTheme.titleLarge),
                    Text(this.book!.authorString, style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(),
        Padding(
          padding: this.horizontalPadding ? EdgeInsets.symmetric(horizontal: 16.0) : EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(S.current.isbn + ": " + this.book!.secureIsbn),
              if (this.book!.location != null) Text(S.current.position + ": " + this.book!.location!.description!),
            ],
          ),
        ),
        this.horizontalPadding ? Divider(indent: 16.0, endIndent: 16.0) : Divider(),
      ],
    );
  }
}
