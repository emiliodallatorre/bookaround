import 'package:bookaround/models/book_model.dart';
import 'package:bookaround/resources/repository.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';

class BooksBloc {
  final BookType bookType;

  BooksBloc(this.bookType);

  final BehaviorSubject<List<BookModel>> _booksFetcher = BehaviorSubject<List<BookModel>>();
  final PublishSubject<List<BookModel>> _nearbyBooksFetcher = PublishSubject<List<BookModel>>();

  Stream<List<BookModel>> get books => _booksFetcher.stream;

  Stream<List<BookModel>> get nearbyBooks => _nearbyBooksFetcher.stream;

  Future<List<BookModel>> getUserBooks(String userUid) async {
    List<BookModel> books = await Repository.getUserBooks(userUid);

    books.removeWhere((element) => element.type != bookType);

    _booksFetcher.sink.add(books);
    debugPrint("Inviate al sink tutte le ricerche.");

    return books;
  }

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

    _nearbyBooksFetcher.sink.add(nearbyBooks);
    return nearbyBooks;
  }

  void dispose() {
    _booksFetcher.close();
    _nearbyBooksFetcher.close();
  }
}

final BooksBloc searchBookBloc = BooksBloc(BookType.LOOKING);
final BooksBloc sellBooksBloc = BooksBloc(BookType.SELLING);
