// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_info_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserInfoModel _$UserInfoModelFromJson(Map<String, dynamic> json) {
  return _UserInfoModel.fromJson(json);
}

/// @nodoc
mixin _$UserInfoModel {
  String? get id => throw _privateConstructorUsedError;
  String? get firstname => throw _privateConstructorUsedError;
  String? get lastname => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get profilImage => throw _privateConstructorUsedError;
  String? get shopName => throw _privateConstructorUsedError;
  @LocationConverter()
  LocationModelNew? get location => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserInfoModelCopyWith<UserInfoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserInfoModelCopyWith<$Res> {
  factory $UserInfoModelCopyWith(
          UserInfoModel value, $Res Function(UserInfoModel) then) =
      _$UserInfoModelCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String? firstname,
      String? lastname,
      String? email,
      String? profilImage,
      String? shopName,
      @LocationConverter() LocationModelNew? location});

  $LocationModelNewCopyWith<$Res>? get location;
}

/// @nodoc
class _$UserInfoModelCopyWithImpl<$Res>
    implements $UserInfoModelCopyWith<$Res> {
  _$UserInfoModelCopyWithImpl(this._value, this._then);

  final UserInfoModel _value;
  // ignore: unused_field
  final $Res Function(UserInfoModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? firstname = freezed,
    Object? lastname = freezed,
    Object? email = freezed,
    Object? profilImage = freezed,
    Object? shopName = freezed,
    Object? location = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      firstname: firstname == freezed
          ? _value.firstname
          : firstname // ignore: cast_nullable_to_non_nullable
              as String?,
      lastname: lastname == freezed
          ? _value.lastname
          : lastname // ignore: cast_nullable_to_non_nullable
              as String?,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      profilImage: profilImage == freezed
          ? _value.profilImage
          : profilImage // ignore: cast_nullable_to_non_nullable
              as String?,
      shopName: shopName == freezed
          ? _value.shopName
          : shopName // ignore: cast_nullable_to_non_nullable
              as String?,
      location: location == freezed
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LocationModelNew?,
    ));
  }

  @override
  $LocationModelNewCopyWith<$Res>? get location {
    if (_value.location == null) {
      return null;
    }

    return $LocationModelNewCopyWith<$Res>(_value.location!, (value) {
      return _then(_value.copyWith(location: value));
    });
  }
}

/// @nodoc
abstract class _$$_UserInfoModelCopyWith<$Res>
    implements $UserInfoModelCopyWith<$Res> {
  factory _$$_UserInfoModelCopyWith(
          _$_UserInfoModel value, $Res Function(_$_UserInfoModel) then) =
      __$$_UserInfoModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String? firstname,
      String? lastname,
      String? email,
      String? profilImage,
      String? shopName,
      @LocationConverter() LocationModelNew? location});

  @override
  $LocationModelNewCopyWith<$Res>? get location;
}

/// @nodoc
class __$$_UserInfoModelCopyWithImpl<$Res>
    extends _$UserInfoModelCopyWithImpl<$Res>
    implements _$$_UserInfoModelCopyWith<$Res> {
  __$$_UserInfoModelCopyWithImpl(
      _$_UserInfoModel _value, $Res Function(_$_UserInfoModel) _then)
      : super(_value, (v) => _then(v as _$_UserInfoModel));

  @override
  _$_UserInfoModel get _value => super._value as _$_UserInfoModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? firstname = freezed,
    Object? lastname = freezed,
    Object? email = freezed,
    Object? profilImage = freezed,
    Object? shopName = freezed,
    Object? location = freezed,
  }) {
    return _then(_$_UserInfoModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      firstname: firstname == freezed
          ? _value.firstname
          : firstname // ignore: cast_nullable_to_non_nullable
              as String?,
      lastname: lastname == freezed
          ? _value.lastname
          : lastname // ignore: cast_nullable_to_non_nullable
              as String?,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      profilImage: profilImage == freezed
          ? _value.profilImage
          : profilImage // ignore: cast_nullable_to_non_nullable
              as String?,
      shopName: shopName == freezed
          ? _value.shopName
          : shopName // ignore: cast_nullable_to_non_nullable
              as String?,
      location: location == freezed
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LocationModelNew?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserInfoModel implements _UserInfoModel {
  _$_UserInfoModel(
      {this.id,
      this.firstname,
      this.lastname,
      this.email,
      this.profilImage,
      this.shopName,
      @LocationConverter() this.location});

  factory _$_UserInfoModel.fromJson(Map<String, dynamic> json) =>
      _$$_UserInfoModelFromJson(json);

  @override
  final String? id;
  @override
  final String? firstname;
  @override
  final String? lastname;
  @override
  final String? email;
  @override
  final String? profilImage;
  @override
  final String? shopName;
  @override
  @LocationConverter()
  final LocationModelNew? location;

  @override
  String toString() {
    return 'UserInfoModel(id: $id, firstname: $firstname, lastname: $lastname, email: $email, profilImage: $profilImage, shopName: $shopName, location: $location)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserInfoModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.firstname, firstname) &&
            const DeepCollectionEquality().equals(other.lastname, lastname) &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality()
                .equals(other.profilImage, profilImage) &&
            const DeepCollectionEquality().equals(other.shopName, shopName) &&
            const DeepCollectionEquality().equals(other.location, location));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(firstname),
      const DeepCollectionEquality().hash(lastname),
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(profilImage),
      const DeepCollectionEquality().hash(shopName),
      const DeepCollectionEquality().hash(location));

  @JsonKey(ignore: true)
  @override
  _$$_UserInfoModelCopyWith<_$_UserInfoModel> get copyWith =>
      __$$_UserInfoModelCopyWithImpl<_$_UserInfoModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserInfoModelToJson(
      this,
    );
  }
}

abstract class _UserInfoModel implements UserInfoModel {
  factory _UserInfoModel(
          {final String? id,
          final String? firstname,
          final String? lastname,
          final String? email,
          final String? profilImage,
          final String? shopName,
          @LocationConverter() final LocationModelNew? location}) =
      _$_UserInfoModel;

  factory _UserInfoModel.fromJson(Map<String, dynamic> json) =
      _$_UserInfoModel.fromJson;

  @override
  String? get id;
  @override
  String? get firstname;
  @override
  String? get lastname;
  @override
  String? get email;
  @override
  String? get profilImage;
  @override
  String? get shopName;
  @override
  @LocationConverter()
  LocationModelNew? get location;
  @override
  @JsonKey(ignore: true)
  _$$_UserInfoModelCopyWith<_$_UserInfoModel> get copyWith =>
      throw _privateConstructorUsedError;
}
