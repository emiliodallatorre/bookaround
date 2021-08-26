// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Phone number`
  String get phoneNumber {
    return Intl.message(
      'Phone number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Proceed`
  String get proceed {
    return Intl.message(
      'Proceed',
      name: 'proceed',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `This code is not working, try again`
  String get wrongCode {
    return Intl.message(
      'This code is not working, try again',
      name: 'wrongCode',
      desc: '',
      args: [],
    );
  }

  /// `My books`
  String get sellBooks {
    return Intl.message(
      'My books',
      name: 'sellBooks',
      desc: '',
      args: [],
    );
  }

  /// `Searching`
  String get buyBooks {
    return Intl.message(
      'Searching',
      name: 'buyBooks',
      desc: '',
      args: [],
    );
  }

  /// `There aren't any book here yet, add one with the "add" button...!`
  String get noBooks {
    return Intl.message(
      'There aren\'t any book here yet, add one with the "add" button...!',
      name: 'noBooks',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Edit profile`
  String get editProfile {
    return Intl.message(
      'Edit profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Surname`
  String get surname {
    return Intl.message(
      'Surname',
      name: 'surname',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get requiredField {
    return Intl.message(
      'This field is required',
      name: 'requiredField',
      desc: '',
      args: [],
    );
  }

  /// `Stop`
  String get cancelScan {
    return Intl.message(
      'Stop',
      name: 'cancelScan',
      desc: '',
      args: [],
    );
  }

  /// `The book presents colored highlighting`
  String get highlight {
    return Intl.message(
      'The book presents colored highlighting',
      name: 'highlight',
      desc: '',
      args: [],
    );
  }

  /// `The book presents pencil signs`
  String get pencil {
    return Intl.message(
      'The book presents pencil signs',
      name: 'pencil',
      desc: '',
      args: [],
    );
  }

  /// `The book has stuff written with pen`
  String get pen {
    return Intl.message(
      'The book has stuff written with pen',
      name: 'pen',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred with this book`
  String get bookError {
    return Intl.message(
      'An error occurred with this book',
      name: 'bookError',
      desc: '',
      args: [],
    );
  }

  /// `Where is this book?`
  String get whereIsBook {
    return Intl.message(
      'Where is this book?',
      name: 'whereIsBook',
      desc: '',
      args: [],
    );
  }

  /// `Note`
  String get note {
    return Intl.message(
      'Note',
      name: 'note',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Book not found`
  String get bookNotFoundError {
    return Intl.message(
      'Book not found',
      name: 'bookNotFoundError',
      desc: '',
      args: [],
    );
  }

  /// `Manual add`
  String get manualAdd {
    return Intl.message(
      'Manual add',
      name: 'manualAdd',
      desc: '',
      args: [],
    );
  }

  /// `Book title`
  String get title {
    return Intl.message(
      'Book title',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Authors, separated by a comma`
  String get authors {
    return Intl.message(
      'Authors, separated by a comma',
      name: 'authors',
      desc: '',
      args: [],
    );
  }

  /// `This field is not filled correctly`
  String get wrongField {
    return Intl.message(
      'This field is not filled correctly',
      name: 'wrongField',
      desc: '',
      args: [],
    );
  }

  /// `ISBN`
  String get isbn {
    return Intl.message(
      'ISBN',
      name: 'isbn',
      desc: '',
      args: [],
    );
  }

  /// `Responsible use`
  String get responsibleUse {
    return Intl.message(
      'Responsible use',
      name: 'responsibleUse',
      desc: '',
      args: [],
    );
  }

  /// `When you manually define this ISBN data, you are accepting that the users who - by now - will scan this ISBN, will use this data.\nWe cannot check every book insertion: please, insert this data correctly.`
  String get responsibleUseExtended {
    return Intl.message(
      'When you manually define this ISBN data, you are accepting that the users who - by now - will scan this ISBN, will use this data.\nWe cannot check every book insertion: please, insert this data correctly.',
      name: 'responsibleUseExtended',
      desc: '',
      args: [],
    );
  }

  /// `Choose image source`
  String get chooseSource {
    return Intl.message(
      'Choose image source',
      name: 'chooseSource',
      desc: '',
      args: [],
    );
  }

  /// `Please, take or upload a photo of the cover of the book you are inserting. This will be publicly visible.`
  String get chooseSourceExtended {
    return Intl.message(
      'Please, take or upload a photo of the cover of the book you are inserting. This will be publicly visible.',
      name: 'chooseSourceExtended',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get sourceCamera {
    return Intl.message(
      'Camera',
      name: 'sourceCamera',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get sourceGallery {
    return Intl.message(
      'Gallery',
      name: 'sourceGallery',
      desc: '',
      args: [],
    );
  }

  /// `Add image`
  String get addImage {
    return Intl.message(
      'Add image',
      name: 'addImage',
      desc: '',
      args: [],
    );
  }

  /// `Proximity search`
  String get proximitySearch {
    return Intl.message(
      'Proximity search',
      name: 'proximitySearch',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to enable proximity search?\nYou will be able to find nearby books.\nIf you won't enable it, you'll be able to enable it later in app settings.`
  String get enableProximityBooks {
    return Intl.message(
      'Do you want to enable proximity search?\nYou will be able to find nearby books.\nIf you won\'t enable it, you\'ll be able to enable it later in app settings.',
      name: 'enableProximityBooks',
      desc: '',
      args: [],
    );
  }

  /// `Nearby books`
  String get nearbyBooks {
    return Intl.message(
      'Nearby books',
      name: 'nearbyBooks',
      desc: '',
      args: [],
    );
  }

  /// `Enable`
  String get enable {
    return Intl.message(
      'Enable',
      name: 'enable',
      desc: '',
      args: [],
    );
  }

  /// `Undo`
  String get undo {
    return Intl.message(
      'Undo',
      name: 'undo',
      desc: '',
      args: [],
    );
  }

  /// `Search a book...`
  String get searchBook {
    return Intl.message(
      'Search a book...',
      name: 'searchBook',
      desc: '',
      args: [],
    );
  }

  /// `We didn't find anything with this query, please retry within the next days: some users could decide to sell this book in the future!`
  String get noResults {
    return Intl.message(
      'We didn\'t find anything with this query, please retry within the next days: some users could decide to sell this book in the future!',
      name: 'noResults',
      desc: '',
      args: [],
    );
  }

  /// `Type something to start a new search...`
  String get noSearch {
    return Intl.message(
      'Type something to start a new search...',
      name: 'noSearch',
      desc: '',
      args: [],
    );
  }

  /// `You haven't added any book to your search list yet, add one with the search button on the right...!`
  String get noSearchBooks {
    return Intl.message(
      'You haven\'t added any book to your search list yet, add one with the search button on the right...!',
      name: 'noSearchBooks',
      desc: '',
      args: [],
    );
  }

  /// `Usage`
  String get usage {
    return Intl.message(
      'Usage',
      name: 'usage',
      desc: '',
      args: [],
    );
  }

  /// `Present`
  String get present {
    return Intl.message(
      'Present',
      name: 'present',
      desc: '',
      args: [],
    );
  }

  /// `Sold by`
  String get soldBy {
    return Intl.message(
      'Sold by',
      name: 'soldBy',
      desc: '',
      args: [],
    );
  }

  /// `Chat`
  String get chats {
    return Intl.message(
      'Chat',
      name: 'chats',
      desc: '',
      args: [],
    );
  }

  /// `You don't have any chat yet.\nHere will appear the chats you'll start with other users.`
  String get noChats {
    return Intl.message(
      'You don\'t have any chat yet.\nHere will appear the chats you\'ll start with other users.',
      name: 'noChats',
      desc: '',
      args: [],
    );
  }

  /// `Get in touch with the seller`
  String get getInTouchWithSeller {
    return Intl.message(
      'Get in touch with the seller',
      name: 'getInTouchWithSeller',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get position {
    return Intl.message(
      'Location',
      name: 'position',
      desc: '',
      args: [],
    );
  }

  /// `Write a message...`
  String get writeAMessage {
    return Intl.message(
      'Write a message...',
      name: 'writeAMessage',
      desc: '',
      args: [],
    );
  }

  /// `No message in this chat, send one to start!`
  String get noMessages {
    return Intl.message(
      'No message in this chat, send one to start!',
      name: 'noMessages',
      desc: '',
      args: [],
    );
  }

  /// `kms`
  String get km {
    return Intl.message(
      'kms',
      name: 'km',
      desc: '',
      args: [],
    );
  }

  /// `Remove this insertion`
  String get removeBookFromSell {
    return Intl.message(
      'Remove this insertion',
      name: 'removeBookFromSell',
      desc: '',
      args: [],
    );
  }

  /// `I sold this book on Bookaround`
  String get removeBookBecauseSell {
    return Intl.message(
      'I sold this book on Bookaround',
      name: 'removeBookBecauseSell',
      desc: '',
      args: [],
    );
  }

  /// `I sold this book out of Bookaround`
  String get removeBookBecauseOtherSell {
    return Intl.message(
      'I sold this book out of Bookaround',
      name: 'removeBookBecauseOtherSell',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get removeBookBecauseAlter {
    return Intl.message(
      'Other',
      name: 'removeBookBecauseAlter',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get editInsertion {
    return Intl.message(
      'Edit',
      name: 'editInsertion',
      desc: '',
      args: [],
    );
  }

  /// `Book status`
  String get bookState {
    return Intl.message(
      'Book status',
      name: 'bookState',
      desc: '',
      args: [],
    );
  }

  /// `No ISBN found`
  String get noIsbnScanned {
    return Intl.message(
      'No ISBN found',
      name: 'noIsbnScanned',
      desc: '',
      args: [],
    );
  }

  /// `Insert ISBN`
  String get insertIsbn {
    return Intl.message(
      'Insert ISBN',
      name: 'insertIsbn',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `ISBNs are 10 or 13 characters long`
  String get isbnLengthError {
    return Intl.message(
      'ISBNs are 10 or 13 characters long',
      name: 'isbnLengthError',
      desc: '',
      args: [],
    );
  }

  /// `Edit image`
  String get editImage {
    return Intl.message(
      'Edit image',
      name: 'editImage',
      desc: '',
      args: [],
    );
  }

  /// `Delete image`
  String get deleteImage {
    return Intl.message(
      'Delete image',
      name: 'deleteImage',
      desc: '',
      args: [],
    );
  }

  /// `Remove this book from wishlist?`
  String get removeBookSearch {
    return Intl.message(
      'Remove this book from wishlist?',
      name: 'removeBookSearch',
      desc: '',
      args: [],
    );
  }

  /// `If you'll remove this book from your wishlist, you will stop receiving notifications if a user tries to sell a copy of it.`
  String get removeBookSearchExtended {
    return Intl.message(
      'If you\'ll remove this book from your wishlist, you will stop receiving notifications if a user tries to sell a copy of it.',
      name: 'removeBookSearchExtended',
      desc: '',
      args: [],
    );
  }

  /// `Use this button to add books you wanna sell.\nScan the corresponding ISBN (barcode) and Bookaround will get away with it.`
  String get showcaseFloatingActionButton {
    return Intl.message(
      'Use this button to add books you wanna sell.\nScan the corresponding ISBN (barcode) and Bookaround will get away with it.',
      name: 'showcaseFloatingActionButton',
      desc: '',
      args: [],
    );
  }

  /// `In this tab you'll be able to see your chats`
  String get showcaseChat {
    return Intl.message(
      'In this tab you\'ll be able to see your chats',
      name: 'showcaseChat',
      desc: '',
      args: [],
    );
  }

  /// `In this section you'll be able to add books to your wishlist and see sellers nearby`
  String get showcaseSearchBottom {
    return Intl.message(
      'In this section you\'ll be able to add books to your wishlist and see sellers nearby',
      name: 'showcaseSearchBottom',
      desc: '',
      args: [],
    );
  }

  /// `Use this button to find books you're looking for (by title, author or ISBN) and add them to your wishlist`
  String get showcaseAddToWishlist {
    return Intl.message(
      'Use this button to find books you\'re looking for (by title, author or ISBN) and add them to your wishlist',
      name: 'showcaseAddToWishlist',
      desc: '',
      args: [],
    );
  }

  /// `Terms and conditions`
  String get termsAndConditions {
    return Intl.message(
      'Terms and conditions',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Privacy policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Before logging in read our`
  String get beforeLogin {
    return Intl.message(
      'Before logging in read our',
      name: 'beforeLogin',
      desc: '',
      args: [],
    );
  }

  /// `and our`
  String get andOur {
    return Intl.message(
      'and our',
      name: 'andOur',
      desc: '',
      args: [],
    );
  }

  /// `Insert the code you received by SMS`
  String get insertSmsCode {
    return Intl.message(
      'Insert the code you received by SMS',
      name: 'insertSmsCode',
      desc: '',
      args: [],
    );
  }

  /// `Invite a friend`
  String get inviteAFriend {
    return Intl.message(
      'Invite a friend',
      name: 'inviteAFriend',
      desc: '',
      args: [],
    );
  }

  /// `Bookaround is free and will always be this way, we believe in Culture to be accessible to everyone as a source of freedom.\nI owe the inspiration for this app to my mother.`
  String get appAbout {
    return Intl.message(
      'Bookaround is free and will always be this way, we believe in Culture to be accessible to everyone as a source of freedom.\nI owe the inspiration for this app to my mother.',
      name: 'appAbout',
      desc: '',
      args: [],
    );
  }

  /// `Report book`
  String get reportBook {
    return Intl.message(
      'Report book',
      name: 'reportBook',
      desc: '',
      args: [],
    );
  }

  /// `Book reported correctly`
  String get reportedBook {
    return Intl.message(
      'Book reported correctly',
      name: 'reportedBook',
      desc: '',
      args: [],
    );
  }

  /// `Block this user`
  String get blockUser {
    return Intl.message(
      'Block this user',
      name: 'blockUser',
      desc: '',
      args: [],
    );
  }

  /// `At the moment, you haven't blocked any user.\nUse the options button in a chat screen to block a user.`
  String get noBlocked {
    return Intl.message(
      'At the moment, you haven\'t blocked any user.\nUse the options button in a chat screen to block a user.',
      name: 'noBlocked',
      desc: '',
      args: [],
    );
  }

  /// `Blocked users`
  String get blockedUsers {
    return Intl.message(
      'Blocked users',
      name: 'blockedUsers',
      desc: '',
      args: [],
    );
  }

  /// `Unblock`
  String get unblockUser {
    return Intl.message(
      'Unblock',
      name: 'unblockUser',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'it'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
