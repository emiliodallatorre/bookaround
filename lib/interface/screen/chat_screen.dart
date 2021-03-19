import 'package:bookaround/bloc/message_bloc.dart';
import 'package:bookaround/generated/l10n.dart';
import 'package:bookaround/interface/widget/centered_text.dart';
import 'package:bookaround/interface/widget/message.dart';
import 'package:bookaround/models/messaging/chat_model.dart';
import 'package:bookaround/models/messaging/message_model.dart';
import 'package:bookaround/models/user_model.dart';
import 'package:bookaround/resources/helper/chat_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';

class ChatScreen extends StatelessWidget {
  static const String route = "/chatScreen";

  final TextEditingController _messageController = TextEditingController();

  ChatModel? _chat;
  MessagesBloc? _messagesBloc;

  @override
  Widget build(BuildContext context) {
    if (_chat == null) {
      _chat = ModalRoute.of(context)!.settings.arguments as ChatModel;
      assert(_chat != null);

      _messagesBloc = MessagesBloc(_chat!);
      _messagesBloc!.listenForMessages();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_chat!.recipient.displayName),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<List<MessageModel>>(
            stream: _messagesBloc!.messages,
            builder: (BuildContext context, AsyncSnapshot<List<MessageModel>> messagesSnapshot) {
              if (messagesSnapshot.hasData) {
                if (messagesSnapshot.data!.isEmpty)
                  return CenteredText(label: S.current.noMessages);
                else
                  return ListView.separated(
                    reverse: true,
                    itemCount: messagesSnapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) => Message(message: messagesSnapshot.data!.elementAt(index)),
                    separatorBuilder: (BuildContext context, int index) => SizedBox(height: 8.0),
                  );
              }

              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
        SafeArea(
          minimum: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
          child: TextField(
            controller: _messageController,
            decoration: InputDecoration(
              hintText: S.current.writeAMessage,
              suffixIcon: IconButton(
                icon: Icon(Icons.send),
                onPressed: () async {
                  if (_messageController.text.isNotEmpty) {
                    MessageModel message = MessageModel(
                      id: randomAlphaNumeric(20),
                      messageType: MessageType.TEXT,
                      sentDateTime: DateTime.now(),
                      senderUid: Provider.of<UserModel>(context, listen: false).uid!,
                      body: _messageController.text,
                    );

                    await ChatHelper.sendMessage(_chat!, message, Provider.of<UserModel>(context, listen: false).uid!);
                    _messageController.clear();
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
