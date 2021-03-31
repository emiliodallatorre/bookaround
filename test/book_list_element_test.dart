// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:bookaround/generated/l10n.dart';
import 'package:bookaround/interface/widget/book_list_element.dart';
import 'package:bookaround/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mock_objects.dart';

void main() {
  Widget materializeWidget(Widget child) => MaterialApp(home: Material(child: child));

  testWidgets("Testa il BookListElement.sell().", (WidgetTester tester) async {
    final BookModel mockBook = MockObjects.mockBook;
    await tester.pumpWidget(materializeWidget(BookListElement.sell(book: mockBook)));
    expect(find.text(mockBook.title!), findsOneWidget);
  });
  testWidgets("Testa il BookListElement.wanted().", (WidgetTester tester) async {
    await S.delegate.load(Locale("it"));
    final BookModel mockBook = MockObjects.mockBook;
    await tester.pumpWidget(materializeWidget(BookListElement.wanted(book: mockBook, color: Colors.red, results: <BookModel>[])));
    expect(find.text(mockBook.title!), findsOneWidget);

    expect(find.text(S.current.noResults), findsNothing);
    await tester.tap(find.byIcon(Icons.expand_more));
    await tester.pump();
    expect(find.text(S.current.noResults), findsOneWidget);
  });

  testWidgets("Testa il BookListElement.result().", (WidgetTester tester) async {
    await S.delegate.load(Locale("it"));
    final BookModel mockBook = MockObjects.mockBook;
    await tester.pumpWidget(materializeWidget(BookListElement.result(book: mockBook, showPosition: true)));
    expect(find.text(mockBook.distanceInKms!.toStringAsFixed(1) + S.current.km), findsOneWidget);
  });
}
