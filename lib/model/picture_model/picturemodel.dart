import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findyourdresse_app/model/_convertor/timestamp_converter.dart';
import 'package:findyourdresse_app/utils/enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'picturemodel.freezed.dart';
part 'picturemodel.g.dart';

@freezed
class PictureModel with _$PictureModel {
  factory PictureModel({
    String? id,
    String? ownerId,
    String? pictureUrl,
    String? description,
    bool? premium,
    String? playBackId,
    String? assetId,
    @Default(FileType.image) FileType? mediaType,
    @TimestampConverter() DateTime? createdAt,
  }) = _PictureModel;

  factory PictureModel.fromJson(Map<String, dynamic> json) => _$PictureModelFromJson(json);
}
