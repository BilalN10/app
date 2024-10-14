import 'package:findyourdresse_app/model/_convertor/location_converter.dart';
import 'package:findyourdresse_app/model/user_model_fyd/user_model_fyd.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../location_model_new/location_model_new.dart';

part 'user_info_model.freezed.dart';
part 'user_info_model.g.dart';

@freezed
class UserInfoModel with _$UserInfoModel {
  factory UserInfoModel({
    String? id,
    String? firstname,
    String? lastname,
    String? email,
    String? profilImage,
    String? shopName,
    @LocationConverter() LocationModelNew? location,
  }) = _UserInfoModel;

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => _$UserInfoModelFromJson(json);

  factory UserInfoModel.fromUserFydModel(UserModelFyd userModelFyd) {
    return UserInfoModel(
      id: userModelFyd.id,
      firstname: userModelFyd.firstname,
      lastname: userModelFyd.lastname,
      email: userModelFyd.email,
      profilImage: userModelFyd.profilImage,
      shopName: userModelFyd.shopNickname,
      location: userModelFyd.location,
    );
  }
}
