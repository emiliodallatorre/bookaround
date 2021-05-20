/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:07
 * Copyright (c) 2021. All rights reserved.
 * Last modified 26/03/21, 12:40
 */

import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageHelper {
  static Future<File?> pickImage([ImageSource source = ImageSource.gallery]) async {
    PickedFile? pickedImage = await ImagePicker().getImage(source: source);

    if (pickedImage != null) return File(pickedImage.path);
  }
}
