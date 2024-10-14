import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';

import '../config/theme.dart';

Widget searchBar(String title, String asset, Color color, {double? radius}) {
  return Container(
    decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(radius ?? 0)),
    padding: EdgeInsets.symmetric(vertical: formatHeight(15), horizontal: formatWidth(17)),
    height: formatHeight(50),
    child: Row(
      children: [
        SvgPicture.asset(
          asset,
          height: 30,
        ),
        sw(10),
        Text(title, style: AppThemeStyle.hintStyle)
      ],
    ),
  );
}
