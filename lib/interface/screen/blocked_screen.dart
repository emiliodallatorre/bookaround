/*
 * Created by Emilio Dalla Torre on 26/08/21, 19:32.
 * Copyright (c) 2021. All rights reserved.
 * Last modified 26/08/21, 19:32.
 */

import 'package:bookaround/generated/l10n.dart';
import 'package:bookaround/interface/widget/centered_text.dart';
import 'package:bookaround/interface/widget/user_avatar.dart';
import 'package:bookaround/models/user_model.dart';
import 'package:bookaround/resources/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlockedScreen extends StatelessWidget {
  static const String route = "/blockedScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.current.blockedUsers)),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Consumer<UserModel>(
      builder: (BuildContext context, UserModel currentUser, Widget? child) {
        return FutureBuilder<List<UserModel>>(
          future: UserProvider.getMultipleUsers(currentUser.blockedUids!),
          builder: (BuildContext context, AsyncSnapshot<List<UserModel>> usersSnapshot) {
            if (usersSnapshot.hasData) {
              if (usersSnapshot.data!.isNotEmpty)
                return ListView.builder(
                  itemCount: usersSnapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) => ListTile(
                    leading: usersSnapshot.data!.elementAt(index).profileImageUrl != null ? UserAvatar(user: usersSnapshot.data!.elementAt(index)) : null,
                    title: Text(usersSnapshot.data!.elementAt(index).displayName),
                    subtitle: Text(usersSnapshot.data!.elementAt(index).city ?? ""),
                    trailing: TextButton(
                      child: Text(S.current.unblockUser),
                      onPressed: () {
                        currentUser.blockedUids!.remove(usersSnapshot.data!.elementAt(index).uid);
                        currentUser.updateOnServer();
                      },
                    ),
                  ),
                );
              else
                return CenteredText(label: S.current.noBlocked);
            }

            return Center(child: CircularProgressIndicator());
          },
        );
      },
    );
  }
}
