// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_model_new.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LocationModelNew _$$_LocationModelNewFromJson(Map<String, dynamic> json) =>
    _$_LocationModelNew(
      address: json['address'] as String?,
      city: json['city'] as String?,
      region: json['region'] as String?,
      postalCode: json['postalCode'] as String?,
      countryISOCode: json['countryISOCode'] as String?,
      mainText: json['mainText'] as String?,
      secondaryText: json['secondaryText'] as String?,
      formattedText: json['formattedText'] as String?,
    );

Map<String, dynamic> _$$_LocationModelNewToJson(_$_LocationModelNew instance) =>
    <String, dynamic>{
      'address': instance.address,
      'city': instance.city,
      'region': instance.region,
      'postalCode': instance.postalCode,
      'countryISOCode': instance.countryISOCode,
      'mainText': instance.mainText,
      'secondaryText': instance.secondaryText,
      'formattedText': instance.formattedText,
    };
