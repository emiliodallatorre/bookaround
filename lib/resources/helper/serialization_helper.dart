/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:13.
 * Copyright (c) 2021. All rights reserved.
 * Last modified 20/05/21, 10:07.
 */

import 'package:bookaround/models/messaging/message_model.dart';

class SerializationHelper {
  static Map<String, dynamic>? messageToJson(MessageModel? message) => message?.toJson();
}
