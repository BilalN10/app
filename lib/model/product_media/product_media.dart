import 'package:findyourdresse_app/utils/enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_media.freezed.dart';
part 'product_media.g.dart';

@freezed
class ProductMedia with _$ProductMedia {
  factory ProductMedia({
    required FileType fileType,
    String? url,
    String? playBackId,
    String? assetId,
  }) = _ProductMedia;

  factory ProductMedia.fromJson(Map<String, dynamic> json) => _$ProductMediaFromJson(json);
}
