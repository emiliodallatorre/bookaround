/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:07
 * Copyright (c) 2021. All rights reserved.
 * Last modified 12/05/21, 17:52
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class References {
  static const String appName = "Bookaround";

  static CollectionReference usersCollection = FirebaseFirestore.instance.collection("users");
  static CollectionReference chatsCollection = FirebaseFirestore.instance.collection("chats");
  static CollectionReference booksCollection = FirebaseFirestore.instance.collection("books");
  static CollectionReference isbnsCollection = FirebaseFirestore.instance.collection("isbns");

  static Reference bookCovers = FirebaseStorage.instance.ref("bookCovers/");
  static Reference userAvatars = FirebaseStorage.instance.ref("userAvatars/");

  static const String googleApiKey = "AIzaSyDTMDGyTZOPkaesYHW4vYfVMhUHafc8nl0";

  static const String noCover = "https://firebasestorage.googleapis.com/v0/b/bookaround-firebase.appspot.com/o/noCover.jpg?alt=media&token=2dc45426-45cf-4333-93a1-dd3e9ed415b2";

  static const String privacyPolicyUrl = "https://bookaround.app/privacy.html";
  static const String termsAndConditionsUrl = "https://bookaround.app/terms.html";

  static const String sharableAppLink = "https://bookaround.app/inapp/get";
  static const String copyrightString = "\u{a9} 2021 Emilio Dalla Torre";
}
