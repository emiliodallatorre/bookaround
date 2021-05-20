/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:07
 * Copyright (c) 2021. All rights reserved.
 * Last modified 07/05/21, 18:07
 */

import 'package:bookaround/bloc/chat_bloc.dart';
import 'package:bookaround/generated/l10n.dart';
import 'package:bookaround/interface/screen/chat_screen.dart';
import 'package:bookaround/interface/widget/centered_text.dart';
import 'package:bookaround/models/messaging/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ChatModel>>(
      stream: Provider.of<ChatBloc>(context, listen: false).chats,
      builder: (BuildContext context, AsyncSnapshot<List<ChatModel>> chatsSnapshot) {
        if (chatsSnapshot.hasData) {
          if (chatsSnapshot.data!.isNotEmpty)
            return ListView.builder(
              itemCount: chatsSnapshot.data!.length,
              itemBuilder: (BuildContext context, int index) => ListTile(
                title: Text(chatsSnapshot.data!.elementAt(index).recipient.displayName),
                subtitle: Text(chatsSnapshot.data!.elementAt(index).lastMessage!.displayableBody, maxLines: 2, overflow: TextOverflow.ellipsis),
                trailing: chatsSnapshot.data!.elementAt(index).hasUnreadMessages ? Icon(Icons.circle_notifications, color: Theme.of(context).accentColor) : null,
                onTap: () {
                  Provider.of<ChatBloc>(context, listen: false).chatsListener!.pause();
                  debugPrint("Ho messo in pausa lo stream delle chat.");
                  Navigator.of(context).pushNamed(ChatScreen.route, arguments: chatsSnapshot.data!.elementAt(index)).whenComplete(() {
                    Provider.of<ChatBloc>(context, listen: false).chatsListener!.resume();
                    debugPrint("Ho riavviato lo stream delle chat.");
                  });
                },
              ),
            );
          else
            return CenteredText(label: S.current.noChats);
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
