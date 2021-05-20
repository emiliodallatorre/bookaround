/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:13.
 * Copyright (c) 2021. All rights reserved.
 * Last modified 20/05/21, 10:07.
 */

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class UploadHelper {
  static Future<String> uploadFile(Reference location, File file, String fileName) async {
    Reference fileReference = location.child(fileName);

    await fileReference.putFile(file);
    String downloadUrl = await fileReference.getDownloadURL();

    debugPrint("Caricato il file con nome \"$fileName\" sullo storage.");
    return downloadUrl;
  }

  static Future<void> deleteUpload(String referenceUrl) async {
    Reference reference = FirebaseStorage.instance.refFromURL(referenceUrl);
    await reference.delete();

    debugPrint("Eliminato il file nel link.");
  }
}
