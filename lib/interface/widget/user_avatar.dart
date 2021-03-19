import 'package:bookaround/models/user_model.dart';
import 'package:bookaround/references.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final UserModel? user;

  const UserAvatar({Key? key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Theme.of(context).canvasColor,
      child: Container(
        child: Text(
          References.fox,
          style: TextStyle(fontSize: 36.0),
        ),
      ),
    );
  }
}
