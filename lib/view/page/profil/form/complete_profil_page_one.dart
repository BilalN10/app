import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:findyourdresse_app/config/theme.dart';
import 'package:findyourdresse_app/model/_enum/profil_type_enum.dart';
import 'package:findyourdresse_app/provider/profil_type.dart';
import 'package:findyourdresse_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';

class CompleteProfilPageOne extends ConsumerStatefulWidget {
  final PageController pageController;
  const CompleteProfilPageOne({super.key, required this.pageController});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CompleteProfilPageOneState();
}

class _CompleteProfilPageOneState extends ConsumerState<CompleteProfilPageOne> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: formatHeight(51), horizontal: formatWidth(27)),
      child: Column(
        children: [
          sh(35),
          Text('complete-profil.title-1'.tr(), style: AppThemeStyle.formProfilTitle),
          sh(25),
          _profilCard(ProfilType.particular, 'assets/images/particulier.jpg'),
          sh(7),
          _profilCard(ProfilType.creator, "assets/images/fashionD.jpg"),
          sh(7),
          _profilCard(ProfilType.model, "assets/images/model.jpg"),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CTA.primary(
                textButton: 'utils.next'.tr(),
                onTap: () {
                  if (ref.watch(profilTypeProvider).type != null) {
                   widget.pageController.jumpToPage(1);
                  } else {
                    Utils.notifRed(context, 'Type de profil', 'Merci de renseigner un type de profil');
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _profilCard(ProfilType type, img) {
    return InkWell(
      onTap: () {
        ref.read(profilTypeProvider).setProfilType(type);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: formatHeight(6), horizontal: formatWidth(9)),
        height: formatHeight(110),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.r),
            color: AppColor.backGrey,
            border: type == ref.watch(profilTypeProvider).type
                ? Border.all(color: Colors.black, width: formatWidth(2))
                : null),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.asset(
                img,
                height: formatHeight(103),
                width: formatWidth(96.66),
                fit: BoxFit.cover,
              ),
            ),
            sw(18),
            Text(type.label, style: AppThemeStyle.formCategory)
          ],
        ),
      ),
    );
  }
}
