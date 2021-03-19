import 'package:bookaround/models/messaging/message_model.dart';
import 'package:bookaround/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Message extends StatelessWidget {
  final MessageModel? message;

  Message({Key? key, @required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          if (iAmTheSender(context)) Spacer(),
          Expanded(
            flex: 3,
            child: Container(
              color: Theme.of(context).backgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(this.message!.body!),
              ),
            ),
          ),
          if (!iAmTheSender(context)) Spacer(),
        ],
      ),
    );
  }

  bool iAmTheSender(BuildContext context) => this.message!.senderUid == Provider.of<UserModel>(context, listen: false).uid!;
}
