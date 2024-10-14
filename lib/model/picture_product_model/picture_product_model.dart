import 'package:freezed_annotation/freezed_annotation.dart';

part 'picture_product_model.freezed.dart';
part 'picture_product_model.g.dart';

@freezed
class PictureProductModel with _$PictureProductModel {
  factory PictureProductModel({
    String? name,
    String? url,
    String? path,
  }) = _PictureProductModel;

  factory PictureProductModel.fromJson(Map<String, dynamic> json) => _$PictureProductModelFromJson(json);
}
