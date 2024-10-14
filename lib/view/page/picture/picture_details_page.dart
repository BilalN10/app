import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:findyourdresse_app/config/theme.dart';
import 'package:findyourdresse_app/model/_enum/tag_enum.dart';
import 'package:findyourdresse_app/model/picture_model/picturemodel.dart';
import 'package:findyourdresse_app/model/user_model_fyd/user_model_fyd.dart';
import 'package:findyourdresse_app/provider/picture_provider.dart';
import 'package:findyourdresse_app/provider/user_provider.dart';
import 'package:findyourdresse_app/routes/app_router.gr.dart';
import 'package:findyourdresse_app/utils/enum.dart' as input;
import 'package:findyourdresse_app/view/page/signalment/signalment_page.dart';
import 'package:findyourdresse_app/widget/my_signalment_page/core.dart';
import 'package:findyourdresse_app/widget/signalemnt_cupertino_widget.dart' as sg;
import 'package:findyourdresse_app/widget/video_player_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';
import 'package:readmore/readmore.dart';
import '../../../widget/signalemnt_cupertino_widget.dart';

class PictureDetailsPage extends ConsumerStatefulWidget {
  final String id;
  const PictureDetailsPage({super.key, @PathParam('id') required this.id});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PictureDetailsPageState();
}

