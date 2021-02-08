import 'package:bookaround/models/location_model.dart';

class LocationHelper {
  static Map<String, dynamic> locationToJson(LocationModel location) => location.toJson();
}
