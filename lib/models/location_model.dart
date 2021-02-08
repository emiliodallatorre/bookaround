import 'package:google_maps_webservice/places.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location_model.g.dart';

@JsonSerializable()
class LocationModel {
  final String id;
  final String description;
  final String placeId;
  final String placeReference;

  LocationModel({
    this.id,
    this.description,
    this.placeId,
    this.placeReference,
  });

  @override
  String toString() => "Libro $id.";

  factory LocationModel.fromPrediction(Prediction prediction) => LocationModel(
        id: prediction.id,
        description: prediction.description,
        placeId: prediction.placeId,
        placeReference: prediction.reference,
      );

  factory LocationModel.fromJson(Map<String, dynamic> parsedJson) => _$LocationModelFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}
