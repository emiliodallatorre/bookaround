import 'package:bookaround/generated/l10n.dart';
import 'package:bookaround/interface/pages/book_search_page.dart';
import 'package:bookaround/interface/pages/book_sell_page.dart';
import 'package:bookaround/interface/pages/chat_page.dart';
import 'package:bookaround/interface/screen/book_editor_screen.dart';
import 'package:bookaround/interface/screen/isbn_editor_screen.dart';
import 'package:bookaround/interface/screen/profile_editor_screen.dart';
import 'package:bookaround/interface/screen/search_screen.dart';
import 'package:bookaround/interface/widget/user_avatar.dart';
import 'package:bookaround/models/book_model.dart';
import 'package:bookaround/models/user_model.dart';
import 'package:bookaround/references.dart';
import 'package:bookaround/resources/errors/book_not_found_error.dart';
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
      appBar: AppBar(
        title: Text(References.appName),
        actions: [
          Visibility(
            visible: selectedIndex == 2,
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () => Navigator.of(context).pushNamed(SearchScreen.route),
            ),
          ),
        ],
      ),
      drawer: buildDrawer(context),
      body: buildBody(context),
      extendBody: true,
      bottomNavigationBar: buildBottomNavigationBar(context),
      floatingActionButton: buildFloatingActionButton(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildBody(BuildContext context) {
    return IndexedStack(
      index: selectedIndex,
      children: [
        BookSellPage(type: BookType.SELLING),
        ChatPage(),
        BookSearchPage(),
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
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: S.current.chats),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: S.current.buyBooks),
          ],
        ),
      ],
    );
  }

  Widget buildFloatingActionButton() {
    return Visibility(
      visible: selectedIndex == 0,
      child: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          if (selectedIndex == 0) {
            setState(() => working = true);

            String? isbn;
            isbn = await BarcodeHelper.readBarcode(context);
            // isbn = "97888089199222";

            if (isbn != null)
              await startBookSellCreation(isbn);
            else {
              setState(() => working = false);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(S.current.noIsbnScanned),
                action: SnackBarAction(
                  label: S.current.manualAdd,
                  onPressed: () async {
                    String? isbn = await showDialog<String>(
                        context: context,
                        builder: (BuildContext context) {
                          final TextEditingController isbnTextEditingController = TextEditingController();
                          final GlobalKey<FormState> formKey = GlobalKey<FormState>();

                          return AlertDialog(
                            title: Text(S.current.insertIsbn),
                            content: Form(
                              key: formKey,
                              child: TextFormField(keyboardType: TextInputType.number,
                                validator: (String? value) {
                                  if (value != null) if (value.length == 10 || value.length == 13) return null;

                                  return S.current.isbnLengthError;
                                },
                                decoration: InputDecoration(hintText: "978..."),
                                controller: isbnTextEditingController,
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                child: Text(S.current.ok),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    Navigator.of(context).pop(isbnTextEditingController.text);
                                  }
                                },
                              ),
                            ],
                          )
                        }
                    );

                    if (isbn != null) await startBookSellCreation(isbn);
                  },
                ),
              ));
            }
          } else if (selectedIndex == 2) {
            // TODO: Aggiungere libri alla ricerca.
          }
        },
      ),
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<UserModel>(
            builder: (BuildContext context, UserModel currentUser, Widget? child) =>
                UserAccountsDrawerHeader(
                  currentAccountPicture: UserAvatar(user: currentUser),
                  accountName: Text(currentUser.displayName),
                  accountEmail: Text(currentUser.phoneNumber!),
                ),
          ),
          ListTile(
            title: Text(S.current.editProfile),
            onTap: () => Navigator.of(context).pushNamed(ProfileEditorScreen.route),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(left: 16.0, bottom: MediaQuery
                .of(context)
                .viewPadding
                .bottom),
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

  Future<void> startBookSellCreation(String isbn) async {
    setState(() => working = true);
    try {
      // Il libro esiste nel database.
      BookModel book = await BookHelper.createBookSell(isbn, Provider
          .of<UserModel>(context, listen: false)
          .uid!);
      Navigator.of(context).pushNamed(BookEditorScreen.route, arguments: book);
    } on BookNotFoundError {
      // Il libro non esiste nel database.
      setState(() => working = false);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(S.current.bookNotFoundError),
        action: SnackBarAction(
          label: S.current.add,
          onPressed: () => Navigator.of(context).pushNamed(IsbnEditorScreen.route, arguments: isbn),
        ),
      ));
    } catch (e) {
      // È comparso un errore sconosciuto.
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.current.bookError)));
    }
    setState(() => working = false);
  }
}
