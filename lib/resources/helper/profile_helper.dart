/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:13.
 * Copyright (c) 2021. All rights reserved.
 * Last modified 20/05/21, 10:07.
 */

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
