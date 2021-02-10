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
}
