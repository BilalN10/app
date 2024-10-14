// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'picture_product_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PictureProductModel _$PictureProductModelFromJson(Map<String, dynamic> json) {
  return _PictureProductModel.fromJson(json);
}

/// @nodoc
mixin _$PictureProductModel {
  String? get name => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  String? get path => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PictureProductModelCopyWith<PictureProductModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PictureProductModelCopyWith<$Res> {
  factory $PictureProductModelCopyWith(
          PictureProductModel value, $Res Function(PictureProductModel) then) =
      _$PictureProductModelCopyWithImpl<$Res>;
  $Res call({String? name, String? url, String? path});
}

/// @nodoc
class _$PictureProductModelCopyWithImpl<$Res>
    implements $PictureProductModelCopyWith<$Res> {
  _$PictureProductModelCopyWithImpl(this._value, this._then);

  final PictureProductModel _value;
  // ignore: unused_field
  final $Res Function(PictureProductModel) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? url = freezed,
    Object? path = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_PictureProductModelCopyWith<$Res>
    implements $PictureProductModelCopyWith<$Res> {
  factory _$$_PictureProductModelCopyWith(_$_PictureProductModel value,
          $Res Function(_$_PictureProductModel) then) =
      __$$_PictureProductModelCopyWithImpl<$Res>;
  @override
  $Res call({String? name, String? url, String? path});
}

/// @nodoc
class __$$_PictureProductModelCopyWithImpl<$Res>
    extends _$PictureProductModelCopyWithImpl<$Res>
    implements _$$_PictureProductModelCopyWith<$Res> {
  __$$_PictureProductModelCopyWithImpl(_$_PictureProductModel _value,
      $Res Function(_$_PictureProductModel) _then)
      : super(_value, (v) => _then(v as _$_PictureProductModel));

  @override
  _$_PictureProductModel get _value => super._value as _$_PictureProductModel;

  @override
  $Res call({
    Object? name = freezed,
    Object? url = freezed,
    Object? path = freezed,
  }) {
    return _then(_$_PictureProductModel(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PictureProductModel implements _PictureProductModel {
  _$_PictureProductModel({this.name, this.url, this.path});

  factory _$_PictureProductModel.fromJson(Map<String, dynamic> json) =>
      _$$_PictureProductModelFromJson(json);

  @override
  final String? name;
  @override
  final String? url;
  @override
  final String? path;

  @override
  String toString() {
    return 'PictureProductModel(name: $name, url: $url, path: $path)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PictureProductModel &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.url, url) &&
            const DeepCollectionEquality().equals(other.path, path));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(url),
      const DeepCollectionEquality().hash(path));

  @JsonKey(ignore: true)
  @override
  _$$_PictureProductModelCopyWith<_$_PictureProductModel> get copyWith =>
      __$$_PictureProductModelCopyWithImpl<_$_PictureProductModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PictureProductModelToJson(
      this,
    );
  }
}

abstract class _PictureProductModel implements PictureProductModel {
  factory _PictureProductModel(
      {final String? name,
      final String? url,
      final String? path}) = _$_PictureProductModel;

  factory _PictureProductModel.fromJson(Map<String, dynamic> json) =
      _$_PictureProductModel.fromJson;

  @override
  String? get name;
  @override
  String? get url;
  @override
  String? get path;
  @override
  @JsonKey(ignore: true)
  _$$_PictureProductModelCopyWith<_$_PictureProductModel> get copyWith =>
      throw _privateConstructorUsedError;
}
