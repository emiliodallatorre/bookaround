import 'package:flutter/widgets.dart';

class Fonts {
  static const String poppins = "Poppins";
}

class Assets {
  /// ![](file:///Users/emiliodallatorre/Documents/GitHub/bookaround/assets/logo.svg)
  static const String logo = "assets/logo.svg";
}

class Images {
  /// ![](file:///Users/emiliodallatorre/Documents/GitHub/bookaround/assets/ic_launcher.png)
  static AssetImage get icLauncher => const AssetImage("assets/ic_launcher.png");
  /// ![](file:///Users/emiliodallatorre/Documents/GitHub/bookaround/assets/ic_launcher_android.png)
  static AssetImage get icLauncherAndroid => const AssetImage("assets/ic_launcher_android.png");
  /// ![](file:///Users/emiliodallatorre/Documents/GitHub/bookaround/assets/ic_launcher_white.png)
  static AssetImage get icLauncherWhite => const AssetImage("assets/ic_launcher_white.png");
  /// ![](file:///Users/emiliodallatorre/Documents/GitHub/bookaround/assets/ic_play_store.png)
  static AssetImage get icPlayStore => const AssetImage("assets/ic_play_store.png");
  /// ![](file:///Users/emiliodallatorre/Documents/GitHub/bookaround/assets/icons/panda.png)
  static AssetImage get panda => const AssetImage("assets/icons/panda.png");
}

