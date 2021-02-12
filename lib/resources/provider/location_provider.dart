import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationProvider extends ChangeNotifier {
  Location locator = Location.instance;

  LocationData lastKnownLocation;
  bool wasOk = false;

  Future<bool> isOk() async {
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
      if (permissionStatus != PermissionStatus.granted)
        return;
      else
        throw "Permessi per la geolocalizzazione rifiutati.";
    }
  }
}
