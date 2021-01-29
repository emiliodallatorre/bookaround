import 'package:bookaround/references.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends ChangeNotifier {
  String uid;
  String phoneNumber;
  String name, surname;

  @JsonKey(ignore: true)
  DocumentReference reference;

  UserModel({
    this.uid,
    this.phoneNumber,
    this.name,
    this.surname,
  });

  @override
  String toString() => "Utente $uid.";

  factory UserModel.fromJson(Map<String, dynamic> parsedJson) => _$UserModelFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  Future<void> updateFromServer({@required uid, bool empty = false, bool initNotifications = false}) async {
    final DocumentReference updatedUserReference = References.usersCollection.doc(uid ?? this.uid);

    UserModel updatedUser;
    if (uid != null)
      updatedUser = UserModel.fromJson((await updatedUserReference.get()).data());
    else
      updatedUser = UserModel();

    this.uid = updatedUser.uid;
    this.phoneNumber = updatedUser.phoneNumber;
    this.name = updatedUser.name;
    this.surname = updatedUser.surname;

    this.reference = updatedUserReference;

    // TODO: Implementare.
    // if(initNotifications) await NotificationsHelper.initializeNotifications(this);

    notifyListeners();
  }

  Future<void> updateOnServer() => this.reference.update(this.toJson()).whenComplete(notifyListeners);

  void signOut() => updateFromServer(uid: null);
}
