import 'package:easy_localization/easy_localization.dart';

enum Morphology {
  mA,
  mV,
  mX,
  mH,
  mI,
  mO,
}

extension MorphologyExtension on Morphology {
  String get label {
    switch (this) {
      case Morphology.mA:
        return 'field.morphology-a'.tr();
      case Morphology.mV:
        return 'field.morphology-v'.tr();
      case Morphology.mX:
        return 'field.morphology-x'.tr();
      case Morphology.mH:
        return 'field.morphology-h'.tr();
      case Morphology.mI:
        return 'field.morphology-i'.tr();
      case Morphology.mO:
        return 'field.morphology-o'.tr();
    }
  }
}

enum FileType { image, video }

/// Report
/// Report type
enum ReportType { user, picture, product }

extension ReportTypeExtension on ReportType {
  String get label {
    switch (this) {
      case ReportType.user:
        return 'field.report-user'.tr();
      case ReportType.picture:
        return 'field.report-picture'.tr();
      case ReportType.product:
        return 'field.report-product'.tr();
    }
  }
}

/// report more about User
enum ReportMore { fakeUser, spam, nudity, violence, harassment, ilegalContent, other }

extension ReportMoreExtension on ReportMore {
  String get label {
    switch (this) {
      case ReportMore.fakeUser:
        return 'field.report-fake-user'.tr();
      case ReportMore.spam:
        return 'field.report-spam'.tr();
      case ReportMore.nudity:
        return 'field.report-nudity'.tr();
      case ReportMore.violence:
        return 'field.report-violence'.tr();
      case ReportMore.harassment:
        return 'field.report-harassment'.tr();
      case ReportMore.ilegalContent:
        return 'field.report-ilegalContent'.tr();
      case ReportMore.other:
        return 'field.report-other'.tr();
    }
  }
}

// Report more about picture
