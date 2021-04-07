import 'package:bookaround/references.dart';
import 'package:bookaround/resources/helper/notifications_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends ChangeNotifier {
  String? uid;
  String? phoneNumber;
  String? name, surname, city;
  String? profileImageUrl;

  @JsonKey(ignore: true)
  DocumentReference? reference;

  UserModel({
    this.uid,
    this.phoneNumber,
    this.name,
    this.surname,
    this.city,
    this.profileImageUrl,
    this.reference,
  });

  bool get isLogged => this.uid != null;

  String get displayName => this.name! + " " + this.surname!;

  @override
  String toString() => "Utente $uid.";

  factory UserModel.fromJson(Map<String, dynamic> parsedJson) => _$UserModelFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  Future<void> updateFromServer({@required uid, bool empty = false, bool initNotifications = false}) async {
    final DocumentReference updatedUserReference = References.usersCollection.doc(uid ?? this.uid);

    UserModel updatedUser;
    if (empty)
      updatedUser = UserModel();
    else if (uid != null)
      updatedUser = UserModel.fromJson((await updatedUserReference.get()).data()!);
    else
      updatedUser = UserModel();

    this.uid = updatedUser.uid;
    this.phoneNumber = updatedUser.phoneNumber;
    this.name = updatedUser.name;
    this.surname = updatedUser.surname;
    this.city = updatedUser.city;
    this.profileImageUrl = updatedUser.profileImageUrl;

    this.reference = updatedUserReference;

    notifyListeners();
  }

  Future<void> updateOnServer() => this.reference!.update(this.toJson()).whenComplete(notifyListeners);

  void signOut() => updateFromServer(uid: null);
}
