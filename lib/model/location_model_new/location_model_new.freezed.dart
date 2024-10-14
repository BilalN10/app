// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'location_model_new.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LocationModelNew _$LocationModelNewFromJson(Map<String, dynamic> json) {
  return _LocationModelNew.fromJson(json);
}

/// @nodoc
mixin _$LocationModelNew {
  String? get address => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get region => throw _privateConstructorUsedError;
  String? get postalCode => throw _privateConstructorUsedError;
  String? get countryISOCode => throw _privateConstructorUsedError;
  String? get mainText => throw _privateConstructorUsedError;
  String? get secondaryText => throw _privateConstructorUsedError;
  String? get formattedText => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LocationModelNewCopyWith<LocationModelNew> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationModelNewCopyWith<$Res> {
  factory $LocationModelNewCopyWith(
          LocationModelNew value, $Res Function(LocationModelNew) then) =
      _$LocationModelNewCopyWithImpl<$Res>;
  $Res call(
      {String? address,
      String? city,
      String? region,
      String? postalCode,
      String? countryISOCode,
      String? mainText,
      String? secondaryText,
      String? formattedText});
}

/// @nodoc
class _$LocationModelNewCopyWithImpl<$Res>
    implements $LocationModelNewCopyWith<$Res> {
  _$LocationModelNewCopyWithImpl(this._value, this._then);

  final LocationModelNew _value;
  // ignore: unused_field
  final $Res Function(LocationModelNew) _then;

  @override
  $Res call({
    Object? address = freezed,
    Object? city = freezed,
    Object? region = freezed,
    Object? postalCode = freezed,
    Object? countryISOCode = freezed,
    Object? mainText = freezed,
    Object? secondaryText = freezed,
    Object? formattedText = freezed,
  }) {
    return _then(_value.copyWith(
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      city: city == freezed
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      region: region == freezed
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String?,
      postalCode: postalCode == freezed
          ? _value.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String?,
      countryISOCode: countryISOCode == freezed
          ? _value.countryISOCode
          : countryISOCode // ignore: cast_nullable_to_non_nullable
              as String?,
      mainText: mainText == freezed
          ? _value.mainText
          : mainText // ignore: cast_nullable_to_non_nullable
              as String?,
      secondaryText: secondaryText == freezed
          ? _value.secondaryText
          : secondaryText // ignore: cast_nullable_to_non_nullable
              as String?,
      formattedText: formattedText == freezed
          ? _value.formattedText
          : formattedText // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_LocationModelNewCopyWith<$Res>
    implements $LocationModelNewCopyWith<$Res> {
  factory _$$_LocationModelNewCopyWith(
          _$_LocationModelNew value, $Res Function(_$_LocationModelNew) then) =
      __$$_LocationModelNewCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? address,
      String? city,
      String? region,
      String? postalCode,
      String? countryISOCode,
      String? mainText,
      String? secondaryText,
      String? formattedText});
}

/// @nodoc
class __$$_LocationModelNewCopyWithImpl<$Res>
    extends _$LocationModelNewCopyWithImpl<$Res>
    implements _$$_LocationModelNewCopyWith<$Res> {
  __$$_LocationModelNewCopyWithImpl(
      _$_LocationModelNew _value, $Res Function(_$_LocationModelNew) _then)
      : super(_value, (v) => _then(v as _$_LocationModelNew));

  @override
  _$_LocationModelNew get _value => super._value as _$_LocationModelNew;

  @override
  $Res call({
    Object? address = freezed,
    Object? city = freezed,
    Object? region = freezed,
    Object? postalCode = freezed,
    Object? countryISOCode = freezed,
    Object? mainText = freezed,
    Object? secondaryText = freezed,
    Object? formattedText = freezed,
  }) {
    return _then(_$_LocationModelNew(
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      city: city == freezed
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      region: region == freezed
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String?,
      postalCode: postalCode == freezed
          ? _value.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String?,
      countryISOCode: countryISOCode == freezed
          ? _value.countryISOCode
          : countryISOCode // ignore: cast_nullable_to_non_nullable
              as String?,
      mainText: mainText == freezed
          ? _value.mainText
          : mainText // ignore: cast_nullable_to_non_nullable
              as String?,
      secondaryText: secondaryText == freezed
          ? _value.secondaryText
          : secondaryText // ignore: cast_nullable_to_non_nullable
              as String?,
      formattedText: formattedText == freezed
          ? _value.formattedText
          : formattedText // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LocationModelNew implements _LocationModelNew {
  _$_LocationModelNew(
      {this.address,
      this.city,
      this.region,
      this.postalCode,
      this.countryISOCode,
      this.mainText,
      this.secondaryText,
      this.formattedText});

  factory _$_LocationModelNew.fromJson(Map<String, dynamic> json) =>
      _$$_LocationModelNewFromJson(json);

  @override
  final String? address;
  @override
  final String? city;
  @override
  final String? region;
  @override
  final String? postalCode;
  @override
  final String? countryISOCode;
  @override
  final String? mainText;
  @override
  final String? secondaryText;
  @override
  final String? formattedText;

  @override
  String toString() {
    return 'LocationModelNew(address: $address, city: $city, region: $region, postalCode: $postalCode, countryISOCode: $countryISOCode, mainText: $mainText, secondaryText: $secondaryText, formattedText: $formattedText)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LocationModelNew &&
            const DeepCollectionEquality().equals(other.address, address) &&
            const DeepCollectionEquality().equals(other.city, city) &&
            const DeepCollectionEquality().equals(other.region, region) &&
            const DeepCollectionEquality()
                .equals(other.postalCode, postalCode) &&
            const DeepCollectionEquality()
                .equals(other.countryISOCode, countryISOCode) &&
            const DeepCollectionEquality().equals(other.mainText, mainText) &&
            const DeepCollectionEquality()
                .equals(other.secondaryText, secondaryText) &&
            const DeepCollectionEquality()
                .equals(other.formattedText, formattedText));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(address),
      const DeepCollectionEquality().hash(city),
      const DeepCollectionEquality().hash(region),
      const DeepCollectionEquality().hash(postalCode),
      const DeepCollectionEquality().hash(countryISOCode),
      const DeepCollectionEquality().hash(mainText),
      const DeepCollectionEquality().hash(secondaryText),
      const DeepCollectionEquality().hash(formattedText));

  @JsonKey(ignore: true)
  @override
  _$$_LocationModelNewCopyWith<_$_LocationModelNew> get copyWith =>
      __$$_LocationModelNewCopyWithImpl<_$_LocationModelNew>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LocationModelNewToJson(
      this,
    );
  }
}

abstract class _LocationModelNew implements LocationModelNew {
  factory _LocationModelNew(
      {final String? address,
      final String? city,
      final String? region,
      final String? postalCode,
      final String? countryISOCode,
      final String? mainText,
      final String? secondaryText,
      final String? formattedText}) = _$_LocationModelNew;

  factory _LocationModelNew.fromJson(Map<String, dynamic> json) =
      _$_LocationModelNew.fromJson;

  @override
  String? get address;
  @override
  String? get city;
  @override
  String? get region;
  @override
  String? get postalCode;
  @override
  String? get countryISOCode;
  @override
  String? get mainText;
  @override
  String? get secondaryText;
  @override
  String? get formattedText;
  @override
  @JsonKey(ignore: true)
  _$$_LocationModelNewCopyWith<_$_LocationModelNew> get copyWith =>
      throw _privateConstructorUsedError;
}
