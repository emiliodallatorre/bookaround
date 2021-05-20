/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:07
 * Copyright (c) 2021. All rights reserved.
 * Last modified 19/03/21, 19:09
 */

import 'package:bookaround/models/isbn_model.dart';
import 'package:bookaround/references.dart';

class IsbnHelper {
  static Future<void> createIsbn(IsbnModel isbn) => References.isbnsCollection.doc(isbn.id).set(isbn.toJson());

  static Future<void> deleteIsbn(IsbnModel isbn) => References.isbnsCollection.doc(isbn.id).delete();

  static Future<void> updateIsbn(IsbnModel isbn) => References.isbnsCollection.doc(isbn.id).update(isbn.toJson());
}
