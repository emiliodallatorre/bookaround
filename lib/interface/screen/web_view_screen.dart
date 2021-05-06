import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  static const String route = "/webViewScreen";

  @override
  Widget build(BuildContext context) {
    final Tuple2<String, String> dataDefinition = ModalRoute.of(context)!.settings.arguments as Tuple2<String, String>;

    return Scaffold(
      appBar: AppBar(title: Text(dataDefinition.item1)),
      body: _buildBody(context, dataDefinition.item2),
    );
  }

  Widget _buildBody(BuildContext context, String url) {
    return WebView(
      initialUrl: url,
    );
  }
}
