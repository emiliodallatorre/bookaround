import 'package:bookaround/models/place_model.dart';

class LocationHelper {
  static Map<String, dynamic>? locationToJson(PlaceModel? location) => location != null ? location.toJson() : null;
}
