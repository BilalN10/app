import 'package:easy_localization/easy_localization.dart';

enum ProfilType {
  particular,
  creator,
  model,
  value,
}

extension ProfilTypeExtension on ProfilType {
  String get label {
    switch (this) {
      case ProfilType.particular:
        return "complete-profil.particulier".tr();
      case ProfilType.creator:
        return "complete-profil.creator".tr();
      case ProfilType.model:
        return "complete-profil.model".tr();
      default:
        return '';
    }
  }

  ProfilType toEnum(value) {
    switch (value) {
      case "ProfilType.particular":
        return ProfilType.particular;
      case "ProfilType.creator":
        return ProfilType.creator;
      case "ProfilType.model":
        return ProfilType.model;
      default:
        return ProfilType.model;
    }
  }
}
