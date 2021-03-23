import 'package:bookaround/models/book_model.dart';
import 'package:bookaround/references.dart';
import 'package:bookaround/resources/provider/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BookProvider {
  static Future<List<BookModel>> getUserBooks(String uid) async {
    List<DocumentSnapshot> rawBooks = (await References.booksCollection.where("userUid", isEqualTo: uid).get()).docs;
    List<BookModel> books = <BookModel>[];

    rawBooks.forEach((DocumentSnapshot rawBook) {
      BookModel book = BookModel.fromJson(rawBook.data()!);
      book.reference = rawBook.reference;

      books.add(book);
    });

    return books;
  }

  static Future<List<BookModel>> getWantedBooks(List<String> wanted) async {
    final List<BookModel> wantedBooks = <BookModel>[];
    final List<DocumentSnapshot> rawBooks = <DocumentSnapshot>[];

    while (wanted.isNotEmpty) {
      rawBooks.addAll((await References.booksCollection.where("isbn", whereIn: wanted.take(10).toList()).get()).docs);
      rawBooks.addAll((await References.booksCollection.where("isbn13", whereIn: wanted.take(10).toList()).get()).docs);
      List<String> tmp = <String>[]..addAll(wanted.take(10));
      tmp.forEach((String isbn) => wanted.remove(isbn));
    }

    for (int index = 0; index < rawBooks.length; index++) {
      final BookModel book = BookModel.fromJson(rawBooks.elementAt(index).data()!);

      if (book.type != BookType.SELLING) continue;

      book.reference = rawBooks.elementAt(index).reference;
      book.user = await UserProvider.getUserByUid(book.userUid);

      wantedBooks.add(book);
    }

    return wantedBooks;
  }

  static Future<List<BookModel>> getNearbyBooks(List<String>? wanted, LatLng rawLastKnownLocation) async {
    final Geoflutterfire geoflutterfire = Geoflutterfire();
    final GeoFirePoint lastKnownLocation = GeoFirePoint(rawLastKnownLocation.latitude, rawLastKnownLocation.longitude);

    Stream<List<DocumentSnapshot>> stream = geoflutterfire.collection(collectionRef: References.booksCollection).within(
          center: lastKnownLocation,
          radius: 10,
          field: "locationData",
        );

    List<DocumentSnapshot> rawNearbyBooks = await stream.first;

    /*stream.listen((List<DocumentSnapshot> rawNearbyBooks) async {
    });*/

    final List<BookModel> foundBooks = <BookModel>[];
    for (int index = 0; index < rawNearbyBooks.length; index++) {
      BookModel bookModel = BookModel.fromJson(rawNearbyBooks.elementAt(index).data()!);
      bookModel.reference = rawNearbyBooks.elementAt(index).reference;
      bookModel.user = await UserProvider.getUserByUid(bookModel.userUid);

      foundBooks.add(bookModel);
    }

    if (wanted != null) foundBooks.removeWhere((element) => !wanted.contains(element.isbn) && !wanted.contains(element.isbn13));

    return foundBooks;
  }
}
