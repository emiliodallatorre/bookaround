import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageHelper {
  static Future<File?> pickImage([ImageSource source = ImageSource.gallery]) async {
    PickedFile? pickedImage = await ImagePicker().getImage(source: source);

    if (pickedImage != null) return File(pickedImage.path);
  }
}
