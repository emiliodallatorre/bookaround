import 'dart:convert';

import 'package:bookaround/models/book_model.dart';
import 'package:bookaround/references.dart';
import 'package:bookaround/resources/errors/book_not_found_error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

class BookHelper {
  static Future<BookModel> createBookSell(String isbn, String currentUserUid) async {
    final FirebaseFunctions functions = FirebaseFunctions.instance;
    final HttpsCallableResult result = await functions.httpsCallable("createBookSell").call({"uid": currentUserUid, "isbn": isbn});

    if (result.data == null) throw BookNotFoundError();

    final BookModel response = BookModel.fromJson(jsonDecode(result.data));
    response.reference = References.booksCollection.doc(response.id);

    debugPrint("Ho caricato nel database il libro $isbn per conto di $currentUserUid.");
    return response;
  }

  static Future<void> updateBook(BookModel book) async {
    await book.reference!.update(book.toJson());
    debugPrint("Aggiornato il libro ${book.id}.");
  }

  /// Crea un documento di ricerca di un certo libro.
  static Future<BookModel> createBookSearch(BookModel book) async {
    final DocumentReference bookReference = References.booksCollection.doc(book.id);
    await bookReference.set(book.toJson());

    book.reference = bookReference;

    debugPrint("Aggiunto alle ricerche ${book.sureIsbn}.");
    return book;
  }

  /// Elimina un libro in vendita, se l'utente ha i permessi per farlo.
  static Future<void> removeBookFromSell(String id) async => await References.booksCollection.doc(id).delete();

  /// Elimina una ricerca di libro, se l'utente ha i permessi per farlo.
  static Future<void> removeBookFromSearch(String id) async => await References.booksCollection.doc(id).delete();
}
