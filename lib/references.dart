import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class References {
  static const String appName = "Bookaround";
  static const String fox = "🦊";

  static CollectionReference usersCollection = FirebaseFirestore.instance.collection("users");
  static CollectionReference chatsCollection = FirebaseFirestore.instance.collection("chats");
  static CollectionReference booksCollection = FirebaseFirestore.instance.collection("books");
  static CollectionReference isbnsCollection = FirebaseFirestore.instance.collection("isbns");

  static Reference bookCovers = FirebaseStorage.instance.ref("bookCovers/");

  static const String googleApiKey = "AIzaSyDTMDGyTZOPkaesYHW4vYfVMhUHafc8nl0";

  static const String noCover = "https://firebasestorage.googleapis.com/v0/b/bookaround-firebase.appspot.com/o/noCover.jpg?alt=media&token=2dc45426-45cf-4333-93a1-dd3e9ed415b2";
}
