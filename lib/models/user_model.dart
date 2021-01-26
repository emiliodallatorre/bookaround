import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  String uid;
  String email;
  String phoneNumber;
  String displayName;

  UserModel({
    this.uid,
    this.email,
    this.phoneNumber,
    this.displayName,
  });

  @override
  String toString() => "Utente $uid.";
}
