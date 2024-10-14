// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ProductMedia _$$_ProductMediaFromJson(Map<String, dynamic> json) =>
    _$_ProductMedia(
      fileType: $enumDecode(_$FileTypeEnumMap, json['fileType']),
      url: json['url'] as String?,
      playBackId: json['playBackId'] as String?,
      assetId: json['assetId'] as String?,
    );

Map<String, dynamic> _$$_ProductMediaToJson(_$_ProductMedia instance) =>
    <String, dynamic>{
      'fileType': _$FileTypeEnumMap[instance.fileType]!,
      'url': instance.url,
      'playBackId': instance.playBackId,
      'assetId': instance.assetId,
    };

const _$FileTypeEnumMap = {
  FileType.image: 'image',
  FileType.video: 'video',
};