class _PictureDetailsPageState extends ConsumerState<PictureDetailsPage> {
  @override
  Widget build(BuildContext context) {
    PictureModel? pictureModel = ref.watch(pictureProvider).getPictureById(widget.id);
    UserModelFyd? owner = ref.watch(userModelProvider).getModelById(pictureModel?.ownerId ?? '');

    if (pictureModel == null || owner == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
      color: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),

        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: AppColor.lightGrey,
            padding: EdgeInsets.only(left: 10.w, right: 15.w),
            child: Column(
              children: [
                sh(55),
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Text(
                      'title.details'.tr(),
                      style: TextStyle(color: Colors.black, fontSize: sp(16), fontWeight: FontWeight.w600),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CTA.back(
                          onTap: () {
                            AutoRouter.of(context).navigateBack();
                          },
                        ),
                        if (FirebaseAuth.instance.currentUser != null &&
                            pictureModel.ownerId == FirebaseAuth.instance.currentUser!.uid) ...[
                          InkWell(
                            onTap: () {
                              dialogCancelWidget(context, pictureModel.id!);
                            },
                            // showGeneralDialog(context: context, pageBuilder: _deleteDialog(context));

                            child: SvgPicture.asset('assets/svg/delete_inc.svg'),
                          ),
                        ] else ...[
                          InkWell(
                            onTap: () {
                              ReportServices.reportModel(context, modelId: owner.id!, pictureId: widget.id);
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: formatHeight(20), horizontal: formatWidth(20)),
                              child: SvgPicture.asset(
                                "assets/svg/double_dot.svg",
                                width: formatWidth(5),
                              ),
                            ),
                          )
                        ]
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.w, top: 13.h),
                  child: InkWell(
                    onTap: () {
                      if (pictureModel.mediaType == input.FileType.video) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    VideoPlayerMedia(url: "https://stream.mux.com/${pictureModel.playBackId}.m3u8")));
                        return;
                      }

                      AutoRouter.of(context).navigate(FullCarouselWidget(
                          pictures: [Tuple3(pictureModel.pictureUrl!, input.FileType.image, null)], index: 0));
                    },
                    child: SizedBox(
                      height: formatHeight(237),
                      width: formatWidth(346),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(2.r),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: CachedNetworkImage(
                                imageUrl: pictureModel.mediaType == input.FileType.image
                                    ? pictureModel.pictureUrl!
                                    : "https://image.mux.com/${pictureModel.playBackId}/thumbnail.png?width=400",
                                fit: BoxFit.cover,
                                placeholder: (_, __) => const Center(
                                  child: LoaderClassique(),
                                ),
                                errorWidget: (_, __, ___) => const Icon(Icons.error, color: Colors.red),
                              ),
                            ),
                            if (pictureModel.mediaType == input.FileType.video) ...[
                              const Center(
                                  child: Icon(
                                Icons.play_arrow_rounded,
                                color: Colors.white,
                                size: 50,
                              ))
                            ]
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: formatWidth(23)),
            decoration: BoxDecoration(
                color: AppColor.lightGrey, borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.r))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sh(14),
                sh(22),
                Text(
                  owner.firstname! + ' ' + owner.lastname!,
                  style: TextStyle(
                      fontSize: sp(27),
                      fontFamily: 'PlayfairDisplay',
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                if (owner.location != null) ...[
                  sh(5),
                  Text(
                    owner.location?.formattedText ?? '',
                    style: AppThemeStyle.detailSubtitle,
                  ),
                ],
                sh(6),
                Row(
                  children: [
                    Expanded(
                      child: ReadMoreText(
                        owner.description ?? '',
                        trimLines: 2,
                        colorClickableText: Colors.blue,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: "utils.seemore".tr(),
                        trimExpandedText: "utils.seeless".tr(),
                        style: AppThemeStyle.detailSubtitle,
                        moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    )
                    // Expanded(
                    //   child: Text(
                    //     owner.description ?? '',
                    //     style: AppThemeStyle.detailSubtitle,
                    //   ),
                    // ),
                  ],
                ),
                sh(18)
              ],
            ),
          ),
          sh(24),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: formatWidth(23)),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'title.description'.tr(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: sp(16),
                    fontFamily: 'PlayfairDisplay',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                sh(4.5),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 5.4,
                  child: SingleChildScrollView(
                    child: Text(
                      pictureModel.description!,
                      style: AppThemeStyle.detailSubtitle,
                    ),
                  ),
                ),
                const Divider(),
                sh(10),
                CTA.primary(
                  textButton: FirebaseAuth.instance.currentUser != null &&
                          pictureModel.ownerId == FirebaseAuth.instance.currentUser!.uid
                      ? 'title.modify-picture'.tr()
                      : 'title.profil-complet'.tr(),
                  onTap: () {
                    FirebaseAuth.instance.currentUser != null &&
                            pictureModel.ownerId == FirebaseAuth.instance.currentUser!.uid
                        ? AutoRouter.of(context).navigateNamed("/dashboard/picture/form?pictureId=${widget.id}")
                        : AutoRouter.of(context).navigateNamed("/dashboard/profil/model/${owner.id}");
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  dialogCancelWidget(BuildContext context, String pictureId) async {
    await showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: "No charms",
      pageBuilder: (_, __, ___) {
        return Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              constraints: BoxConstraints(maxHeight: formatHeight(MediaQuery.of(context).size.height * .6)),
              width: formatWidth(282),
              padding: EdgeInsets.symmetric(horizontal: formatWidth(20), vertical: formatHeight(18)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () => Navigator.of(_).pop(),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: formatHeight(10), horizontal: formatWidth(14)),
                        child: SvgPicture.asset("assets/svg/close_inc.svg", width: formatWidth(15)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: formatWidth(20)),
                    child: Column(
                      children: [
                        Text(
                          'title.careful'.tr(),
                          style: AppThemeStyle.dialogTitle,
                        ),
                        sh(11),
                        Text(
                          "title.careful-text-picture".tr(),
                          style: AppThemeStyle.dialogSubTitle,
                          textAlign: TextAlign.center,
                        ),
                        sh(32),
                        CTA.primary(
                          theme:
                              CtaThemeData(backgroundColor: Colors.red, textButtonStyle: AppThemeStyle.dialogButtonYes),
                          width: 200,
                          textButton: "utils.yes".tr(),
                          onTap: () {
                            Navigator.of(_).pop();
                            print(1);
                            AutoRouter.of(context).navigateBack();
                            print(2);
                            ref.read(pictureProvider).removePicture(pictureId);
                          },
                        ),
                        sh(13),
                        InkWell(
                          onTap: () => Navigator.of(_).pop(),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: formatHeight(10), horizontal: formatWidth(14)),
                            child: Text(
                              "utils.no".tr(),
                              style: AppThemeStyle.dialogButtonNo,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
