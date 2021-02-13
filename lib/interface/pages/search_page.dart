import 'package:bookaround/interface/widget/book_list_element.dart';
import 'package:bookaround/map_styles.dart';
import 'package:bookaround/models/settings_model.dart';
import 'package:bookaround/resources/provider/location_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(locationProvider.lastKnownLocation.latitude, locationProvider.lastKnownLocation.longitude),
                      zoom: 11.0,
                    ),
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    markers: locationProvider.nearbyBooks
                        ?.map((e) => Marker(markerId: MarkerId(e.id), position: LatLng(e.modelizedLocation.latitude, e.modelizedLocation.longitude)))
                        ?.toSet(),
                    onMapCreated: (GoogleMapController controller) {
                      if (Theme.of(context).brightness == Brightness.light)
                        controller.setMapStyle(MapStyles.lightMap);
                      else
                        controller.setMapStyle(MapStyles.darkMap);
                    },
                    gestureRecognizers: Set()..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))),
              ),
            ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: locationProvider.nearbyBooks?.length ?? 0,
            itemBuilder: (BuildContext context, int index) => BookListElement(book: locationProvider.nearbyBooks.elementAt(index)),
          ),
        ],
      ),
    );
  }
}
