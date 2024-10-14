// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'picturemodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PictureModel _$$_PictureModelFromJson(Map<String, dynamic> json) =>
    _$_PictureModel(
      id: json['id'] as String?,
      ownerId: json['ownerId'] as String?,
      pictureUrl: json['pictureUrl'] as String?,
      description: json['description'] as String?,
      premium: json['premium'] as bool?,
      playBackId: json['playBackId'] as String?,
      assetId: json['assetId'] as String?,
      mediaType: $enumDecodeNullable(_$FileTypeEnumMap, json['mediaType']) ??
          FileType.image,
      createdAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['createdAt'], const TimestampConverter().fromJson),
    );

Map<String, dynamic> _$$_PictureModelToJson(_$_PictureModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ownerId': instance.ownerId,
      'pictureUrl': instance.pictureUrl,
      'description': instance.description,
      'premium': instance.premium,
      'playBackId': instance.playBackId,
      'assetId': instance.assetId,
      'mediaType': _$FileTypeEnumMap[instance.mediaType],
      'createdAt': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.createdAt, const TimestampConverter().toJson),
    };

const _$FileTypeEnumMap = {
  FileType.image: 'image',
  FileType.video: 'video',
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
