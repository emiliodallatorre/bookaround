import 'package:bookaround/references.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class GeocodingHelper {
  static Future<Map<String, dynamic>> decodeAddress(String address) async {
    debugPrint("Cerco le coordinate di \"$address\".");

    List<Address> locations = await Geocoder.google(References.googleApiKey).findAddressesFromQuery(address);
    if (locations.isEmpty) throw "Indirizzo non trovato.";

    return GeoFirePoint(locations.first.coordinates.latitude, locations.first.coordinates.longitude).data;
  }
}