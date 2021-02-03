import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class References {
  static const String appName = "Bookaround";
  static const String fox = "🦊";

  static CollectionReference usersCollection = FirebaseFirestore.instance.collection("users");
  static CollectionReference booksCollection = FirebaseFirestore.instance.collection("books");
}