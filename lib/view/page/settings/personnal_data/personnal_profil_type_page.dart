import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:findyourdresse_app/model/_enum/profil_type_enum.dart';
import 'package:findyourdresse_app/model/user_model_fyd/user_model_fyd.dart';
import 'package:findyourdresse_app/provider/profil_type.dart';
import 'package:findyourdresse_app/utils/utils.dart';
import 'package:findyourdresse_app/view/page/settings/personnal_data/personnal_data_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';

import '../../../../config/theme.dart';

class PersonnalProfilTypePage extends ConsumerStatefulWidget {
  const PersonnalProfilTypePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PersonnalProfilTypePageState();
}

final profilControllerProvider = Provider<PageController>((ref) {
  return PageController(initialPage: 0);
});

class _PersonnalProfilTypePageState extends ConsumerState<PersonnalProfilTypePage> {
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    execAfterBuild(() {
      ref
          .read(profilTypeProvider)
          .setProfilType(ProfilType.value.toEnum((ref.read(userChangeNotifierProvider).userData as UserModelFyd).type));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.only(bottom: formatHeight(50)),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Transform.translate(
                offset: Offset(-formatHeight(10), 0),
                child: CTA.back(
                  onTap: () {
                    ref.read(profilTypeProvider).clear();
                    AutoRouter.of(context).navigateBack();
                  },
                ),
              ),
              Expanded(
                child: Text(
                  'complete-profil.title-1'.tr(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: sp(17),
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          sh(33),
          _profilCard(ProfilType.particular, 'assets/images/particulier.jpg'),
          sh(7),
          _profilCard(ProfilType.creator, "assets/images/fashionD.jpg"),
          sh(7),
          _profilCard(ProfilType.model, "assets/images/model.jpg"),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CTA.primary(
                  isEnabled: ref.watch(profilTypeProvider).type ==
                          ProfilType.value.toEnum((ref.watch(userChangeNotifierProvider).userData as UserModelFyd).type)
                      ? false
                      : true,
                  textButton: 'utils.save'.tr(),
                  onTap: () {
                    if ((ref.watch(userChangeNotifierProvider).userData as UserModelFyd).premium == true) {
                      Utils.notifRed(
                          context, 'banner.red-profil-type-title'.tr(), 'banner.red-profil-type-subtitle'.tr());
                      // AutoRouter.of(context).navigateNamed("/dashboard/personnaldata");

                      // if (ref.watch(profilTypeProvider).type != null) {
                      //   ref.watch(profilControllerProvider).jumpToPage(1);
                      // } else {
                      //   Utils.notifRed(context, 'Type de profil', 'Merci de renseigner un type de profil');
                      // }
                    } else {
                      AutoRouter.of(context).navigateNamed("/dashboard/personnalprofil/data");

                      // return PersonnalProfilTypePageTwo();
                      // FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
                      //   'type': ref.watch(profilTypeProvider).type.toString(),
                      // });
                    }
                  },
                ),
                sh(55)
              ],
            ),
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
              borderRadius: BorderRadius.circular(7.r),
              child: Image.asset(
                img,
                height: formatHeight(103),
                width: formatWidth(96),
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
