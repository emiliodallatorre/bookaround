import 'dart:math';

import 'package:bookaround/bloc/book_bloc.dart';
import 'package:bookaround/generated/l10n.dart';
import 'package:bookaround/interface/widget/book_list_element.dart';
import 'package:bookaround/interface/widget/centered_text.dart';
import 'package:bookaround/map_styles.dart';
import 'package:bookaround/models/book_model.dart';
import 'package:bookaround/models/settings_model.dart';
import 'package:bookaround/models/user_model.dart';
import 'package:bookaround/resources/provider/location_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    searchBookBloc.getUserBooks(Provider.of<UserModel>(context, listen: false).uid, BookType.LOOKING);

    return RefreshIndicator(
      onRefresh: () => searchBookBloc.getUserBooks(Provider.of<UserModel>(context, listen: false).uid, BookType.LOOKING),
      child: StreamBuilder<List<BookModel>>(
        stream: searchBookBloc.books,
        builder: (BuildContext context, AsyncSnapshot<List<BookModel>> booksSnapshot) {
          if (booksSnapshot.hasData) {
            if (booksSnapshot.data.isNotEmpty) {
              bool proximity = Provider.of<SettingsModel>(context, listen: false).proximitySearchEnabled;
              if (proximity ?? false) Provider.of<LocationProvider>(context, listen: false).isOk();

              Map<String, HSVColor> bookColors = <String, HSVColor>{};
              booksSnapshot.data.forEach((element) => bookColors[element.isbn] = HSVColor.fromAHSV(1.0, Random().nextDouble() * 360.0, 1.0, 1.0));
              debugPrint("Assegnati i colori randomici.");

              debugPrint(bookColors.toString());

              Provider.of<LocationProvider>(context, listen: false).getNearbyBooks(booksSnapshot.data.map((e) => e.isbn).toList());

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
                                    ?.map(
                                      (e) => Marker(
                                        markerId: MarkerId(e.id),
                                        position: LatLng(e.modelizedLocation.latitude, e.modelizedLocation.longitude),
                                        icon: BitmapDescriptor.defaultMarkerWithHue(bookColors[e.isbn].hue),
                                      ),
                                    )
                                    ?.toSet() ??
                                <Marker>[].toSet(),
                            onMapCreated: (GoogleMapController controller) {
                              if (Theme.of(context).brightness == Brightness.light)
                                controller.setMapStyle(MapStyles.lightMap);
                              else
                                controller.setMapStyle(MapStyles.darkMap);
                            },
                            gestureRecognizers: Set()..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer())),
                          ),
                        ),
                      ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: booksSnapshot.data.length,
                      itemBuilder: (BuildContext context, int index) => BookListElement(
                        book: booksSnapshot.data.elementAt(index),
                        color: bookColors[booksSnapshot.data.elementAt(index).isbn].toColor(),
                      ),
                    ),
                  ],
                ),
              );
            } else
              return CenteredText(label: S.current.noSearchBooks);
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
