import 'package:bookaround/resources/helper/geocoding_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationProvider extends ChangeNotifier {
  final Location location = Location();

  PermissionStatus? permissionStatus;
  LatLng? lastKnownLocation;

  /// Wrapper per lo stato dei permessi.
  Future<PermissionStatus> getPermissionStatus() async {
    PermissionStatus permissionStatus = await this.location.hasPermission();
    if (permissionStatus == PermissionStatus.granted)
      // Tutto ok
      this.permissionStatus = permissionStatus;
    else {
      // Il permesso può dover essere richiesto
      permissionStatus = await requestLocationPermission();
      this.permissionStatus = permissionStatus;
    }

    notifyListeners();
    return permissionStatus;
  }

  /// Wrapper per la richiesta dei permessi.
  Future<PermissionStatus> requestLocationPermission() async => await location.requestPermission();

  /// Restituisce la location o null in caso di errori.
  bool isLoadingLocation = false;

  Future<LatLng?> getLocation() async {
    try {
      debugPrint("Richiedo la localizzazione.");
      isLoadingLocation = true;
      final LocationData locationData = await location.getLocation();
      final LatLng lastKnownLocation = LatLng(locationData.latitude!, locationData.longitude!);

      this.lastKnownLocation = lastKnownLocation;

      debugPrint("Ho ottenuto la localizzazione.");
      notifyListeners();
      isLoadingLocation = false;
      return lastKnownLocation;
    } catch (e) {
      debugPrint(e.toString());

      return null;
    }
  }

  /// Restituisce la distanza in km da una certa posizione.
  double getDistance(LatLng objective) {
    assert(this.lastKnownLocation != null);

    return GeocodingHelper.distanceBetween(this.lastKnownLocation!, objective);
  }
}
