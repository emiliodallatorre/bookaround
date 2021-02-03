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
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
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
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
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
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}