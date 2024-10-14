import 'package:easy_localization/easy_localization.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'mesurements_model.freezed.dart';
part 'mesurements_model.g.dart';

@freezed
class MesurementsModel with _$MesurementsModel {
  factory MesurementsModel({
    String? height,
    String? size,
    String? hips,
    String? bust,
    String? footSize,
    String? clothingSize,
    String? hairColor,
    String? eyeColor,
  }) = _MesurementsModel;

  factory MesurementsModel.fromJson(Map<String, dynamic> json) => _$MesurementsModelFromJson(json);

  static mesurementToDisplay(String key) {
    if (key == "height") return "profil-mesure.height".tr();
    if (key == "size") return "profil-mesure.size".tr();
    if (key == "hips") return "profil-mesure.hips".tr();
    if (key == "bust") return "profil-mesure.bust".tr();
    if (key == "footSize") return "profil-mesure.footSize".tr();
    if (key == "clothingSize") return "profil-mesure.clothingSize".tr();
    if (key == "hairColor") return "profil-mesure.hairColor".tr();
    if (key == "eyeColor") return "profil-mesure.eyeColor".tr();
  }
}
