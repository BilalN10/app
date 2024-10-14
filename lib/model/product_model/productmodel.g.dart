// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ProductModel _$$_ProductModelFromJson(Map<String, dynamic> json) =>
    _$_ProductModel(
      id: json['id'] as String?,
      type: (json['type'] as List<dynamic>?)?.map((e) => e as String).toList(),
      size: (json['size'] as List<dynamic>?)?.map((e) => e as String).toList(),
      ownerId: json['ownerId'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      price: json['price'] as String?,
      city: json['city'] as String?,
      productMedias: (json['productMedias'] as List<dynamic>?)
              ?.map((e) => ProductMedia.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['createdAt'], const TimestampConverter().fromJson),
    );

Map<String, dynamic> _$$_ProductModelToJson(_$_ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'size': instance.size,
      'ownerId': instance.ownerId,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'city': instance.city,
      'productMedias': instance.productMedias?.map((e) => e.toJson()).toList(),
      'createdAt': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.createdAt, const TimestampConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
