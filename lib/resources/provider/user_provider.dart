import 'package:bookaround/models/user_model.dart';
import 'package:bookaround/references.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProvider {
  /// Recupera un utente in base al suo [uid].
  static Future<UserModel> getUserByUid(final String uid) async {
    DocumentSnapshot rawUser = await References.usersCollection.doc(uid).get();
    UserModel user = _deserializeUser(rawUser);

    return user;
  }

  static UserModel _deserializeUser(DocumentSnapshot rawUser) {
    UserModel user = UserModel.fromJson(rawUser.data()!);
    user.hasGoneThroughShowcase ??= false;
    user.reference = rawUser.reference;

    return user;
  }
}
