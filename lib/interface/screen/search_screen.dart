import 'package:bookaround/generated/l10n.dart';
import 'package:bookaround/interface/widget/isbn_list_element.dart';
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
      create: (BuildContext context) => SearchScreenState(Provider.of<UserModel>(context, listen: false).uid),
      builder: (BuildContext context, Widget child) => Scaffold(
        appBar: AppBar(
          title: TextField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration.collapsed(
              hintText: S.current.searchBook,
              hintStyle: TextStyle(color: Colors.white),
            ),
            textInputAction: TextInputAction.search,
            onSubmitted: (String query) async => await Provider.of<SearchScreenState>(context, listen: false).findBooks(query),
          ),
        ),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Consumer<SearchScreenState>(
      builder: (BuildContext context, SearchScreenState currentState, Widget child) => currentState.results == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: currentState.results.length,
              itemBuilder: (BuildContext context, int index) => IsbnListElement(isbn: currentState.results.elementAt(index)),
            ),
    );
  }
}

class SearchScreenState extends ChangeNotifier {
  final String currentUserUid;

  SearchScreenState(this.currentUserUid);

  List<IsbnModel> results = <IsbnModel>[];

  Future<void> findBooks(String query) async {
    debugPrint("Comincio a cercare \"$query\".");

    results = null;
    notifyListeners();

    results = await SearchProvider.searchBook(query, this.currentUserUid);
    notifyListeners();
  }
}
