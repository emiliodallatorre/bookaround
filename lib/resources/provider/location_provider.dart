import 'package:bookaround/models/book_model.dart';
import 'package:bookaround/references.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:location/location.dart';

class LocationProvider extends ChangeNotifier {
  Location locator = Location.instance;

  LocationData lastKnownLocation;
  bool wasOk = false;

  Future<bool> isOk() async {
    try {
      await getPermissionStatus();
      await getLocation();
      getNearbyBooks();

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
      if (permissionStatus != PermissionStatus.granted)
        return;
      else
        throw "Permessi per la geolocalizzazione rifiutati.";
    }
  }

  Geoflutterfire geoflutterfire = Geoflutterfire();
  List<BookModel> nearbyBooks;

  Future<void> getNearbyBooks() async {
    var queryRef = References.booksCollection;
    var stream = geoflutterfire.collection(collectionRef: queryRef).within(
          center: GeoFirePoint(lastKnownLocation.latitude, lastKnownLocation.longitude),
          radius: 10,
          field: "locationData",
        );

    stream.listen((List<DocumentSnapshot> rawNearbyBooks) => this.nearbyBooks = rawNearbyBooks.map((e) => BookModel.fromJson(e.data())..reference = e.reference).toList());
  }
}
