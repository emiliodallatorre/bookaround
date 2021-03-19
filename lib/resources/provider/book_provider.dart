import 'package:bookaround/models/book_model.dart';
import 'package:bookaround/references.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
}
