/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:13.
 * Copyright (c) 2021. All rights reserved.
 * Last modified 20/05/21, 10:07.
 */

import 'package:bookaround/models/place_model.dart';

class LocationHelper {
  static Map<String, dynamic>? locationToJson(PlaceModel? location) => location != null ? location.toJson() : null;
}
