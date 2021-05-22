/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:13.
 * Copyright (c) 2021. All rights reserved.
 * Last modified 20/05/21, 10:07.
 */

import 'package:bookaround/assets.dart';
import 'package:bookaround/bloc/chat_bloc.dart';
import 'package:bookaround/generated/l10n.dart';
import 'package:bookaround/interface/pages/book_search_page.dart';
import 'package:bookaround/interface/pages/book_sell_page.dart';
import 'package:bookaround/interface/pages/chat_page.dart';
import 'package:bookaround/interface/screen/book_editor_screen.dart';
import 'package:bookaround/interface/screen/isbn_editor_screen.dart';
import 'package:bookaround/interface/screen/profile_editor_screen.dart';
import 'package:bookaround/interface/screen/search_screen.dart';
import 'package:bookaround/interface/screen/web_view_screen.dart';
import 'package:bookaround/interface/widget/user_avatar.dart';
import 'package:bookaround/keys.dart';
import 'package:bookaround/models/book_model.dart';
import 'package:bookaround/models/user_model.dart';
import 'package:bookaround/references.dart';
import 'package:bookaround/resources/errors/book_not_found_error.dart';
import 'package:bookaround/resources/helper/barcode_helper.dart';
import 'package:bookaround/resources/helper/book_helper.dart';
import 'package:bookaround/resources/helper/dynamic_link_helper.dart';
import 'package:bookaround/resources/helper/init_helper.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:tuple/tuple.dart';

class HomeScreen extends StatefulWidget {
  static const String route = "/homeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int selectedIndex = 0;
  bool working = false;
  bool initialized = false;

  @override
  void initState() {
    this.listenForDynamicLinks();

    super.initState();
  }

  Future<void> listenForDynamicLinks() async {
    final PendingDynamicLinkData? initialDynamicLink = await FirebaseDynamicLinks.instance.getInitialLink();
    if (initialDynamicLink != null) await DynamicLinkHelper.followLink(context, initialDynamicLink);

    FirebaseDynamicLinks.instance.onLink(onSuccess: (PendingDynamicLinkData? dynamicLink) async => await DynamicLinkHelper.followLink(context, dynamicLink));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) =>
      ChatBloc(Provider.of<UserModel>(context, listen: false))
        ..listenForChats(),
      builder: (BuildContext context, Widget? child) =>
          ShowCaseWidget(
            autoPlay: true,
            autoPlayDelay: Duration(seconds: 6),
            builder: Builder(builder: (BuildContext context) =>
                Scaffold(
                  key: scaffoldKey,
                  appBar: AppBar(
                    title: Text(References.appName),
                    actions: [
                      Visibility(
                        visible: selectedIndex == 2,
                        child: Showcase(
                          key: Keys.searchTopKey,
                          description: S.current.showcaseAddToWishlist,
                          shapeBorder: CircleBorder(),
                          contentPadding: const EdgeInsets.all(16.0),
                          // onTargetClick: () => Navigator.of(context).pushNamed(SearchScreen.route),
                          // disposeOnTap: false,
                          child: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () => Navigator.of(context).pushNamed(SearchScreen.route),
                          ),
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
                ),
            ),
            onFinish: () async {

            },
            onStart: (int? _, GlobalKey __) async {
              debugPrint("Lo showcase è iniziato, lo segnalo.");
              Provider
                  .of<UserModel>(context, listen: false)
                  .hasGoneThroughShowcase = true;
              await Provider.of<UserModel>(context, listen: false).updateOnServer();
            },
          ),
    );
  }

  Widget buildBody(BuildContext context) {
    return
      IndexedStack(
        index: selectedIndex,
        children: [
          BookSellPage(type: BookType.SELLING),
          ChatPage(),
          BookSearchPage(),
        ],
      );
  }

  Widget buildBottomNavigationBar(BuildContext context) {
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
            BottomNavigationBarItem(
              icon: Showcase(
                key: Keys.chatKey,
                description: S.current.showcaseChat,
                shapeBorder: CircleBorder(),
                contentPadding: EdgeInsets.all(16.0),
                // onToolTipClick: () => setState(() => selectedIndex = 1),
                // onTargetClick: () => setState(() => selectedIndex = 1),
                // disposeOnTap: false,
                child: Icon(Icons.chat),
              ),
              label: S.current.chats,
            ),
            BottomNavigationBarItem(
              icon: Showcase(
                key: Keys.searchBottomKey,
                description: S.current.showcaseSearchBottom,
                shapeBorder: CircleBorder(),
                contentPadding: EdgeInsets.all(16.0),
                // onToolTipClick: () => setState(() => selectedIndex = 2),
                // onTargetClick: () => setState(() => selectedIndex = 2),
                // disposeOnTap: false,
                child: Icon(Icons.search),
              ),
              label: S.current.buyBooks,
            ),
          ],
        ),
      ],
    );
  }

  Widget buildFloatingActionButton() {
    return SafeArea(
      child: Visibility(
        visible: selectedIndex == 0,
        child: Showcase(
          key: Keys.floatingActionButtonKey,
          description: S.current.showcaseFloatingActionButton,
          shapeBorder: CircleBorder(),
          contentPadding: const EdgeInsets.all(16.0),
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
        ),
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
            leading: Icon(Icons.account_circle),
            title: Text(S.current.editProfile),
            onTap: () => Navigator.of(context).pushNamed(ProfileEditorScreen.route),
          ),
          ListTile(
            leading: Icon(Icons.person_add),
            title: Text(S.current.inviteAFriend),
            onTap: () => Share.share(References.sharableAppLink),
          ),
          AboutListTile(
            icon: const Icon(Icons.info),
            applicationIcon: SvgPicture.asset(Assets.logo, width: 64, height: 64, fit: BoxFit.cover,),
            applicationName: References.appName,
            applicationLegalese: References.copyrightString,
            // TODO: Tenere aggiornata questa stringa.
            applicationVersion: "v0.1.0",
            aboutBoxChildren: [
              Text(S.current.appAbout),
            ],
          ),
          Spacer(),
          ListTile(
            title: Text(S.current.privacyPolicy),
            onTap: () => Navigator.of(context).pushNamed(WebViewScreen.route, arguments: Tuple2<String, String>(S.current.privacyPolicy, References.privacyPolicyUrl)),
          ),
          ListTile(
            title: Text(S.current.termsAndConditions),
            onTap: () => Navigator.of(context).pushNamed(WebViewScreen.route, arguments: Tuple2<String, String>(S.current.termsAndConditions, References.termsAndConditionsUrl)),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0, bottom: MediaQuery
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
