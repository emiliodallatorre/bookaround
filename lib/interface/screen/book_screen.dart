import 'package:bookaround/generated/l10n.dart';
import 'package:bookaround/interface/screen/chat_screen.dart';
import 'package:bookaround/interface/widget/book_cover.dart';
import 'package:bookaround/map_styles.dart';
import 'package:bookaround/models/book_model.dart';
import 'package:bookaround/models/messaging/chat_model.dart';
import 'package:bookaround/models/user_model.dart';
import 'package:bookaround/resources/provider/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class BookScreen extends StatelessWidget {
  static const String route = "/bookScreen";

  BookModel? _book;

  @override
  Widget build(BuildContext context) {
    if (_book == null) _book = ModalRoute.of(context)!.settings.arguments as BookModel;

    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(context),
      persistentFooterButtons: [
        ElevatedButton(
          child: Text(S.current.getInTouchWithSeller),
          onPressed: () async {
            final ChatModel? chat = await ChatProvider.getChat(_book!.userUid!, Provider.of<UserModel>(context, listen: false).uid!);

            if (chat != null) {
              Navigator.of(context).pushNamed(ChatScreen.route);
            }
          },
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              BookCover(book: _book!, horizontalPadding: false),
              Row(
                children: [
                  Expanded(
                    child: Column(
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
                  ),
                ],
              ),
              if (_book!.note!.isNotEmpty) Text(S.current.note, style: Theme.of(context).textTheme.caption),
              if (_book!.note!.isNotEmpty) Text(_book!.note!),
              if (_book!.userUid != Provider.of<UserModel>(context).uid) _buildSellerInfo(context),
              _buildSellerInfo(context),
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
      crossAxisAlignment: CrossAxisAlignment.start,
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
        SizedBox(
          width: double.infinity,
          child: AspectRatio(
            aspectRatio: 4 / 3,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(target: _book!.modelizedLocation, zoom: 12.0),
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              markers: <Marker>[Marker(markerId: MarkerId(_book!.id!), position: _book!.modelizedLocation)].toSet(),
              onMapCreated: (GoogleMapController controller) {
                if (Theme.of(context).brightness == Brightness.light)
                  controller.setMapStyle(MapStyles.lightMap);
                else
                  controller.setMapStyle(MapStyles.darkMap);
              },
            ),
          ),
        ),
      ],
    );
  }
}
