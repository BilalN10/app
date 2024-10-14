import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:findyourdresse_app/config/theme.dart';
import 'package:findyourdresse_app/model/mesurements_model/mesurements_model.dart';
import 'package:findyourdresse_app/model/picture_model/picturemodel.dart';
import 'package:findyourdresse_app/model/user_model_fyd/user_model_fyd.dart';
import 'package:findyourdresse_app/provider/notification_manage_new_provider.dart';
import 'package:findyourdresse_app/provider/picture_provider.dart';
import 'package:findyourdresse_app/provider/user_provider.dart';
import 'package:findyourdresse_app/view/page/signalment/signalment_page.dart';
import 'package:findyourdresse_app/widget/signalemnt_cupertino_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';

import '../home/widget/picture_card_widget.dart';

class ProfilModelPage extends ConsumerStatefulWidget {
  final String profilId;
  const ProfilModelPage({super.key, @PathParam('profilId') required this.profilId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilModelPageState();
}

class _ProfilModelPageState extends ConsumerState<ProfilModelPage> {
  @override
  Widget build(BuildContext context) {
    UserModelFyd? user = ref.watch(userModelProvider).getModelById(widget.profilId);
    List<PictureModel> picture = ref.watch(pictureProvider).getModelPictures(widget.profilId);

    return user != null
        ? Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                    scrolledUnderElevation: 0.5,
                    floating: false,
                    stretch: true,
                    pinned: true,
                    expandedHeight: 60.h,
                    collapsedHeight: 70.h,
                    automaticallyImplyLeading: true,
                    backgroundColor: Colors.white,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Column(
                        children: [
                          sh(52),
                          Padding(
                            padding: EdgeInsets.only(left: 10.w, right: 10.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CTA.back(
                                  onTap: () {
                                    AutoRouter.of(context).navigateBack();
                                  },
                                ),
                                if (FirebaseAuth.instance.currentUser != null && widget.profilId == FirebaseAuth.instance.currentUser!.uid) ...[
                                  Row(
                                    children: [
                                      // InkWell(
                                      //   onTap: () {
                                      //     // AutoRouter.of(context).navigateNamed("/dashboard/profil/notification");
                                      //     AutoRouter.of(context).navigateNamed("/dashboard/notification/page");
                                      //   },
                                      //   child: ref.watch(notificationManageNewProvider(FirebaseAuth.instance.currentUser!.uid)).modelhasNotification == true
                                      //       ? Padding(
                                      //           padding: EdgeInsets.symmetric(vertical: formatHeight(10), horizontal: formatWidth(10)),
                                      //           child: SvgPicture.asset("assets/svg/notification_inc.svg"),
                                      //         )
                                      //       : Padding(
                                      //           padding: EdgeInsets.symmetric(vertical: formatHeight(10), horizontal: formatWidth(10)),
                                      //           child: SvgPicture.asset("assets/svg/notification_inc_empty.svg"),
                                      //         ),
                                      // ),
                                      InkWell(
                                        onTap: () {
                                          AutoRouter.of(context).navigateNamed('/dashboard/profile/settings');
                                        },
                                        child: Padding(padding: EdgeInsets.symmetric(vertical: formatHeight(10), horizontal: formatWidth(10)), child: SvgPicture.asset("assets/svg/settings_inc.svg")),
                                      ),
                                    ],
                                  ),
                                ] else ...[
                                  InkWell(
                                    onTap: () {
                                      signalemntCupertino(context, ReportFrom.reportFromUser, widget.profilId, null);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: formatHeight(20), horizontal: formatWidth(20)),
                                      child: SvgPicture.asset(
                                        "assets/svg/double_dot.svg",
                                        width: formatWidth(5),
                                      ),
                                    ),
                                  )
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                SliverToBoxAdapter(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 26.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                              width: formatWidth(87),
                              height: formatHeight(87),
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
                              child: (user.profilImage == null
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
                                  : CachedNetworkImage(
                                      imageUrl: user.profilImage!,
                                      fit: BoxFit.cover,
                                      placeholderFadeInDuration: const Duration(seconds: 2),
                                      placeholder: (_, __) => Shimmer(
                                          child: Container(
                                            width: formatWidth(87),
                                            height: formatHeight(87),
                                            clipBehavior: Clip.hardEdge,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100),
                                              color: Colors.white,
                                            ),
                                          ),
                                          gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [Colors.grey.shade100, Colors.grey]))))),
                          sh(4),
                          Text(user.firstname! + ' ' + user.lastname!, style: TextStyle(color: Colors.black, fontSize: sp(27), fontWeight: FontWeight.w700, fontFamily: "PlayfairDisplay")),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  sh(7),
                                  Text("@${user.nickname} ${user.location?.city != null ? (" - " + (user.location!.city ?? "")) : ""}", style: AppThemeStyle.profilsubtitle),
                                  sh(12),
                                  if (user.instagram != null) ...[
                                    Text("content.title-instagram".tr(), style: TextStyle(color: const Color(0xff02132B).withOpacity(.48), fontSize: sp(11), fontWeight: FontWeight.w400)),
                                    Text("@${user.instagram} ", style: TextStyle(color: Colors.black, fontSize: sp(11), fontWeight: FontWeight.w400)),
                                  ],
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: formatWidth(7)),
                                    // height: formatHeight(47),
                                    width: formatWidth(87),
                                    decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(2.r)),
                                    child: Column(
                                      children: [sh(3), Text(picture.length.toString(), style: AppThemeStyle.profilStats), Text(picture.length > 1 ? 'title.photoNbTexts'.tr() : 'title.photoNbText'.tr(), style: AppThemeStyle.profilTextStats)],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          if (user.expPro != null) ...[
                            sh(10),
                            Text("content.exp-pro-title".tr(), style: TextStyle(color: const Color(0xff02132B).withOpacity(.48), fontSize: sp(11), fontWeight: FontWeight.w400)),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1,
                              child: Row(
                                children: [
                                  Expanded(
                                      child: ReadMoreText(
                                    user.expPro ?? '',
                                    trimLines: 2,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: 'utils.seemore'.tr(),
                                    trimExpandedText: 'utils.seeless'.tr(),
                                    style: AppThemeStyle.profilDescription,
                                    moreStyle: TextStyle(fontSize: sp(11), fontWeight: FontWeight.w400, color: AppColor.linearFirst),
                                    lessStyle: TextStyle(fontSize: sp(11), fontWeight: FontWeight.w400, color: AppColor.linearFirst),
                                  )),
                                ],
                              ),
                            ),
                          ],
                          if (user.mensurations != null) ...[
                            sh(10),
                            InkWell(
                                onTap: () {
                                  print(user.mensurations!.toJson().values.where((element) => element != null).length);
                                },
                                child: Text("content.mensuration-title".tr(), style: TextStyle(color: const Color(0xff02132B).withOpacity(.48), fontSize: sp(11), fontWeight: FontWeight.w400))),
                            Wrap(
                                children: user.mensurations!.toJson().entries.where((entry) => entry.value != null).map((entry) {
                              var filteredEntries = user.mensurations!.toJson().entries.where((el) => el.value != null).toList();

                              if (filteredEntries.map((e) => e.key).toList().indexOf(entry.key) != filteredEntries.length - 1) {
                                return Text(
                                  entry.value.toString() + ' ' + MesurementsModel.mesurementToDisplay(entry.key) + " - ",
                                  style: TextStyle(color: Colors.black, fontSize: sp(11), fontWeight: FontWeight.w400),
                                );
                              } else {
                                return Text(entry.value.toString() + MesurementsModel.mesurementToDisplay(entry.key), style: TextStyle(color: Colors.black, fontSize: sp(11), fontWeight: FontWeight.w400));
                              }
                            }).toList()),
                          ],
                        ],
                      )),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: formatWidth(25)),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          sh(20),
                          const Divider(),
                          sh(18),
                          Text('title.picture-title'.tr(), style: TextStyle(color: Colors.black, fontSize: sp(16), fontWeight: FontWeight.w600, fontFamily: "PlayfairDisplay")),
                        ]),
                      ),
                      picture.isNotEmpty
                          ? ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              clipBehavior: Clip.hardEdge,
                              physics: const ClampingScrollPhysics(),
                              padding: EdgeInsets.symmetric(vertical: formatHeight(18), horizontal: formatWidth(25)).copyWith(bottom: 60.h),
                              itemBuilder: ((context, index) {
                                return InkWell(
                                    onTap: () {
                                      AutoRouter.of(context).navigateNamed("/dashboard/picture/details/${picture[index].id}");
                                    },
                                    child: PictureCardWidget(pictureModel: picture[index], ownerId: picture[index].ownerId!));
                              }),
                              separatorBuilder: ((context, index) => sh(6)),
                              itemCount: picture.length,
                            )
                          : Column(
                              children: [
                                sh(150),
                                Center(
                                  child: Text('content.no-picture'.tr()),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : const LoaderClassique();
  }
}
