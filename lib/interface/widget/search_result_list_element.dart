import 'package:bookaround/generated/l10n.dart';
import 'package:bookaround/models/isbn_model.dart';
import 'package:bookaround/references.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SearchResultListElement extends StatelessWidget {
  final IsbnModel isbn;

  const SearchResultListElement({Key key, @required this.isbn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(this.isbn.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (this.isbn.authorString.isNotEmpty) Text(this.isbn.authorString),
          Text(S.current.isbn + ": " + this.isbn.isbn),
        ],
      ),
      leading: AspectRatio(
        aspectRatio: 1.0,
        child: CachedNetworkImage(
          imageUrl: this.isbn.image,
          // Ignora i potenziali errori di immagine.
          errorWidget: (BuildContext context, String stackTrace, dynamic error) => CachedNetworkImage(imageUrl: References.noCover),
          placeholder: (BuildContext context, String imageUrl) => Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
