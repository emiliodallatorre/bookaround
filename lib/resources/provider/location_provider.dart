import 'package:bookaround/models/book_model.dart';
import 'package:bookaround/references.dart';
import 'package:bookaround/resources/provider/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:location/location.dart';

class LocationProvider extends ChangeNotifier {
  Location locator = Location.instance;

  LocationData lastKnownLocation;
  bool wasOk = false;

  Future<bool> isOk([List<String> wanted]) async {
    try {
      await getPermissionStatus();
      await getLocation();

      wasOk = true;
      return true;
    } catch (e) {
      debugPrint(e);

      wasOk = false;
      return false;
    }
  }

  Future<void> getLocation() async {
    lastKnownLocation = await Location.instance.getLocation();

    notifyListeners();
  }

  Future<void> getPermissionStatus() async {
    bool _serviceEnabled = await locator.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await locator.requestService();
      if (!_serviceEnabled)
        return;
      else
        throw "Geolocalizzazione disattivata.";
    }

    PermissionStatus permissionStatus = await locator.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await locator.requestPermission();
      if (permissionStatus == PermissionStatus.granted)
        return;
      else
        throw "Permessi per la geolocalizzazione rifiutati.";
    }
  }

  Geoflutterfire geoflutterfire = Geoflutterfire();
  List<BookModel> nearbyBooks;

  Future<void> getNearbyBooks(List<String> wanted) async {
    var queryRef = References.booksCollection;
    var stream = geoflutterfire.collection(collectionRef: queryRef).within(
          center: GeoFirePoint(lastKnownLocation.latitude, lastKnownLocation.longitude),
          radius: 10,
          field: "locationData",
        );

    stream.listen((List<DocumentSnapshot> rawNearbyBooks) async {
      List<BookModel> foundBooks = <BookModel>[];
      for(int index = 0; index < rawNearbyBooks.length; index++) {
        BookModel bookModel = BookModel.fromJson(rawNearbyBooks.elementAt(index).data());
        bookModel.reference = rawNearbyBooks.elementAt(index).reference;
        bookModel.user = await UserProvider.getUserByUid(bookModel.userUid);

        foundBooks.add(bookModel);
      }

      if (wanted != null) foundBooks.removeWhere((element) => !wanted.contains(element.isbn13));

      this.nearbyBooks = foundBooks;
    });
  }
}
