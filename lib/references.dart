import 'package:cloud_firestore/cloud_firestore.dart';

class References {
  static const String appName = "Bookaround";

  static CollectionReference usersCollection = FirebaseFirestore.instance.collection("users");
  static CollectionReference booksCollection = FirebaseFirestore.instance.collection("books");
}