import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:findyourdresse_app/config/theme.dart';
import 'package:findyourdresse_app/model/product_model/productmodel.dart';
import 'package:findyourdresse_app/model/user_model_fyd/user_model_fyd.dart';
import 'package:findyourdresse_app/provider/product_provider.dart';
import 'package:findyourdresse_app/provider/user_provider.dart';
import 'package:findyourdresse_app/view/page/signalment/signalment_page.dart';
import 'package:findyourdresse_app/widget/booking_widget.dart';
import 'package:findyourdresse_app/widget/product_card_widget.dart';
import 'package:findyourdresse_app/widget/signalemnt_cupertino_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';

class ProfilCreatorPage extends ConsumerStatefulWidget {
  final String profilId;
  const ProfilCreatorPage({super.key, @PathParam('profilId') required this.profilId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilCreatorPageState();
}

class _ProfilCreatorPageState extends ConsumerState<ProfilCreatorPage> {
  @override
  Widget build(BuildContext context) {
    UserModelFyd? user = ref.watch(userModelProvider).getModelById(widget.profilId);
    List<ProductModel> product = ref.watch(productProvider).getCreatorProducts(widget.profilId);

    return user != null
        ? Scaffold(
            body: CustomScrollView(slivers: [
            SliverAppBar(
              scrolledUnderElevation: 0.5,
              floating: false,
              stretch: true,
              pinned: true,
              expandedHeight: 65.h,
              collapsedHeight: 65.h,
              automaticallyImplyLeading: true,
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                  background: Column(children: [
                sh(52),
                Padding(
                  padding: EdgeInsets.only(left: 10.w, right: 15.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CTA.back(
                        onTap: () {
                          AutoRouter.of(context).navigateBack();
                        },
                      ),
                      if (FirebaseAuth.instance.currentUser != null &&
                          widget.profilId == FirebaseAuth.instance.currentUser!.uid) ...[
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                AutoRouter.of(context).navigateNamed('/dashboard/profile/settings');
                              },
                              child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: formatHeight(10), horizontal: formatWidth(10)),
                                  child: SvgPicture.asset("assets/svg/settings_inc.svg")),
                            ),
                          ],
                        ),
                      ] else ...[
                        InkWell(
                          onTap: () {
                            signalemntCupertino(context, ReportFrom.reportFromUser, widget.profilId, null);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: formatHeight(10), horizontal: formatWidth(10)),
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
              ])),
            ),
            SliverToBoxAdapter(
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: formatWidth(23)),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sh(23),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Container(
                                  width: formatWidth(87),
                                  height: formatHeight(87),
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
                                  child: user.profilImage == null
                                      ? Container(
                                          width: formatWidth(87),
                                          height: formatWidth(87),
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
                                              gradient: LinearGradient(
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  colors: [Colors.grey.shade100, Colors.grey]))),
                                ),
                                sh(4),
                                Text(user.shopNickname!,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: sp(27),
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "PlayfairDisplay")),
                                if (user.instagram != null || user.location?.city != null) ...[
                                  sh(2),
                                  Text(
                                      "${user.instagram == null ? '' : '@' + user.instagram.toString()}${user.location?.city != null ? ((user.instagram == null ? '' : " - ") + (user.location!.city ?? "")) : ""}",
                                      style: AppThemeStyle.profilsubtitle),
                                ],
                                sh(6),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: ReadMoreText(
                                        user.description ?? '',
                                        trimLines: 2,
                                        colorClickableText: Colors.blue,
                                        trimMode: TrimMode.Line,
                                        trimCollapsedText: 'utils.seemore'.tr(),
                                        trimExpandedText: 'utils.seeless'.tr(),
                                        style: AppThemeStyle.profilDescription,
                                        moreStyle: TextStyle(
                                            fontSize: sp(11), fontWeight: FontWeight.w400, color: AppColor.linearFirst),
                                        lessStyle: TextStyle(
                                            fontSize: sp(11), fontWeight: FontWeight.w400, color: AppColor.linearFirst),
                                      )),
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: formatWidth(7)),
                              width: formatWidth(87),
                              decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(2.r)),
                              child: Column(
                                children: [
                                  Text(product.length.toString(), style: AppThemeStyle.profilStats),
                                  Text(product.length > 1 ? 'title.productNbTexts'.tr() : 'title.productNbText'.tr(),
                                      style: AppThemeStyle.profilTextStats)
                                ],
                              ),
                            )
                          ],
                        ),
                        if (FirebaseAuth.instance.currentUser != null &&
                            widget.profilId != FirebaseAuth.instance.currentUser!.uid) ...[
                          sh(16),
                          BookingWidget(
                            creatorId: widget.profilId,
                          ),
                        ] else if (FirebaseAuth.instance.currentUser == null) ...[
                          sh(16),
                          BookingWidget(
                            creatorId: widget.profilId,
                          ),
                        ],
                        sh(24),
                        const Divider(
                          height: 0,
                        ),
                        sh(12),
                        Text(
                            widget.profilId != FirebaseAuth.instance.currentUser?.uid
                                ? 'title.product-title'.tr()
                                : 'title.my-product-title'.tr(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: sp(16),
                                fontWeight: FontWeight.w400,
                                fontFamily: "PlayfairDisplay")),
                      ],
                    ))),
            SliverList(
                delegate: SliverChildListDelegate([
              if (product.isNotEmpty) ...[
                ListView.separated(
                  cacheExtent: 5,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  clipBehavior: Clip.hardEdge,
                  physics: const ClampingScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: formatHeight(10), horizontal: formatWidth(25))
                      .copyWith(bottom: MediaQuery.of(context).padding.bottom + formatHeight(10)),
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () {
                        AutoRouter.of(context).navigateNamed("/dashboard/product/details/${product[index].id}");
                      },
                      child: ProductCardWidget(productModel: product[index], ownerId: product[index].ownerId!),
                    );
                  }),
                  separatorBuilder: ((context, index) => sh(6)),
                  itemCount: product.length,
                )
              ] else ...[
                sh(150),
                Center(child: Text('utils.empty'.tr())),
              ]
            ]))
          ]))
        : const SizedBox();
    // ? Scaffold(
    //     body: Column(
    //       children: [
    //         sh(52),
    //         Padding(
    //           padding: EdgeInsets.only(left: 10.w, right: 15.w),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               CTA.back(
    //                 onTap: () {
    //                  AutoRouter.of(context).navigateBack();
    //                 },
    //               ),
    //               if (FirebaseAuth.instance.currentUser != null &&
    //                   widget.profilId == FirebaseAuth.instance.currentUser!.uid) ...[
    //                 Row(
    //                   children: [
    //                     InkWell(
    //                       onTap: () {
    //                         AutoRouter.of(context).navigateNamed("/dashboard/profil/notification");
    //                       },
    //                       child: ref
    //                               .watch(notificationManageProvider(widget.profilId))
    //                               .getNotificationActiveByOwner()
    //                           ? Padding(
    //                               padding:
    //                                   EdgeInsets.symmetric(vertical: formatHeight(10), horizontal: formatWidth(10)),
    //                               child: SvgPicture.asset("assets/svg/notification_inc_empty.svg"),
    //                             )
    //                           : Padding(
    //                               padding:
    //                                   EdgeInsets.symmetric(vertical: formatHeight(10), horizontal: formatWidth(10)),
    //                               child: SvgPicture.asset("assets/svg/notification_inc.svg"),
    //                             ),
    //                     ),
    //                     // sw(18),
    //                     InkWell(
    //                       onTap: () {
    //                         UserModelFyd? userData = ref.read(userChangeNotifierProvider).userData as UserModelFyd;
    //                         if (userData.type != null) {
    //                           ref.read(profilTypeProvider).setProfilType(ProfilType.value.toEnum(userData.type));
    //                         }

    //                         AutoRouter.of(context).navigateNamed('/dashboard/profile/settings');
    //                       },
    //                       child: Padding(
    //                         padding: EdgeInsets.symmetric(vertical: formatHeight(10), horizontal: formatWidth(10)),
    //                         child: SvgPicture.asset("assets/svg/settings_inc.svg"),
    //                       ),
    //                     ),
    //                   ],
    //                 )
    //               ] else ...[
    //                 InkWell(
    //                   onTap: () {
    //                     signalemntCupertino(context, TagEnum.model, widget.profilId);
    //                   },
    //                   child: Padding(
    //                     padding: EdgeInsets.symmetric(vertical: formatHeight(10), horizontal: formatWidth(10)),
    //                     child: SvgPicture.asset(
    //                       "assets/svg/double_dot.svg",
    //                       width: formatWidth(5),
    //                     ),
    //                   ),
    //                 )
    //               ],
    //             ],
    //           ),
    //         ),
    //         Expanded(
    //           child: Container(
    //             padding: EdgeInsets.symmetric(horizontal: formatWidth(23)),
    //             color: Colors.white,
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 sh(23),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   crossAxisAlignment: CrossAxisAlignment.end,
    //                   children: [
    //                     Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Container(
    //                           width: formatWidth(87),
    //                           height: formatHeight(87),
    //                           clipBehavior: Clip.hardEdge,
    //                           decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
    //                           child: user.profilImage == null
    //                               ? Container(
    //                                   width: formatWidth(87),
    //                                   height: formatWidth(87),
    //                                   decoration: BoxDecoration(
    //                                     borderRadius: BorderRadius.circular(formatWidth(103)),
    //                                     color: Colors.grey.shade200,
    //                                   ),
    //                                   child: Image.asset(
    //                                     "assets/images/img_user_profil.png",
    //                                     package: "skeleton_kosmos",
    //                                     fit: BoxFit.cover,
    //                                   ),
    //                                 )
    //                               : CachedNetworkImage(
    //                                   imageUrl: user.profilImage!,
    //                                   fit: BoxFit.cover,
    //                                   placeholder: (_, __) => Shimmer(
    //                                       child: Container(
    //                                         width: formatWidth(87),
    //                                         height: formatHeight(87),
    //                                         clipBehavior: Clip.hardEdge,
    //                                         decoration: BoxDecoration(
    //                                           borderRadius: BorderRadius.circular(100),
    //                                           color: Colors.white,
    //                                         ),
    //                                       ),
    //                                       gradient: LinearGradient(
    //                                           begin: Alignment.centerLeft,
    //                                           end: Alignment.centerRight,
    //                                           colors: [Colors.grey.shade100, Colors.grey]))),
    //                         ),
    //                         sh(4),
    //                         Text(user.firstname! + ' ' + user.lastname!,
    //                             style: TextStyle(
    //                                 color: Colors.black,
    //                                 fontSize: sp(27),
    //                                 fontWeight: FontWeight.w700,
    //                                 fontFamily: "PlayfairDisplay")),
    //                         sh(2),
    //                         Text(
    //                             "@${user.nickname}${user.location?.city != null ? (" - " + (user.location!.city ?? "")) : ""}",
    //                             style: AppThemeStyle.profilsubtitle),
    //                         sh(6),
    //                         SizedBox(
    //                           width: MediaQuery.of(context).size.width / 2,
    //                           child: Row(
    //                             children: [
    //                               Expanded(
    //                                   child: ReadMoreText(
    //                                 user.description ?? '',
    //                                 trimLines: 2,
    //                                 colorClickableText: Colors.blue,
    //                                 trimMode: TrimMode.Line,
    //                                 trimCollapsedText: 'utils.seemore'.tr(),
    //                                 trimExpandedText: 'utils.seeless'.tr(),
    //                                 style: AppThemeStyle.profilDescription,
    //                                 moreStyle: TextStyle(
    //                                     fontSize: sp(11), fontWeight: FontWeight.bold, color: Colors.black),
    //                               )),
    //                             ],
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                     Container(
    //                       padding: EdgeInsets.symmetric(vertical: formatWidth(7)),
    //                       width: formatWidth(87),
    //                       decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(2.r)),
    //                       child: Column(
    //                         children: [
    //                           sh(3),
    //                           Text(product.length.toString(), style: AppThemeStyle.profilStats),
    //                           Text(product.length > 1 ? 'title.productNbTexts'.tr() : 'title.productNbText'.tr(),
    //                               style: AppThemeStyle.profilTextStats)
    //                         ],
    //                       ),
    //                     )
    //                   ],
    //                 ),
    //                 if (FirebaseAuth.instance.currentUser != null &&
    //                     widget.profilId != FirebaseAuth.instance.currentUser!.uid) ...[
    //                   sh(16),
    //                   BookingWidget(
    //                     creatorId: widget.profilId,
    //                   ),
    //                 ] else if (FirebaseAuth.instance.currentUser == null) ...[
    //                   sh(16),
    //                   BookingWidget(
    //                     creatorId: widget.profilId,
    //                   ),
    //                 ],
    //                 sh(24),
    //                 const Divider(
    //                   height: 0,
    //                 ),
    //                 sh(12),
    //                 Text(
    //                     widget.profilId != FirebaseAuth.instance.currentUser!.uid
    //                         ? 'title.product-title'.tr()
    //                         : 'title.my-product-title'.tr(),
    //                     style: TextStyle(
    //                         color: Colors.black,
    //                         fontSize: sp(16),
    //                         fontWeight: FontWeight.w400,
    //                         fontFamily: "PlayfairDisplay")),
    //
    //               ],
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   )
    // : const LoaderClassique();
  }
}
