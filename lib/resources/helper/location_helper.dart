/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:13.
 * Copyright (c) 2021. All rights reserved.
 * Last modified 20/05/21, 10:07.
 */

import 'package:bookaround/models/place_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';

class LocationHelper {
  static Map<String, dynamic>? locationToJson(PlaceModel? location) => location != null ? location.toJson() : null;

  static Map<String, dynamic>? geoFirePointToJson(final GeoFirePoint? geoFirePoint) {
    return geoFirePoint?.data;
  }

  static GeoFirePoint? geoFirePointFromJson(final Map<String, dynamic>? json) {
    if (json == null) {
      return null;
    }

    final GeoPoint geoPoint = json["geopoint"] as GeoPoint;
    return GeoFirePoint(geoPoint);
  }
}
