import 'package:bookaround/models/book_model.dart';
import 'package:bookaround/models/place_model.dart';
import 'package:random_string/random_string.dart';

class MockObjects {
  static PlaceModel get mockPlace => PlaceModel(
        id: randomAlphaNumeric(20),
        placeReference: randomAlphaNumeric(20),
        description: randomAlpha(20),
        placeId: randomAlphaNumeric(20),
      );

  static BookModel get mockBook => BookModel(
        id: randomAlphaNumeric(20),
        userUid: randomAlphaNumeric(20),
        addedDateTime: DateTime.now(),
        authors: List.generate(2, (index) => randomAlpha(10)),
        type: BookType.SELLING,
        title: randomAlpha(16),
        note: randomAlphaNumeric(40),
        coverUrl: "",
        isbn: randomNumeric(10),
        isbn13: randomNumeric(13),
        pen: true,
        pencil: false,
        highlighting: true,
        location: mockPlace,
      );
}
