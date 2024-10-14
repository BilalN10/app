import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findyourdresse_app/model/_convertor/timestamp_converter.dart';
import 'package:findyourdresse_app/model/product_media/product_media.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'productmodel.freezed.dart';
part 'productmodel.g.dart';

@unfreezed
class ProductModel with _$ProductModel {
  factory ProductModel({
    String? id,
    List<String>? type,
    List<String>? size,
    String? ownerId,
    String? name,
    String? description,
    String? price,
    String? city,
    @Default([]) List<ProductMedia>? productMedias,
    @TimestampConverter() DateTime? createdAt,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);
}
