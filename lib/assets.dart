/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:07
 * Copyright (c) 2021. All rights reserved.
 * Last modified 12/05/21, 17:49
 */

import 'package:flutter/widgets.dart';

class Fonts {
  static const String poppins = "Poppins";
}

class Images {
  /// ![](file:///Users/emiliodallatorre/Documents/GitHub/bookaround/assets/ic_launcher.png)
  static AssetImage get icLauncher => const AssetImage("assets/ic_launcher.png");
  /// ![](file:///Users/emiliodallatorre/Documents/GitHub/bookaround/assets/ic_launcher_android.png)
  static AssetImage get icLauncherAndroid => const AssetImage("assets/ic_launcher_android.png");
  /// ![](file:///Users/emiliodallatorre/Documents/GitHub/bookaround/assets/ic_launcher_white.png)
  static AssetImage get icLauncherWhite => const AssetImage("assets/ic_launcher_white.png");
  /// ![](file:///Users/emiliodallatorre/Documents/GitHub/bookaround/assets/icons/panda.png)
  static AssetImage get panda => const AssetImage("assets/icons/panda.png");
  /// ![](file:///Users/emiliodallatorre/Documents/GitHub/bookaround/assets/logo.png)
  static AssetImage get logo => const AssetImage("assets/logo.png");
}

