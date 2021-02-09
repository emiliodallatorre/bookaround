// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "add" : MessageLookupByLibrary.simpleMessage("Add"),
    "authors" : MessageLookupByLibrary.simpleMessage("Authors, separated by a comma"),
    "bookError" : MessageLookupByLibrary.simpleMessage("An error occurred with this book"),
    "bookNotFoundError" : MessageLookupByLibrary.simpleMessage("Book not found"),
    "buyBooks" : MessageLookupByLibrary.simpleMessage("Searching"),
    "cancelScan" : MessageLookupByLibrary.simpleMessage("Stop"),
    "city" : MessageLookupByLibrary.simpleMessage("City"),
    "editProfile" : MessageLookupByLibrary.simpleMessage("Edit profile"),
    "highlight" : MessageLookupByLibrary.simpleMessage("The book presents colored highlighting"),
    "isbn" : MessageLookupByLibrary.simpleMessage("ISBN"),
    "login" : MessageLookupByLibrary.simpleMessage("Login"),
    "logout" : MessageLookupByLibrary.simpleMessage("Logout"),
    "manualAdd" : MessageLookupByLibrary.simpleMessage("Manual add"),
    "name" : MessageLookupByLibrary.simpleMessage("Name"),
    "noBooks" : MessageLookupByLibrary.simpleMessage("There aren\'t any book here yet, add one with the \"add\" button...!"),
    "note" : MessageLookupByLibrary.simpleMessage("Note"),
    "pen" : MessageLookupByLibrary.simpleMessage("The book has stuff written with pen"),
    "pencil" : MessageLookupByLibrary.simpleMessage("The book presents pencil signs"),
    "phoneNumber" : MessageLookupByLibrary.simpleMessage("Phone number"),
    "proceed" : MessageLookupByLibrary.simpleMessage("Proceed"),
    "requiredField" : MessageLookupByLibrary.simpleMessage("This field is required"),
    "responsibleUse" : MessageLookupByLibrary.simpleMessage("Responsible use"),
    "responsibleUseExtended" : MessageLookupByLibrary.simpleMessage("When you manually define this ISBN data, you are accepting that the users who - by now - will scan this ISBN, will use this data.\nWe cannot check every book insertion: please, insert this data correctly."),
    "save" : MessageLookupByLibrary.simpleMessage("Save"),
    "sellBooks" : MessageLookupByLibrary.simpleMessage("My books"),
    "surname" : MessageLookupByLibrary.simpleMessage("Surname"),
    "title" : MessageLookupByLibrary.simpleMessage("Book title"),
    "whereIsBook" : MessageLookupByLibrary.simpleMessage("Where is this book?"),
    "wrongCode" : MessageLookupByLibrary.simpleMessage("This code is not working, try again")
  };
}
