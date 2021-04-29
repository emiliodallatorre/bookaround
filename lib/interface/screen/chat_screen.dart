import 'package:bookaround/bloc/message_bloc.dart';
import 'package:bookaround/generated/l10n.dart';
import 'package:bookaround/interface/widget/centered_text.dart';
import 'package:bookaround/interface/widget/message.dart';
import 'package:bookaround/interface/widget/user_avatar.dart';
import 'package:bookaround/models/messaging/chat_model.dart';
import 'package:bookaround/models/messaging/message_model.dart';
import 'package:bookaround/models/user_model.dart';
import 'package:bookaround/resources/helper/chat_helper.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';

class ChatScreen extends StatefulWidget {
  static const String route = "/chatScreen";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  ChatModel? _chat;

  MessagesBloc? _messagesBloc;

  @override
  Widget build(BuildContext context) {
    if (_chat == null) {
      _chat = ModalRoute.of(context)!.settings.arguments as ChatModel;
      assert(_chat != null);

      _messagesBloc = MessagesBloc(_chat!, Provider.of<UserModel>(context, listen: false).uid!);
      _messagesBloc!.listenForMessages();
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(_chat!.recipient.displayName),
        actions: _chat!.recipient.profileImageUrl != null ? [UserAvatar(user: _chat!.recipient), SizedBox(width: 8.0)] : null,
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
                    padding: EdgeInsets.zero,
                    reverse: true,
                    itemCount: messagesSnapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) => Padding(
                      padding: EdgeInsets.only(top: index == messagesSnapshot.data!.length - 1 ? 8.0 : 0.0),
                      child: Message(message: messagesSnapshot.data!.elementAt(index)),
                    ),
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

  @override
  void dispose() {
    _messagesBloc?.dispose();

    super.dispose();
  }
}
