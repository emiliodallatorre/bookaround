import 'dart:convert';

import 'package:bookaround/models/book_model.dart';
import 'package:bookaround/references.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

class BookHelper {
  static Future<BookModel> createBookSell(String isbn, String currentUserUid) async {
    final FirebaseFunctions functions = FirebaseFunctions.instance;
    final HttpsCallableResult result = await functions.httpsCallable("createBookSell").call({"uid": currentUserUid, "isbn": isbn});
    final BookModel response = BookModel.fromJson(jsonDecode(result.data));
    response.reference = References.booksCollection.doc(response.id);

    debugPrint("Ho caricato nel database il libro $isbn per conto di $currentUserUid.");
    return response;
  }

  static Future<void> updateBook(BookModel book) async {
    await book.reference.update(book.toJson());
    debugPrint("Aggiornato il libro ${book.id}.");
  }
}
