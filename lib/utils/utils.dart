import 'dart:ui';

import 'package:skeleton_kosmos/skeleton_kosmos.dart';

extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}

class Utils {
  static Future<void> notifGreen(context, title, subtitle) async {
    NotifBanner.showToast(
      context: context,
      fToast: FToast().init(context),
      title: title,
      subTitle: subtitle,
      backgroundColor: const Color(0xFF0ACC73),
    );
  }

  static Future<void> notifRed(context, title, subtitle) async {
    NotifBanner.showToast(
      context: context,
      fToast: FToast().init(context),
      title: title,
      subTitle: subtitle,
      backgroundColor: const Color.fromARGB(255, 204, 10, 10),
    );
  }
}
