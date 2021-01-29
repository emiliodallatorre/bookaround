import 'package:bookaround/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const String route = "/homeScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Text(Provider.of<UserModel>(context).uid);
  }
}
