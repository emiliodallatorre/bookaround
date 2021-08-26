/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:13.
 * Copyright (c) 2021. All rights reserved.
 * Last modified 20/05/21, 10:07.
 */

import 'package:bookaround/models/book_model.dart';
import 'package:bookaround/resources/repository.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';

class BooksBloc {
  final BookType bookType;

  BooksBloc(this.bookType);

  final BehaviorSubject<List<BookModel>> _booksFetcher = BehaviorSubject<List<BookModel>>();

  // final PublishSubject<List<BookModel>> _wantedBooksFetcher = PublishSubject<List<BookModel>>();

  Stream<List<BookModel>> get books => _booksFetcher.stream;

  // Stream<List<BookModel>> get wantedBooks => _wantedBooksFetcher.stream;

  Future<List<BookModel>> getUserBooks(String userUid, Set<String> unwantedUids, [LatLng? currentPosition]) async {
    final List<BookModel> books = await Repository.getUserBooks(userUid);
    books.removeWhere((element) => element.type != bookType);

    _booksFetcher.sink.add(books);
    if (bookType == BookType.LOOKING) {
      final List<BookModel> wantedBooks = await getWantedBooks(userUid, currentPosition, unwantedUids);

      for (int index = 0; index < books.length; index++)
        books.elementAt(index).results.addAll(wantedBooks.where((element) =>
            (element.isbn == books.elementAt(index).isbn && element.isbn != null) ||
            (element.isbn13 == books.elementAt(index).isbn13) && element.isbn13 != null));
    }
    _booksFetcher.sink.add(books);
    debugPrint("Inviate al sink tutte le ricerche.");

    return books;
  }

  Future<List<BookModel>> getWantedBooks(String userUid, LatLng? currentPosition, Set<String> unwantedUids) async {
    assert(this.bookType == BookType.LOOKING);

    late List<String> wanted;
    if (_booksFetcher.value != null)
      wanted = _booksFetcher.value!.map((e) => e.secureIsbn).toList();
    else {
      final List<BookModel> books = await Repository.getUserWantedBooks(userUid);
      _booksFetcher.sink.add(books);
      wanted = books.map((BookModel wantedBook) => wantedBook.secureIsbn).toList();
    }

    final List<BookModel> wantedBooks = await Repository.getWantedBooks(wanted, currentPosition, unwantedUids);
    // TODO: Riattivare a tempo debito.
    // wantedBooks.removeWhere((BookModel book) => book.userUid == userUid);

    // _wantedBooksFetcher.sink.add(wantedBooks);
    return wantedBooks;
  }

  @Deprecated("Sostituito con [getWantedBooks].")
  Future<List<BookModel>> getNearbyBooks(LatLng rawLastKnownLocation, String userUid, Set<String> unwantedUids) async {
    assert(this.bookType == BookType.LOOKING);

    late List<String> wanted;
    if (_booksFetcher.value != null)
      wanted = _booksFetcher.value!.map((e) => e.secureIsbn).toList();
    else {
      await getUserBooks(userUid, unwantedUids);
      wanted = _booksFetcher.value!.map((e) => e.secureIsbn).toList();
    }

    final List<BookModel> nearbyBooks = await Repository.getNearbyBooks(wanted, rawLastKnownLocation, unwantedUids);

    // _wantedBooksFetcher.sink.add(nearbyBooks);
    return nearbyBooks;
  }

  void dispose() {
    _booksFetcher.close();
    // _wantedBooksFetcher.close();
  }
}

final BooksBloc searchBookBloc = BooksBloc(BookType.LOOKING);
final BooksBloc sellBooksBloc = BooksBloc(BookType.SELLING);
