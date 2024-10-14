import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';

class LocationConverter implements JsonConverter<LocationModel, Map<String, dynamic>> {
  const LocationConverter();

  @override
  LocationModel fromJson(Map<String, dynamic> toJson) {
    // type data was already set (e.g. because we serialized it ourselves)
    // if (toJson == null) return null;
    return LocationModel.fromMap(toJson);

    // you need to find some condition to know which type it is. e.g. check the presence of some field in the jso
  }

  @override
  Map<String, dynamic> toJson(LocationModel data) => data.toMap();
}
