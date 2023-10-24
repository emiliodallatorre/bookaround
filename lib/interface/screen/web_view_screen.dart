/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:13.
 * Copyright (c) 2021. All rights reserved.
 * Last modified 20/05/21, 10:07.
 */

import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  static const String route = "/webViewScreen";

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final WebViewController controller = WebViewController();

  bool initialized = false;

  late String title, url;

  @override
  Widget build(BuildContext context) {
    if (!initialized) {
      final Tuple2<String, String> dataDefinition = ModalRoute.of(context)!.settings.arguments as Tuple2<String, String>;
      title = dataDefinition.item1;
      url = dataDefinition.item2;

      controller.loadRequest(Uri.parse(url));

      initialized = true;
    }

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: buildBody(url),
    );
  }

  Widget buildBody(String url) {
    return WebViewWidget(
      controller: controller,
    );
  }
}
