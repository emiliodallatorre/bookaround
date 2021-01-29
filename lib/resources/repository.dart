import 'package:bookaround/models/book_model.dart';
import 'package:bookaround/resources/provider/book_provider.dart';

class Repository {
  /// Funzioni da BookProvider.
  static Future<List<BookModel>> getUserBooks(String uid) async =>await  BookProvider.getUserBooks(uid);
}