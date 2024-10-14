import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_model_new.freezed.dart';
part 'location_model_new.g.dart';

@freezed
class LocationModelNew with _$LocationModelNew {
  factory LocationModelNew({
    String? address,
    String? city,
    String? region,
    String? postalCode,
    String? countryISOCode,
    String? mainText,
    String? secondaryText,
    String? formattedText,
    //GeoPoint? geopoint,
    //GeoFirePoint? location,
  }) = _LocationModelNew;

  factory LocationModelNew.fromJson(Map<String, dynamic> json) => _$LocationModelNewFromJson(json);
}
