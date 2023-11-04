/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:13.
 * Copyright (c) 2021. All rights reserved.
 * Last modified 20/05/21, 10:07.
 */

import 'package:bookaround/generated/l10n.dart';
import 'package:bookaround/interface/widget/search_result_list_element.dart';
import 'package:bookaround/models/isbn_model.dart';
import 'package:bookaround/models/user_model.dart';
import 'package:bookaround/resources/provider/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  static const String route = "/searchScreen";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => SearchScreenState(Provider.of<UserModel>(context, listen: false).uid!),
      builder: (BuildContext context, Widget? child) => Scaffold(
        appBar: AppBar(
          title: TextField(
            decoration: InputDecoration.collapsed(
              hintText: S.current.searchBook,
            ),
            textInputAction: TextInputAction.search,
            onSubmitted: (String query) async => await Provider.of<SearchScreenState>(context, listen: false).findBooks(query),
            autofocus: true,
          ),
        ),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Consumer<SearchScreenState>(
      builder: (BuildContext context, SearchScreenState currentState, Widget? child) {
        if (currentState.state == SearchState.UNINITIALIZED)
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(S.current.noSearch, style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.center),
            ),
          );
        else {
          if (currentState.results == null)
            return Center(child: CircularProgressIndicator());
          else if (currentState.results!.isEmpty)
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(S.current.noResults, style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.center),
              ),
            );
          else
            return ListView.builder(
              itemCount: currentState.results!.length,
              itemBuilder: (BuildContext context, int index) => SearchResultListElement(isbn: currentState.results!.elementAt(index)),
            );
        }
      },
    );
  }
}

class SearchScreenState extends ChangeNotifier {
  final String currentUserUid;

  SearchScreenState(this.currentUserUid);

  SearchState state = SearchState.UNINITIALIZED;
  List<IsbnModel>? results;

  Future<void> findBooks(String query) async {
    debugPrint("Comincio a cercare \"$query\".");

    state = SearchState.SEARCH;
    results = null;
    notifyListeners();

    results = await SearchProvider.searchBook(query, this.currentUserUid);
    state = SearchState.IDLE;
    notifyListeners();
  }
}

enum SearchState { SEARCH, IDLE, UNINITIALIZED }
