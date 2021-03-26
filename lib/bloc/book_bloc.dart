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

  Future<List<BookModel>> getUserBooks(String userUid, [LatLng? currentPosition]) async {
    final List<BookModel> books = await Repository.getUserBooks(userUid);
    books.removeWhere((element) => element.type != bookType);

    _booksFetcher.sink.add(books);
    if (bookType == BookType.LOOKING) {
      final List<BookModel> wantedBooks = await getWantedBooks(userUid, currentPosition);

      for (int index = 0; index < books.length; index++)
        books.elementAt(index).results.addAll(wantedBooks.where((element) => element.isbn == books.elementAt(index).isbn || element.isbn13 == books.elementAt(index).isbn13));
    }
    _booksFetcher.sink.add(books);
    debugPrint("Inviate al sink tutte le ricerche.");

    return books;
  }

  Future<List<BookModel>> getWantedBooks(String userUid, LatLng? currentPosition) async {
    assert(this.bookType == BookType.LOOKING);

    late List<String> wanted;
    if (_booksFetcher.value != null)
      wanted = _booksFetcher.value!.map((e) => e.sureIsbn).toList();
    else {
      await getUserBooks(userUid);
      wanted = _booksFetcher.value!.map((e) => e.sureIsbn).toList();
    }

    final List<BookModel> wantedBooks = await Repository.getWantedBooks(wanted, currentPosition);
    // TODO: Riattivare a tempo debito.
    // wantedBooks.removeWhere((BookModel book) => book.userUid == userUid);

    // _wantedBooksFetcher.sink.add(wantedBooks);
    return wantedBooks;
  }

  @Deprecated("Sostituito con [getWantedBooks].")
  Future<List<BookModel>> getNearbyBooks(LatLng rawLastKnownLocation, String userUid) async {
    assert(this.bookType == BookType.LOOKING);

    late List<String> wanted;
    if (_booksFetcher.value != null)
      wanted = _booksFetcher.value!.map((e) => e.sureIsbn).toList();
    else {
      await getUserBooks(userUid);
      wanted = _booksFetcher.value!.map((e) => e.sureIsbn).toList();
    }

    final List<BookModel> nearbyBooks = await Repository.getNearbyBooks(wanted, rawLastKnownLocation);

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
