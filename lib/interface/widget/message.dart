/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:13.
 * Copyright (c) 2021. All rights reserved.
 * Last modified 20/05/21, 10:07.
 */

import 'package:bookaround/models/messaging/message_model.dart';
import 'package:bookaround/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart';

class Message extends StatelessWidget {
  final MessageModel message;

  Message({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          if (iAmTheSender(context)) Spacer(),
          Expanded(
            flex: 3,
            child: Container(
              color: Theme.of(context).colorScheme.background.withOpacity(iAmTheSender(context) ? 1.0 : 0.5),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(this.message.body!),
                    SizedBox(height: 4.0),
                    Align(alignment: AlignmentDirectional.bottomEnd, child: Text(format(this.message.sentDateTime!), style: Theme.of(context).textTheme.bodySmall)),
                  ],
                ),
              ),
            ),
          ),
          if (!iAmTheSender(context)) Spacer(),
        ],
      ),
    );
  }

  bool iAmTheSender(BuildContext context) => this.message.senderUid == Provider.of<UserModel>(context, listen: false).uid!;
}
