/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:13.
 * Copyright (c) 2021. All rights reserved.
 * Last modified 20/05/21, 10:07.
 */

import 'package:bookaround/assets.dart';
import 'package:bookaround/models/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final UserModel user;
  final bool big;

  const UserAvatar({Key? key, required this.user, this.big = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget smallWidget = CircleAvatar(
      backgroundColor: Theme.of(context).canvasColor,
      backgroundImage: this.user.profileImageUrl == null ? null : CachedNetworkImageProvider(this.user.profileImageUrl!),
      child: this.user.profileImageUrl != null
          ? null
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image(image: Images.panda, fit: BoxFit.contain),
            ),
    );

    if (!big) return smallWidget;

    return AspectRatio(
      aspectRatio: 1.0,
      child: smallWidget,
    );
  }
}
