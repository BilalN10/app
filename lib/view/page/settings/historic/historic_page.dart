import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:findyourdresse_app/config/theme.dart';
import 'package:findyourdresse_app/model/user_model_fyd/user_model_fyd.dart';
import 'package:findyourdresse_app/provider/booking_provider.dart';
import 'package:findyourdresse_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';

import '../../../../model/_enum/_notification_state.dart';
import '../../../../model/booking_model/bookingmodel.dart';
import '../../../../provider/product_provider.dart';
import '../../../../provider/user_provider.dart';

class HistoricPage extends ConsumerStatefulWidget {
  const HistoricPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HistoricPageState();
}

class _HistoricPageState extends ConsumerState<HistoricPage> {
  final formatDate = DateFormat("dd/MM/y à HH'h'mm");

  @override
  Widget build(BuildContext context) {
    var booking = (ref.watch(userChangeNotifierProvider).userData as UserModelFyd).type == "ProfilType.creator"
        ? ref.watch(bookingProvider).getHistoricgByCreatorId(FirebaseAuth.instance.currentUser!.uid)
        : ref.watch(bookingProvider).getHistoricByOwnerId(FirebaseAuth.instance.currentUser!.uid);

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: formatWidth(23)),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sh(47),
          SizedBox(
            width: double.infinity,
            child: Stack(
              alignment: AlignmentDirectional.centerStart,
              children: [
                CTA.back(
                  height: 50,
                  width: 50,
                  onTap: () {
                    AutoRouter.of(context).navigateBack();
                  },
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'title.historic.title'.tr(),
                    style: AppThemeStyle.homeSecondTitle,
                  ),
                  Text(
                    'title.historic.subtitle'.tr(),
                    style: AppThemeStyle.subtitle,
                  ),
                ],
              ),
            ],
          ),
          sh(9),
          Expanded(
            child: ListView.separated(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                clipBehavior: Clip.hardEdge,
                padding: EdgeInsets.symmetric(vertical: formatHeight(18)),
                itemBuilder: ((context, index) {
                  return (ref.watch(userChangeNotifierProvider).userData as UserModelFyd).type == "ProfilType.creator"
                      ? _fittingWidgetCreator(booking: booking[index])
                      : _fittingWidget(booking: booking[index]);
                }),
                separatorBuilder: ((context, index) => sh(6)),
                itemCount: booking.length),
          ),
          sh(90)
        ],
      ),
    );
  }

  _fittingWidgetCreator({required BookingModel booking}) {
    UserModelFyd? creator = ref.watch(userModelProvider).getModelById(booking.creatorInfo!.id!);
    var product = booking.productId != null ? ref.watch(productProvider).getProductById(booking.productId!) : null;
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
              if (product != null) ...[Text(product.name!.toCapitalized() + ' - ', style: AppThemeStyle.fittingTitle)],
              Text((booking.creatorInfo!.lastname! + ' ' + booking.creatorInfo!.firstname!),
                  style: AppThemeStyle.fittingTitle),
            ],
          ),
          Text("Le ${formatDate.format(booking.bookingDate!)}", style: AppThemeStyle.fittingSubtitle),
          sh(12),
          const Divider(),
          sh(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  creator!.profilImage == null
                      ? Container(
                          width: formatWidth(28),
                          height: formatWidth(28),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        creator.shopNickname!,
                        style: AppThemeStyle.fittingSecTitle,
                      ),
                      Text(
                        creator.location!.formattedText!,
                        style: AppThemeStyle.fittingSecSubtitle,
                      ),
                    ],
                  )
                ],
              ),
              Text(
                'title.finished-fitting'.tr(),
                style: AppThemeStyle.fittingSecTitle,
              )
            ],
          )
        ],
      ),
    );
  }

  _fittingWidget({required BookingModel booking}) {
    var creator = booking.creatorInfo;
    var product = booking.productId != null ? ref.watch(productProvider).getProductById(booking.productId!) : null;

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
              if (product != null) ...[Text(product.name!.toCapitalized() + ' - ', style: AppThemeStyle.fittingTitle)],
              Text((creator!.shopName!), style: AppThemeStyle.fittingTitle),
            ],
          ),
          Text("Le ${formatDate.format(booking.bookingDate!)}", style: AppThemeStyle.fittingSubtitle),
          sh(12),
          const Divider(),
          sh(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  creator.profilImage == null
                      ? Container(
                          width: formatWidth(28),
                          height: formatWidth(28),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        creator.shopName!,
                        style: AppThemeStyle.fittingSecTitle,
                      ),
                      Text(
                        creator.location!.formattedText!,
                        style: AppThemeStyle.fittingSecSubtitle,
                      ),
                    ],
                  )
                ],
              ),
              Text(
                'title.finished-fitting'.tr(),
                style: AppThemeStyle.fittingSecTitle,
              )
            ],
          )
        ],
      ),
    );
  }
}
