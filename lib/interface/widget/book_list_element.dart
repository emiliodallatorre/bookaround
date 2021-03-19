import 'package:bookaround/interface/screen/book_screen.dart';
import 'package:bookaround/models/book_model.dart';
import 'package:bookaround/references.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BookListElement extends StatelessWidget {
  final BookModel? book;
  final Color? color;

  const BookListElement({Key? key, @required this.book, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(this.book!.title!),
      subtitle: Text(this.book!.authorString),
      leading: AspectRatio(
        aspectRatio: 1.0,
        child: CachedNetworkImage(
          imageUrl: this.book!.coverUrl!,
          // Ignora i potenziali errori di immagine.
          errorWidget: (BuildContext context, String stackTrace, dynamic error) => CachedNetworkImage(imageUrl: References.noCover),
          placeholder: (BuildContext context, String imageUrl) => Center(child: CircularProgressIndicator()),
        ),
      ),
      trailing: color == null ? null : Icon(Icons.circle, color: this.color),
      onTap: this.book!.type == BookType.LOOKING ? null : () => Navigator.of(context).pushNamed(BookScreen.route, arguments: this.book),
    );
  }
}
