import 'package:bookaround/generated/l10n.dart';
import 'package:bookaround/interface/pages/books_page.dart';
import 'package:bookaround/interface/screen/book_editor_screen.dart';
import 'package:bookaround/interface/screen/profile_editor_screen.dart';
import 'package:bookaround/interface/widget/user_avatar.dart';
import 'package:bookaround/models/book_model.dart';
import 'package:bookaround/models/user_model.dart';
import 'package:bookaround/references.dart';
import 'package:bookaround/resources/helper/barcode_helper.dart';
import 'package:bookaround/resources/helper/book_helper.dart';
import 'package:bookaround/resources/helper/init_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String route = "/homeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int selectedIndex = 0;
  bool working = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: Text(References.appName)),
      drawer: buildDrawer(context),
      body: buildBody(context),
      extendBody: true,
      bottomNavigationBar: buildBottomNavigationBar(context),
      floatingActionButton: buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildBody(BuildContext context) {
    return IndexedStack(
      index: selectedIndex,
      children: [
        BooksPage(),
        Container(color: Colors.purple),
      ],
    );
  }

  Column buildBottomNavigationBar(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
          visible: working,
          child: LinearProgressIndicator(),
        ),
        BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (int newIndex) => setState(() => selectedIndex = newIndex),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: S.current.sellBooks),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: S.current.buyBooks),
          ],
        ),
      ],
    );
  }

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () async {
        if (selectedIndex == 0) {
          setState(() => working = true);

          try {
            final String isbn = await BarcodeHelper.readBarcode(context);

            if (isbn != null) {
              BookModel book = await BookHelper.createBookSell(isbn, Provider.of<UserModel>(context, listen: false).uid);
              Navigator.of(context).pushNamed(BookEditorScreen.route, arguments: book);
            }
          } catch (e) {
            scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(S.current.bookError)));
          }

          setState(() => working = false);
        } else if (selectedIndex == 1) {
          // TODO: Aggiungere libri alla ricerca.
        }
      },
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<UserModel>(
            builder: (BuildContext context, UserModel currentUser, Widget child) => UserAccountsDrawerHeader(
              currentAccountPicture: UserAvatar(user: currentUser),
              accountName: Text(currentUser.displayName),
              accountEmail: Text(currentUser.phoneNumber),
            ),
          ),
          ListTile(
            title: Text(S.current.editProfile),
            onTap: () => Navigator.of(context).pushNamed(ProfileEditorScreen.route),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(left: 16.0, bottom: MediaQuery.of(context).viewPadding.bottom),
            child: Column(
              children: [
                TextButton(
                  child: Text(S.current.logout),
                  onPressed: () async => await InitHelper(context).deinitialize(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
