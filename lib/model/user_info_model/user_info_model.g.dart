// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserInfoModel _$$_UserInfoModelFromJson(Map<String, dynamic> json) =>
    _$_UserInfoModel(
      id: json['id'] as String?,
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      email: json['email'] as String?,
      profilImage: json['profilImage'] as String?,
      shopName: json['shopName'] as String?,
      location: json['location'] == null
          ? null
          : LocationModelNew.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_UserInfoModelToJson(_$_UserInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'email': instance.email,
      'profilImage': instance.profilImage,
      'shopName': instance.shopName,
      'location': instance.location?.toJson(),
    };
