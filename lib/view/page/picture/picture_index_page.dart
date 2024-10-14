import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:findyourdresse_app/config/theme.dart';
import 'package:findyourdresse_app/model/_enum/tag_enum.dart';
import 'package:findyourdresse_app/model/user_model_fyd/user_model_fyd.dart';
import 'package:findyourdresse_app/provider/picture_provider.dart';
import 'package:findyourdresse_app/view/page/home/widget/picture_card_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';

import '../../../widget/search_bar_widget.dart';

class PictureIndexPage extends ConsumerStatefulWidget {
  const PictureIndexPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PictureIndexPageState();
}

class _PictureIndexPageState extends ConsumerState<PictureIndexPage> {
  @override
  Widget build(BuildContext context) {
    var picture = ref.watch(pictureProvider).pictures;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(formatWidth(25), formatHeight(51), formatWidth(25), 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Transform.translate(
            offset: Offset(-formatWidth(10), 0),
            child: CTA.back(
              onTap: () {
                AutoRouter.of(context).navigateBack();
              },
            ),
          ),
          sh(14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'home-page.second-title'.tr(),
                    style: AppThemeStyle.homeSecondTitle,
                  ),
                  Text(
                    'model-page.subtitle'.tr(),
                    style: AppThemeStyle.subtitle,
                  ),
                ],
              ),
              if (FirebaseAuth.instance.currentUser != null &&
                  ref.watch(userChangeNotifierProvider).userData?.userType == "ProfilType.model") ...[
                InkWell(
                  onTap: () {
                    if ((ref.watch(userChangeNotifierProvider).userData! as UserModelFyd).type == "ProfilType.model") {
                      AutoRouter.of(context)
                          .navigateNamed("/dashboard/profil/model/${FirebaseAuth.instance.currentUser!.uid}");
                    } else {
                      AutoRouter.of(context)
                          .navigateNamed("/dashboard/profil/creator/${FirebaseAuth.instance.currentUser!.uid}");
                    }
                  },
                  child: (ref.watch(userChangeNotifierProvider).userData! as UserModelFyd).profilImage == null
                      ? Container(
                          width: formatWidth(40),
                          height: formatWidth(40),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(formatWidth(103)),
                            color: Colors.grey.shade200,
                          ),
                          child: Image.asset(
                            "assets/images/img_user_profil.png",
                            package: "skeleton_kosmos",
                            fit: BoxFit.cover,
                          ),
                        )
                      : CircleAvatar(
                          radius: 20.r,
                          backgroundImage: CachedNetworkImageProvider(
                              (ref.watch(userChangeNotifierProvider).userData! as UserModelFyd).profilImage!),
                        ),
                ),
              ]
            ],
          ),
          sh(19),
          InkWell(
              onTap: () {
                AutoRouter.of(context).navigateNamed("/dashboard/research/${TagEnum.model.label}");
              },
              child: searchBar('model-page.hint'.tr(), "assets/svg/search_inc.svg", AppColor.backGrey, radius: 7.r)),
          if (picture.isNotEmpty) ...[
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                clipBehavior: Clip.hardEdge,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(top: formatHeight(18), bottom: formatHeight(48)),
                itemBuilder: ((context, index) {
                  return InkWell(
                      onTap: () {
                        AutoRouter.of(context).navigateNamed("/dashboard/picture/details/${picture[index].id}");
                      },
                      child: PictureCardWidget(pictureModel: picture[index], ownerId: picture[index].ownerId!));
                }),
                separatorBuilder: ((context, index) => sh(6)),
                itemCount: picture.length,
              ),
            )
          ] else ...[
            Expanded(child: Center(child: Text('utils.empty'.tr()))),
          ]
        ],
      ),
    );
  }
}
