import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

class DynamicLinkHelper {
  static Future<void> followLink(BuildContext context, PendingDynamicLinkData? dynamicLink) async {
    if (dynamicLink != null) {
      final String action = dynamicLink.link.toString().replaceAll("https://bookaround.app/", "");
      final List<String> scheme = action.split("/");

      switch (scheme.first) {
        case "a":
          break;
        case "b":
          break;
        default:
          return;
      }
    }
  }
}
