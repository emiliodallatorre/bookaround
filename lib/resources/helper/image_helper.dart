/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:13.
 * Copyright (c) 2021. All rights reserved.
 * Last modified 20/05/21, 10:07.
 */

import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageHelper {
  static Future<File?> pickImage([ImageSource source = ImageSource.gallery]) async {
    XFile? pickedImage = await ImagePicker().pickImage(source: source);

    if (pickedImage != null) return File(pickedImage.path);
  }
}
