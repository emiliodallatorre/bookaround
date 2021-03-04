import 'package:google_maps_webservice/places.dart';
import 'package:json_annotation/json_annotation.dart';

part 'place_model.g.dart';

@JsonSerializable()
class PlaceModel {
  final String id;
  final String description;
  final String placeId;
  final String placeReference;

  PlaceModel({
    this.id,
    this.description,
    this.placeId,
    this.placeReference,
  });

  @override
  String toString() => "Libro $id.";

  factory PlaceModel.fromPrediction(Prediction prediction) => PlaceModel(
        id: prediction.id,
        description: prediction.description,
        placeId: prediction.placeId,
        placeReference: prediction.reference,
      );

  factory PlaceModel.fromJson(Map<String, dynamic> parsedJson) => _$PlaceModelFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$PlaceModelToJson(this);
}
