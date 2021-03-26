import 'dart:io';

import 'package:bookaround/references.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileHelper {
  static Future<String> uploadProfilePicture(String userUid, File profilePicture) async {
    Reference userProfilePictureReference = References.userAvatars.child(userUid);
    await userProfilePictureReference.putFile(profilePicture);
    return await userProfilePictureReference.getDownloadURL();
  }
  
  static Future<void> deleteProfilePicture(String userUid) async {
    Reference userProfilePictureReference = References.userAvatars.child(userUid);
    await userProfilePictureReference.delete();
  }
}