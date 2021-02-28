import 'package:bookaround/models/book_model.dart';
import 'package:bookaround/resources/repository.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class BooksBloc {
  final _booksFetcher = PublishSubject<List<BookModel>>();

  Stream<List<BookModel>> get books => _booksFetcher.stream;

  Future<List<BookModel>> getUserBooks(String userUid, [BookType type]) async {
    List<BookModel> books = await Repository.getUserBooks(userUid);

    if (type != null) books.removeWhere((element) => element.type != type);

    _booksFetcher.sink.add(books);
    debugPrint("Inviate al sink tutte le ricerche.");

    return books;
  }

  void dispose() {
    _booksFetcher.close();
  }
}

final BooksBloc searchBookBloc = BooksBloc();
final BooksBloc sellBooksBloc = BooksBloc();
