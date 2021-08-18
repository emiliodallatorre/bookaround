/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:13.
 * Copyright (c) 2021. All rights reserved.
 * Last modified 20/05/21, 10:07.
 */

import 'package:bookaround/bloc/book_bloc.dart';
import 'package:bookaround/generated/l10n.dart';
import 'package:bookaround/interface/screen/book_editor_screen.dart';
import 'package:bookaround/interface/screen/chat_screen.dart';
import 'package:bookaround/interface/widget/book_cover.dart';
import 'package:bookaround/map_styles.dart';
import 'package:bookaround/models/book_model.dart';
import 'package:bookaround/models/messaging/chat_model.dart';
import 'package:bookaround/models/user_model.dart';
import 'package:bookaround/resources/helper/book_helper.dart';
import 'package:bookaround/resources/helper/report_helper.dart';
import 'package:bookaround/resources/provider/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class BookScreen extends StatefulWidget {
  static const String route = "/bookScreen";

  @override
  _BookScreenState createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  BookModel? _book;

  @override
  Widget build(BuildContext context) {
    if (_book == null) _book = ModalRoute.of(context)!.settings.arguments as BookModel;

    return Scaffold(
      appBar: AppBar(
        actions: [
          if (_book!.userUid != Provider.of<UserModel>(context).uid)
            PopupMenuButton(
              itemBuilder: (BuildContext context) => <String>[S.current.reportBook]
                  .map((final String choice) => PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      ))
                  .toList(),
              onSelected: (final String choice) async {
                if (choice == S.current.reportBook) {
                  ReportHelper.reportBook(_book!.id!, Provider.of<UserModel>(context, listen: false).uid!).whenComplete(() {
                    if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.current.reportedBook)));
                  });
                }
              },
            ),
        ],
      ),
      body: buildBody(),
      persistentFooterButtons: buildPersistentFooterButtons(),
    );
  }

  Widget buildBody() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BookCover(book: _book!, horizontalPadding: false),

              Text(S.current.bookState, style: Theme.of(context).textTheme.headline4),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(S.current.pencil)),
                      Checkbox(value: _book!.pencil, onChanged: null),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: Text(S.current.pen)),
                      Checkbox(value: _book!.pen, onChanged: null),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: Text(S.current.highlight)),
                      Checkbox(value: _book!.highlighting, onChanged: null),
                    ],
                  ),
                ],
              ),
              if (_book!.note!.isNotEmpty) Text(S.current.note, style: Theme.of(context).textTheme.caption),
              if (_book!.note!.isNotEmpty) Text(_book!.note!),
              if (_book!.userUid != Provider.of<UserModel>(context).uid) _buildSellerInfo(context),
              // _buildSellerInfo(context),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSellerInfo(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Divider(),
        Text(S.current.soldBy, style: Theme.of(context).textTheme.headline4),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(_book!.user!.displayName, style: Theme.of(context).textTheme.headline6),
                Text(_book!.user!.city!, style: Theme.of(context).textTheme.caption),
              ],
            ),
          ],
        ),
        Divider(),
        AspectRatio(
          aspectRatio: 4 / 3,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(target: _book!.modelizedLocation, zoom: 12.0),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            markers: <Marker>[Marker(markerId: MarkerId(_book!.id!), position: _book!.modelizedLocation)].toSet(),
            onMapCreated: (GoogleMapController controller) {
              if (Theme.of(context).brightness != Brightness.light) controller.setMapStyle(MapStyles.darkMap);
            },
          ),
        ),
      ],
    );
  }

  List<Widget> buildPersistentFooterButtons() {
    if (_book!.userUid != Provider.of<UserModel>(context).uid)
      return <Widget>[
        ElevatedButton(
          child: Text(S.current.getInTouchWithSeller),
          onPressed: () async {
            final ChatModel? chat = await ChatProvider.getChat(_book!.userUid, Provider.of<UserModel>(context, listen: false).uid!);

            if (chat != null) Navigator.of(context).pushNamed(ChatScreen.route, arguments: chat);
          },
        ),
      ];
    else
      return <Widget>[
        TextButton(
          child: Text(S.current.editInsertion),
          onPressed: () => Navigator.of(context).pushReplacementNamed(BookEditorScreen.route, arguments: this._book),
        ),
        ElevatedButton(
          child: Text(S.current.removeBookFromSell),
          onPressed: () async {
            bool delete = await showModalBottomSheet<bool>(
                  context: context,
                  builder: (BuildContext context) => ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                        child: Text(S.current.removeBookFromSell, style: Theme.of(context).textTheme.headline5),
                      ),
                      ListTile(
                        title: Text(S.current.removeBookBecauseSell),
                        onTap: () => Navigator.of(context).pop(true),
                      ),
                      ListTile(
                        title: Text(S.current.removeBookBecauseOtherSell),
                        onTap: () => Navigator.of(context).pop(true),
                      ),
                      ListTile(
                        title: Text(S.current.removeBookBecauseAlter),
                        onTap: () => Navigator.of(context).pop(true),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ElevatedButton(
                          child: Text(S.current.undo),
                          onPressed: () => Navigator.of(context).pop(false),
                        ),
                      ),
                    ],
                  ),
                ) ??
                false;

            if (delete) {
              await BookHelper.removeBookFromSell(this._book!.id!);
              await sellBooksBloc.getUserBooks(Provider.of<UserModel>(context, listen: false).uid!);

              Navigator.of(context).pop();
            }
          },
        ),
      ];
  }
}
