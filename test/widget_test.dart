// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:bookaround/interface/widget/book_list_element.dart';
import 'package:bookaround/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mock_objects.dart';

void main() {
  Widget materializeWidget(Widget child) => MaterialApp(home: Material(child: child));

  testWidgets("Testa il BookListElement.sell().", (WidgetTester tester) async {
    final BookModel mockBook = MockObjects.mockBook;
    // await tester.pumpWidget(Bookaround());

    await tester.pumpWidget(materializeWidget(BookListElement.sell(book: mockBook)));

    // Verify that our counter starts at 0.
    expect(find.text(mockBook.title!), findsOneWidget);

    // Tap the '+' icon and trigger a frame.
    /* await tester.tap(find.byIcon(Icons.add));
    await tester.pump(); */

    // Verify that our counter has incremented.
    /* expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget); */
  });
}
