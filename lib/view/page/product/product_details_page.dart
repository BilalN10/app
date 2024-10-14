import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:findyourdresse_app/config/theme.dart';
import 'package:findyourdresse_app/model/product_model/productmodel.dart';
import 'package:findyourdresse_app/model/user_model_fyd/user_model_fyd.dart';
import 'package:findyourdresse_app/provider/form/product_form_provider.dart';
import 'package:findyourdresse_app/provider/product_provider.dart';
import 'package:findyourdresse_app/provider/user_provider.dart';
import 'package:findyourdresse_app/utils/text_with_url.dart';
import 'package:findyourdresse_app/utils/utils.dart';
import 'package:findyourdresse_app/view/page/signalment/signalment_page.dart';
import 'package:findyourdresse_app/widget/booking_widget.dart';
import 'package:findyourdresse_app/widget/carousel_widget.dart';
import 'package:findyourdresse_app/widget/signalemnt_cupertino_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';
import '../../../utils/enum.dart';

class ProductDetailsPage extends ConsumerStatefulWidget {
  final String productId;
  const ProductDetailsPage({super.key, @PathParam('productId') required this.productId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends ConsumerState<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    ProductModel? productModel = ref.watch(productProvider).getProductById(widget.productId);
    UserModelFyd? owner = ref.watch(userModelProvider).getModelById(productModel?.ownerId ?? "");

    if (owner == null || productModel == null) {
      return const Center(child: LoaderClassique());
    }

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            color: AppColor.lightGrey,
            child: Column(
              children: [
                sh(55),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      'title.details'.tr(),
                      style: TextStyle(color: Colors.black, fontSize: sp(16), fontWeight: FontWeight.w600),
                    ),
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
                          if (FirebaseAuth.instance.currentUser != null && productModel.ownerId == FirebaseAuth.instance.currentUser!.uid) ...[
                            InkWell(
                              onTap: () {
                                dialogCancelWidget(context, productModel.id!);
                              },
                              child: SvgPicture.asset('assets/svg/delete_inc.svg'),
                            ),
                          ] else ...[
                            InkWell(
                              onTap: () {
                                signalemntCupertino(context, ReportFrom.reportFromProduct, productModel.id!, null);
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
                    ),
                  ],
                ),
                sh(12),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child: CarouselWidget(pictures: productModel.productMedias!.map((e) => Tuple3(e.fileType == FileType.image ? e.url! : "https://image.mux.com/${e.playBackId}/thumbnail.png?width=400", e.fileType, e.playBackId)).toList().cast<Tuple3<String, FileType, String?>>()),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: formatWidth(23)),
                  decoration: BoxDecoration(color: AppColor.lightGrey, borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.r))),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sh(10),
                      Text(
                        productModel.name!.toCapitalized(),
                        style: TextStyle(fontSize: sp(27), fontFamily: 'PlayfairDisplay', fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      RichText(
                          text: TextSpan(text: 'title.sell-by'.tr(), style: AppThemeStyle.detailSubtitle, children: [
                        TextSpan(text: owner.nickname, style: AppThemeStyle.detailSubtitleUnderline),
                      ])),
                      sh(26)
                    ],
                  ),
                ),
              ),
            ],
          ),
          sh(19),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: formatWidth(23)),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
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
                    height: MediaQuery.of(context).size.height / 5,
                    child: SingleChildScrollView(
                        child: TextWithUrl(
                      text: productModel.description ?? "",
                      style: AppThemeStyle.detailSubtitle,
                      linkStyle: AppThemeStyle.detailSubtitle.copyWith(decoration: TextDecoration.underline, decorationThickness: 1),
                    )),
                  ),
                  const Divider(),
                  sh(10),
                  Row(
                    mainAxisAlignment: productModel.price != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
                    children: [
                      if (productModel.price != null) ...[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (productModel.price!) + '€',
                                style: AppThemeStyle.priceProductCard,
                              ),
                              Text('utils.price'.tr(), style: AppThemeStyle.detailSubtitle),
                            ],
                          ),
                        )
                      ],
                      if (FirebaseAuth.instance.currentUser != null && productModel.ownerId == FirebaseAuth.instance.currentUser!.uid) ...[
                        SizedBox(
                          width: productModel.price != null ? formatWidth(200) : formatWidth(310),
                          child: CTA.primary(
                            width: productModel.price != null ? formatWidth(200) : formatWidth(310),
                            textButton: 'title.modify-picture'.tr(),
                            onTap: () {
                              ref.read(productFormProvider).clear();
                              AutoRouter.of(context).navigateNamed("/dashboard/product/form?productId=${widget.productId}");
                            },
                          ),
                        ),
                      ] else ...[
                        SizedBox(
                          width: productModel.price != null ? formatWidth(200) : formatWidth(310),
                          child: BookingWidget(
                            creatorId: productModel.ownerId!,
                            product: productModel,
                          ),
                        ),
                      ]
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  dialogCancelWidget(BuildContext context, String pictureId) async {
    await showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: "",
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
                        sh(10),
                        Text(
                          "title.careful-text-product".tr(),
                          style: AppThemeStyle.dialogSubTitle,
                          textAlign: TextAlign.center,
                        ),
                        sh(32),
                        InkWell(
                          onTap: () async {
                            Navigator.of(_).pop();
                            AutoRouter.of(context).navigateBack();

                            await ref.read(productProvider).removeProduct(widget.productId);
                          },
                          child: Container(
                            decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(7)),
                            height: formatHeight(54),
                            width: formatWidth(139),
                            child: Center(
                              child: Text(
                                "utils.yes".tr(),
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white, fontSize: sp(17), fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
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
