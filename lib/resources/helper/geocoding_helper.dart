/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:13.
 * Copyright (c) 2021. All rights reserved.
 * Last modified 20/05/21, 10:07.
 */

import 'package:bookaround/references.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeocodingHelper {
  static Future<Map<String, dynamic>> decodeAddress(String address) async {
    debugPrint("Cerco le coordinate di \"$address\".");

    List<Address> locations = await Geocoder.google(References.googleApiKey).findAddressesFromQuery(address);
    if (locations.isEmpty) throw "Indirizzo non trovato.";

    return GeoFirePoint(GeoPoint(locations.first.coordinates.latitude!, locations.first.coordinates.longitude!)).data;
  }

  static double distanceBetween(LatLng a, LatLng b) => Geolocator.distanceBetween(a.latitude, a.longitude, b.latitude, b.longitude) / 1000;
}
