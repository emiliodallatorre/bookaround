import 'package:bookaround/bloc/chat_bloc.dart';
import 'package:bookaround/generated/l10n.dart';
import 'package:bookaround/interface/widget/centered_text.dart';
import 'package:bookaround/models/messaging/chat_model.dart';
import 'package:bookaround/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ChatBloc chatsBloc = ChatBloc(Provider.of<UserModel>(context, listen: false))..getUserChats();

    return StreamBuilder<List<ChatModel>>(
      stream: chatsBloc.chats,
      builder: (BuildContext context, AsyncSnapshot<List<ChatModel>> chatsSnapshot) {
        if (chatsSnapshot.hasData) {
          if (chatsSnapshot.data.isNotEmpty)
            return ListView.builder(
              itemCount: chatsSnapshot.data.length,
              itemBuilder: (BuildContext context, int index) => ListTile(
                title: Text(chatsSnapshot.data.elementAt(index).recipient.displayName),
                subtitle: Text(chatsSnapshot.data.elementAt(index).lastMessage.displayableBody),
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
