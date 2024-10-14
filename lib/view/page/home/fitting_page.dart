import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:findyourdresse_app/config/theme.dart';
import 'package:findyourdresse_app/model/booking_model/bookingmodel.dart';
import 'package:findyourdresse_app/model/user_info_model/user_info_model.dart';
import 'package:findyourdresse_app/model/user_model_fyd/user_model_fyd.dart';
import 'package:findyourdresse_app/provider/booking_provider.dart';
import 'package:findyourdresse_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';

import '../../../provider/navigation.dart';

class FittingPage extends ConsumerStatefulWidget {
  const FittingPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FittingPageState();
}

@override
class _FittingPageState extends ConsumerState<FittingPage> {
  final formatDate = DateFormat("dd/MM/y à HH'h'mm");

  @override
  void initState() {
    super.initState();
    execAfterBuild(() {
      ref.read(navigationProvider.notifier).update('fitting');
    });
  }

  @override
  Widget build(BuildContext context) {
    var booking = FirebaseAuth.instance.currentUser != null
        ? (ref.watch(userChangeNotifierProvider).userData as UserModelFyd).type == "ProfilType.creator"
            ? ref.watch(bookingProvider).getBookingByCreatorId(FirebaseAuth.instance.currentUser!.uid)
            : ref.watch(bookingProvider).getBookingByOwnerId(FirebaseAuth.instance.currentUser!.uid)
        : null;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: formatWidth(23)).copyWith(left: formatWidth(30)),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sh(47),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('title.fitting-title'.tr(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: sp(25),
                          fontWeight: FontWeight.bold,
                          fontFamily: "PlayfairDisplay")),
                  sh(4),
                  Text(
                    'title.fitting-subtitle'.tr(),
                    style: AppThemeStyle.subtitle,
                  ),
                ],
              ),
              if (FirebaseAuth.instance.currentUser != null) ...[
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
              ],
            ],
          ),
          sh(16),
          if (FirebaseAuth.instance.currentUser != null) ...[
            Text(
              () {
                var tmp = booking?.length ?? 0;
                return tmp.toString() + (tmp > 1 ? ' ' + 'title.fittings-todo'.tr() : ' ' + 'title.fitting-todo'.tr());
              }(),
              style: TextStyle(
                  color: Colors.black, fontSize: sp(16), fontWeight: FontWeight.bold, fontFamily: "PlayfairDisplay"),
            ),
          ],
          sh(9),
          Expanded(
            child: booking != null
                ? ListView.separated(
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    clipBehavior: Clip.hardEdge,
                    padding: EdgeInsets.symmetric(vertical: formatHeight(18)),
                    itemBuilder: ((context, index) {
                      return (ref.watch(userChangeNotifierProvider).userData as UserModelFyd).type ==
                              "ProfilType.creator"
                          ? _fittingWidgetCreator(booking: booking[index])
                          : _fittingWidget(booking: booking[index]);
                    }),
                    separatorBuilder: ((context, index) => sh(7)),
                    itemCount: booking.length)
                : Center(
                    child: Text(
                    'utils.need-connection'.tr(),
                    textAlign: TextAlign.center,
                  )),
          ),
          sh(90)
        ],
      ),
    );
  }

  _fittingWidgetCreator({required BookingModel booking}) {
    UserInfoModel? creator = booking.creatorInfo;
    // var creator = ref.watch(userModelProvider).getModelById(booking.creatorId!);
    // var product = booking.productId != null ? ref.watch(productProvider).getProductById(booking.productId!) : null;
    return Container(
      padding: EdgeInsets.symmetric(vertical: formatHeight(18), horizontal: formatWidth(17)),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.r), boxShadow: [
        BoxShadow(color: const Color(0xFF000000).withOpacity(.04), offset: const Offset(0, 10), blurRadius: 30)
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (booking.productName != null) ...[
                Text(booking.productName!.toCapitalized() + ' - ', style: AppThemeStyle.fittingTitle)
              ],
              Text((creator!.lastname! + ' ' + creator.firstname!), style: AppThemeStyle.fittingTitle),
            ],
          ),
          sh(4),
          Text("Le ${formatDate.format(booking.bookingDate!)}", style: AppThemeStyle.fittingSubtitle),
          sh(10),
          const Divider(),
          sh(10),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    booking.creatorInfo!.profilImage == null
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
                            radius: 14.r,
                            backgroundImage: CachedNetworkImageProvider(booking.creatorInfo!.profilImage!),
                          ),
                    sw(6),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            creator.shopName!,
                            style: AppThemeStyle.fittingSecTitle,
                          ),
                          Text(
                            creator.location!.formattedText!,
                            style: AppThemeStyle.fittingSecSubtitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              sw(2),
              CTA.primary(
                width: formatWidth(110),
                height: formatHeight(34),
                textButton: 'title.fittings-cancel'.tr(),
                textButtonStyle: AppThemeStyle.fittingButton,
                onTap: () {
                  dialogDelteBooking(context, booking.id!);
                },
              )
            ],
          )
        ],
      ),
    );
  }

  _fittingWidget({required BookingModel booking}) {
    UserInfoModel? creator = booking.creatorInfo;
    return Container(
      padding: EdgeInsets.symmetric(vertical: formatHeight(18), horizontal: formatWidth(17)),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.r), boxShadow: [
        BoxShadow(color: const Color(0xFF000000).withOpacity(.04), offset: const Offset(0, 10), blurRadius: 30)
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (booking.productName != null) ...[
                Text(booking.productName!.toCapitalized() + ' - ', style: AppThemeStyle.fittingTitle)
              ],
              Text((booking.creatorInfo!.shopName!), style: AppThemeStyle.fittingTitle),
            ],
          ),
          Text("Le ${formatDate.format(booking.bookingDate!)}", style: AppThemeStyle.fittingSubtitle),
          sh(12),
          const Divider(),
          sh(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    creator!.profilImage != null
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
                            radius: 14.r,
                            backgroundImage: CachedNetworkImageProvider(creator.profilImage!),
                          ),
                    sw(6),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            creator.shopName!,
                            style: AppThemeStyle.fittingSecTitle,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Text(
                              creator.location!.formattedText!,
                              style: AppThemeStyle.fittingSecSubtitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              CTA.primary(
                width: formatWidth(121),
                height: formatHeight(34),
                textButton: 'title.fittings-cancel'.tr(),
                textButtonStyle: AppThemeStyle.fittingButton,
                onTap: () {
                  dialogDelteBooking(context, booking.id!);
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  dialogDelteBooking(BuildContext context, String bookingId) async {
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
                        sh(11),
                        Text(
                          "title.careful-text-booking".tr(),
                          style: AppThemeStyle.dialogSubTitle,
                          textAlign: TextAlign.center,
                        ),
                        sh(32),
                        InkWell(
                          onTap: () async {
                            if ((ref.watch(userChangeNotifierProvider).userData! as UserModelFyd).type ==
                                "ProfilType.creator") {
                              ref.read(bookingProvider).removeBooking(bookingId, isCreator: true);
                            } else {
                              ref.read(bookingProvider).removeBooking(bookingId);
                            }
                            Navigator.of(_).pop();
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
