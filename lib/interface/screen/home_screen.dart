import 'package:bookaround/generated/l10n.dart';
import 'package:bookaround/models/user_model.dart';
import 'package:bookaround/references.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String route = "/homeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(References.appName),
      ),
      body: buildBody(context),
      extendBody: true,
      bottomNavigationBar: buildBottomNavigationBar(context),
      floatingActionButton: buildFloatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildBody(BuildContext context) {
    return Text(Provider.of<UserModel>(context).uid);
  }

  BottomAppBar buildBottomNavigationBar(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      clipBehavior: Clip.antiAlias,
      child: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (int newIndex) => setState(() => selectedIndex = newIndex),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: S.current.sellBooks),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: S.current.buyBooks),
        ],
      ),
    );
  }

  FloatingActionButton buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        // TODO: Implementare.
      },
    );
  }
}
