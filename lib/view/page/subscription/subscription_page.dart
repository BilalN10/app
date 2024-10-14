import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:findyourdresse_app/config/theme.dart';
import 'package:findyourdresse_app/legalDoc/static_doc.dart';
import 'package:findyourdresse_app/model/_enum/profil_type_enum.dart';
import 'package:findyourdresse_app/model/user_model_fyd/user_model_fyd.dart';
import 'package:findyourdresse_app/routes/app_router.gr.dart';
import 'package:findyourdresse_app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';

import '../../../services/revenue_cat_services.dart';

class SubscriptionPage extends ConsumerStatefulWidget {
  const SubscriptionPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends ConsumerState<SubscriptionPage> {
  Offerings? offerings;
  List<Package> packages = [];
  bool isSubscribe = false;
  bool isLoading = true;
  String? managementURL;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOffers();
    PurchaseApi.updateCustomerStatus();
  }

  void getOffers() {
    PurchaseApi.fetchOffers().then((value) {
      setState(() {
        offerings = value;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: formatHeight(51), horizontal: formatWidth(27)),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CTA.back(
                backgroundColor: Colors.transparent,
                onTap: () {
                  AutoRouter.of(context).navigateBack();
                },
              ),
              InkWell(
                onTap: () {
                  print(offerings);

                  AutoRouter.of(context).navigateBack();
                },
                child: Text(
                  'utils.later'.tr(),
                  style: TextStyle(color: Colors.black, fontSize: sp(15), fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          sh(20),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              'assets/images/subscription_star.png',
              height: formatHeight(135),
              width: formatWidth(112),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  ProfilType.value.toEnum((ref.watch(userChangeNotifierProvider).userData as UserModelFyd).type) ==
                          ProfilType.model
                      ? 'subscription.model.title'.tr()
                      : 'subscription.creator.title'.tr(),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  style: TextStyle(color: Colors.black, fontSize: sp(24), fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          sh(9),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  ProfilType.value.toEnum((ref.watch(userChangeNotifierProvider).userData as UserModelFyd).type) ==
                          ProfilType.model
                      ? 'subscription.model.subtitle'.tr()
                      : 'subscription.creator.subtitle'.tr(),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                      color: const Color.fromRGBO(115, 125, 138, 100), fontSize: sp(13), fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          sh(20),
          Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset('assets/svg/validate_text_icon.svg'),
                  sw(7),
                  Expanded(
                    child: Text(
                      ProfilType.value.toEnum((ref.watch(userChangeNotifierProvider).userData as UserModelFyd).type) ==
                              ProfilType.model
                          ? 'subscription.model.line1'.tr()
                          : 'subscription.creator.line1'.tr(),
                      style: const TextStyle(
                          color: Color.fromRGBO(2, 19, 43, 100), fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
              sh(12),
              Row(
                children: [
                  SvgPicture.asset('assets/svg/validate_text_icon.svg'),
                  sw(7),
                  Expanded(
                    child: Text(
                      ProfilType.value.toEnum((ref.watch(userChangeNotifierProvider).userData as UserModelFyd).type) ==
                              ProfilType.model
                          ? 'subscription.model.line2'.tr()
                          : 'subscription.creator.line2'.tr(),
                      style: const TextStyle(
                          color: Color.fromRGBO(2, 19, 43, 100), fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
              sh(12),
              Row(
                children: [
                  SvgPicture.asset('assets/svg/validate_text_icon.svg'),
                  sw(7),
                  Expanded(
                    child: Text(
                      ProfilType.value.toEnum((ref.watch(userChangeNotifierProvider).userData as UserModelFyd).type) ==
                              ProfilType.model
                          ? 'subscription.model.line3'.tr()
                          : 'subscription.creator.line3'.tr(),
                      style: const TextStyle(
                          color: Color.fromRGBO(2, 19, 43, 100), fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
              sh(12),
              Row(
                children: [
                  SvgPicture.asset('assets/svg/validate_text_icon.svg'),
                  sw(7),
                  Expanded(
                    child: Text(
                      ProfilType.value.toEnum((ref.watch(userChangeNotifierProvider).userData as UserModelFyd).type) ==
                              ProfilType.model
                          ? 'subscription.model.line4'.tr()
                          : 'subscription.creator.line4'.tr(),
                      style: const TextStyle(
                          color: Color.fromRGBO(2, 19, 43, 100), fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
              sh(12),
              Row(
                children: [
                  SvgPicture.asset('assets/svg/validate_text_icon.svg'),
                  sw(7),
                  Expanded(
                    child: Text(
                      ProfilType.value.toEnum((ref.watch(userChangeNotifierProvider).userData as UserModelFyd).type) ==
                              ProfilType.model
                          ? 'subscription.model.line5'.tr()
                          : 'subscription.creator.line5'.tr(),
                      style: const TextStyle(
                          color: Color.fromRGBO(2, 19, 43, 100), fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ],
          ),
          const Spacer(),
          if (offerings != null && isLoading == false) ...[
            InkWell(
              onTap: () {
                print(offerings);
              },
              child: Text(
                ProfilType.value.toEnum((ref.watch(userChangeNotifierProvider).userData as UserModelFyd).type) ==
                        ProfilType.model
                    ? offerings!.getOffering('premium_access_ios_model')!.monthly!.storeProduct.priceString +
                        "subscription.by-month".tr()
                    : offerings!.getOffering('premium_access_ios_creator')!.monthly!.storeProduct.priceString +
                        "subscription.by-month".tr(),
                style: TextStyle(color: Colors.black, fontSize: sp(13), fontWeight: FontWeight.w500),
              ),
            ),
            sh(9),
            CTA.primary(
              textButton: 'subscription.cta'.tr(),
              onTap: () async {
                if (Platform.isIOS) {
                  await showDialog(
                    context: context,
                    builder: (BuildContext _) {
                      return CupertinoAlertDialog(
                        title: Text("subscription.info.title".tr()),
                        content: Text("subscription.info.sub-flow".tr()),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            child: const Text("OK"),
                            onPressed: () async {
                              Navigator.pop(_);
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
                try {
                  if (ProfilType.value.toEnum((ref.watch(userChangeNotifierProvider).userData as UserModelFyd).type) ==
                      ProfilType.model) {
                    await Purchases.purchasePackage(
                        offerings!.getOffering('premium_access_ios_model')!.availablePackages.first);
                  } else {
                    await Purchases.purchasePackage(
                        offerings!.getOffering('premium_access_ios_creator')!.availablePackages.first);
                  }

                  Utils.notifGreen(
                      context, 'banner.green-subscription-title'.tr(), 'banner.green-subscription-subtitle'.tr());
                  AutoRouter.of(context).navigateBack();
                } on PlatformException catch (e) {
                  var errorCode = PurchasesErrorHelper.getErrorCode(e);

                  if (errorCode == PurchasesErrorCode.productAlreadyPurchasedError) {
                    showModalBottomSheet<void>(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                        ),
                        backgroundColor: Theme.of(context).backgroundColor,
                        isScrollControlled: true,
                        enableDrag: true,
                        isDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          double paddingBottom = MediaQuery.of(context).viewInsets.bottom;

                          return Padding(
                            padding: EdgeInsets.only(bottom: paddingBottom),
                            child: Text(
                              'settings.payment.subscription-page.error'.tr(),
                            ),
                          );
                        });
                  } else if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
                    showModalBottomSheet<void>(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                      ),
                      backgroundColor: Color(0XFF2B2B2B),
                      isScrollControlled: true,
                      enableDrag: true,
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: formatHeight(70),
                          child: Padding(
                            padding: EdgeInsets.only(top: formatHeight(10), left: formatWidth(20)),
                            child: Text(
                              'settings.payment.subscription-page.cancel'.tr(),
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: sp(14)),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
                    showModalBottomSheet<void>(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                      ),
                      backgroundColor: Color(0XFF2B2B2B),
                      isScrollControlled: true,
                      enableDrag: true,
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: formatHeight(70),
                          child: Padding(
                            padding: EdgeInsets.only(top: formatHeight(10), left: formatWidth(20)),
                            child: Text(
                              'settings.payment.subscription-page.cancel'.tr(),
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: sp(14)),
                            ),
                          ),
                        );
                      },
                    );
                  }
                }
              },
            ),
            sh(10),
            Text(
              'subscription.free'.tr(),
              style: const TextStyle(color: Color.fromRGBO(2, 19, 43, 100), fontSize: 13, fontWeight: FontWeight.w500),
            ),
            sh(20),
            InkWell(
              onTap: () async {
                try {
                  CustomerInfo customerInfo = await Purchases.restorePurchases();
                  if (customerInfo.activeSubscriptions.isNotEmpty) {
                    NotifBanner.showToast(
                      context: context,
                      backgroundColor: const Color(0xff0ACC73),
                      fToast: FToast().init(context),
                      title: 'subscription.info.restore-success-info'.tr(),
                    );
                    await Future.delayed(const Duration(seconds: 1));
                    AutoRouter.of(context).navigateBack();
                  } else {
                    NotifBanner.showToast(
                      context: context,
                      backgroundColor: const Color(0xff0ACC73),
                      fToast: FToast().init(context),
                      title: 'subscription.info.restore-error-info'.tr(),
                    );
                  }
                  // ... check restored purchaserInfo to see if entitlement is now active
                } on PlatformException catch (e) {
                  // Error restoring purchases
                  NotifBanner.showToast(
                    context: context,
                    backgroundColor: const Color(0xff0ACC73),
                    fToast: FToast().init(context),
                    title: 'settings.payment.subscription-page.restore-error-info'.tr(),
                  );
                }
              },
              child: Text(
                'subscription.info.restore'.tr(),
                style: const TextStyle(
                  color: Color.fromRGBO(0, 5, 12, 0.612),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            sh(15),
            InkWell(
              onTap: () {
                AutoRouter.of(context).push(LegalDocRoute(type: LegalDoc.termsOfUse));
              },
              child: Text(
                'authentication.cgu.title'.tr(),
                style: const TextStyle(
                    color: Color.fromRGBO(0, 5, 12, 0.612),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline),
              ),
            ),
          ] else ...[
            Center(
              child: CircularProgressIndicator(
                color: AppColor.linearFirst,
              ),
            )
          ]
        ],
      ),
    );
  }
}
