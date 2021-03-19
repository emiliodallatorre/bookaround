import 'dart:math';

import 'package:bookaround/bloc/book_bloc.dart';
import 'package:bookaround/generated/l10n.dart';
import 'package:bookaround/interface/screen/book_screen.dart';
import 'package:bookaround/interface/widget/book_list_element.dart';
import 'package:bookaround/interface/widget/centered_text.dart';
import 'package:bookaround/map_styles.dart';
import 'package:bookaround/models/book_model.dart';
import 'package:bookaround/models/user_model.dart';
import 'package:bookaround/resources/provider/location_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    searchBookBloc.getUserBooks(Provider.of<UserModel>(context, listen: false).uid!);

    return RefreshIndicator(
      onRefresh: () => searchBookBloc.getUserBooks(Provider.of<UserModel>(context, listen: false).uid!),
      child: StreamBuilder<List<BookModel>>(
        stream: searchBookBloc.books,
        builder: (BuildContext context, AsyncSnapshot<List<BookModel>> booksSnapshot) {
          if (booksSnapshot.hasData) {
            if (booksSnapshot.data!.isNotEmpty) {
              // Assegna i colori a caso
              final Map<String, HSVColor> bookColors = <String, HSVColor>{};
              booksSnapshot.data!.forEach((element) => bookColors[element.sureIsbn] = HSVColor.fromAHSV(1.0, Random().nextDouble() * 360.0, 1.0, 1.0));

              return Consumer<LocationProvider>(
                builder: (BuildContext context, LocationProvider locationProvider, Widget? child) {
                  if (locationProvider.permissionStatus == null)
                    locationProvider.getPermissionStatus();
                  else if (locationProvider.permissionStatus == PermissionStatus.granted) locationProvider.getLocation();

                  return ListView(
                    children: [
                      if (locationProvider.permissionStatus == PermissionStatus.granted && locationProvider.lastKnownLocation != null)
                        StreamBuilder<List<BookModel>>(
                          stream: searchBookBloc.nearbyBooks,
                          builder: (BuildContext context, AsyncSnapshot<List<BookModel>> nearbyBooksSnapshot) => Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: AspectRatio(
                              aspectRatio: 4 / 3,
                              child: GoogleMap(
                                initialCameraPosition: CameraPosition(
                                  target: locationProvider.lastKnownLocation!,
                                  zoom: 11.0,
                                ),
                                myLocationEnabled: true,
                                myLocationButtonEnabled: true,
                                markers: nearbyBooksSnapshot.data
                                        ?.map(
                                          (BookModel book) => Marker(
                                            markerId: MarkerId(book.id!),
                                            position: LatLng(book.modelizedLocation.latitude, book.modelizedLocation.longitude),
                                            icon: BitmapDescriptor.defaultMarkerWithHue(bookColors[book.sureIsbn]!.hue),
                                            onTap: () async {
                                              await Future.delayed(Duration(milliseconds: 256));
                                              Navigator.of(context).pushNamed(BookScreen.route, arguments: book);
                                            },
                                          ),
                                        )
                                        .toSet() ??
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
                        ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: booksSnapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) => BookListElement(
                          book: booksSnapshot.data!.elementAt(index),
                          color: bookColors[booksSnapshot.data!.elementAt(index).sureIsbn]!.toColor(),
                        ),
                      ),
                    ],
                  );
                },
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
