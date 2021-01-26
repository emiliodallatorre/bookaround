import 'package:firebase_core/firebase_core.dart';

class InitHelper {
  static Future<void> initialize() async {
    await Firebase.initializeApp();
  }
}
