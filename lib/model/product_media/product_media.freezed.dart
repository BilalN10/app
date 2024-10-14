// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'product_media.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ProductMedia _$ProductMediaFromJson(Map<String, dynamic> json) {
  return _ProductMedia.fromJson(json);
}

/// @nodoc
mixin _$ProductMedia {
  FileType get fileType => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  String? get playBackId => throw _privateConstructorUsedError;
  String? get assetId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductMediaCopyWith<ProductMedia> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductMediaCopyWith<$Res> {
  factory $ProductMediaCopyWith(
          ProductMedia value, $Res Function(ProductMedia) then) =
      _$ProductMediaCopyWithImpl<$Res>;
  $Res call(
      {FileType fileType, String? url, String? playBackId, String? assetId});
}

/// @nodoc
class _$ProductMediaCopyWithImpl<$Res> implements $ProductMediaCopyWith<$Res> {
  _$ProductMediaCopyWithImpl(this._value, this._then);

  final ProductMedia _value;
  // ignore: unused_field
  final $Res Function(ProductMedia) _then;

  @override
  $Res call({
    Object? fileType = freezed,
    Object? url = freezed,
    Object? playBackId = freezed,
    Object? assetId = freezed,
  }) {
    return _then(_value.copyWith(
      fileType: fileType == freezed
          ? _value.fileType
          : fileType // ignore: cast_nullable_to_non_nullable
              as FileType,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      playBackId: playBackId == freezed
          ? _value.playBackId
          : playBackId // ignore: cast_nullable_to_non_nullable
              as String?,
      assetId: assetId == freezed
          ? _value.assetId
          : assetId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_ProductMediaCopyWith<$Res>
    implements $ProductMediaCopyWith<$Res> {
  factory _$$_ProductMediaCopyWith(
          _$_ProductMedia value, $Res Function(_$_ProductMedia) then) =
      __$$_ProductMediaCopyWithImpl<$Res>;
  @override
  $Res call(
      {FileType fileType, String? url, String? playBackId, String? assetId});
}

/// @nodoc
class __$$_ProductMediaCopyWithImpl<$Res>
    extends _$ProductMediaCopyWithImpl<$Res>
    implements _$$_ProductMediaCopyWith<$Res> {
  __$$_ProductMediaCopyWithImpl(
      _$_ProductMedia _value, $Res Function(_$_ProductMedia) _then)
      : super(_value, (v) => _then(v as _$_ProductMedia));

  @override
  _$_ProductMedia get _value => super._value as _$_ProductMedia;

  @override
  $Res call({
    Object? fileType = freezed,
    Object? url = freezed,
    Object? playBackId = freezed,
    Object? assetId = freezed,
  }) {
    return _then(_$_ProductMedia(
      fileType: fileType == freezed
          ? _value.fileType
          : fileType // ignore: cast_nullable_to_non_nullable
              as FileType,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      playBackId: playBackId == freezed
          ? _value.playBackId
          : playBackId // ignore: cast_nullable_to_non_nullable
              as String?,
      assetId: assetId == freezed
          ? _value.assetId
          : assetId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ProductMedia implements _ProductMedia {
  _$_ProductMedia(
      {required this.fileType, this.url, this.playBackId, this.assetId});

  factory _$_ProductMedia.fromJson(Map<String, dynamic> json) =>
      _$$_ProductMediaFromJson(json);

  @override
  final FileType fileType;
  @override
  final String? url;
  @override
  final String? playBackId;
  @override
  final String? assetId;

  @override
  String toString() {
    return 'ProductMedia(fileType: $fileType, url: $url, playBackId: $playBackId, assetId: $assetId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProductMedia &&
            const DeepCollectionEquality().equals(other.fileType, fileType) &&
            const DeepCollectionEquality().equals(other.url, url) &&
            const DeepCollectionEquality()
                .equals(other.playBackId, playBackId) &&
            const DeepCollectionEquality().equals(other.assetId, assetId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(fileType),
      const DeepCollectionEquality().hash(url),
      const DeepCollectionEquality().hash(playBackId),
      const DeepCollectionEquality().hash(assetId));

  @JsonKey(ignore: true)
  @override
  _$$_ProductMediaCopyWith<_$_ProductMedia> get copyWith =>
      __$$_ProductMediaCopyWithImpl<_$_ProductMedia>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProductMediaToJson(
      this,
    );
  }
}

abstract class _ProductMedia implements ProductMedia {
  factory _ProductMedia(
      {required final FileType fileType,
      final String? url,
      final String? playBackId,
      final String? assetId}) = _$_ProductMedia;

  factory _ProductMedia.fromJson(Map<String, dynamic> json) =
      _$_ProductMedia.fromJson;

  @override
  FileType get fileType;
  @override
  String? get url;
  @override
  String? get playBackId;
  @override
  String? get assetId;
  @override
  @JsonKey(ignore: true)
  _$$_ProductMediaCopyWith<_$_ProductMedia> get copyWith =>
      throw _privateConstructorUsedError;
}
