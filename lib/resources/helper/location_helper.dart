/*
 * Created by Emilio Dalla Torre on 20/05/21, 10:07
 * Copyright (c) 2021. All rights reserved.
 * Last modified 19/03/21, 19:09
 */

import 'package:bookaround/models/place_model.dart';

class LocationHelper {
  static Map<String, dynamic>? locationToJson(PlaceModel? location) => location != null ? location.toJson() : null;
}
