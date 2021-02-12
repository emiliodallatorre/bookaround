import 'package:bookaround/models/settings_model.dart';
import 'package:bookaround/resources/provider/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool proximity = Provider.of<SettingsModel>(context).proximitySearchEnabled;
    if (proximity ?? false) Provider.of<LocationProvider>(context, listen: false).isOk();

    return Consumer<LocationProvider>(
      builder: (BuildContext context, LocationProvider locationProvider, Widget child) => ListView(
        children: [
          if ((proximity ?? false) && locationProvider.wasOk)
            AspectRatio(
              aspectRatio: 4 / 3,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(locationProvider.lastKnownLocation.latitude, locationProvider.lastKnownLocation.longitude),
                  zoom: 10.0,
                ),
                onCameraMove: (CameraPosition newCameraPosition) {
                  debugPrint(newCameraPosition.zoom.toString());
                },
              ),
            ),
        ],
      ),
    );
  }
}
