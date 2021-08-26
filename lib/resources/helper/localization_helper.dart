/*
 * Created by Emilio Dalla Torre on 26/08/21, 19:14.
 * Copyright (c) 2021. All rights reserved.
 * Last modified 26/08/21, 19:14.
 */

import 'package:bookaround/generated/l10n.dart';
import 'package:bookaround/interface/screen/chat_screen.dart';
import 'package:flutter/cupertino.dart';

class LocalizationHelper {
  static String localizeChatAction(final BuildContext context, final ChatAction action) {
    late String value;

    switch (action) {
      case ChatAction.BLOCK_USER:
        value = S.of(context).blockUser;
        break;
    }

    return value;
  }
}
