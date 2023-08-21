/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:13.
 * Copyright (c) 2021. All rights reserved.
 * Last modified 20/05/21, 10:07.
 */

import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  static const String route = "/webViewScreen";

  @override
  Widget build(BuildContext context) {
    final Tuple2<String, String> dataDefinition =
        ModalRoute.of(context)!.settings.arguments as Tuple2<String, String>;

    return Scaffold(
      appBar: AppBar(title: Text(dataDefinition.item1)),
      body: _buildBody(context, dataDefinition.item2),
    );
  }

  Widget _buildBody(BuildContext context, String url) {
    final WebViewController controller = WebViewController();
    controller.loadRequest(Uri.parse(url));

    controller.setJavaScriptMode(JavaScriptMode.unrestricted);

    return WebViewWidget(
      controller: controller,
    );
  }
}
