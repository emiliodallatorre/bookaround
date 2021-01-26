import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String route = "/homeScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Text("CIAOO");
  }
}
