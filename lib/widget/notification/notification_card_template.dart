import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:findyourdresse_app/config/theme.dart';
import 'package:findyourdresse_app/model/_enum/_notification_state.dart';
import 'package:findyourdresse_app/model/notification_fyd/notificationfydmodel.dart';
import 'package:findyourdresse_app/provider/notification_manage_new_provider.dart';
import 'package:findyourdresse_app/routes/app_router.gr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';
import 'package:timeago_flutter/timeago_flutter.dart';
import 'package:ui_kosmos_v4/cta/theme.dart';

class NotificationCardTemplate extends ConsumerStatefulWidget {
  final NotificationFydModel notification;

  const NotificationCardTemplate({super.key, required this.notification});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NotificationCardTemplateState();
}

class _NotificationCardTemplateState extends ConsumerState<NotificationCardTemplate> {
  final formatDate = DateFormat('dd/MM/yyyy hh:mm');
  final formatDate2 = DateFormat("'Le' dd/MM/yyyy 'à' hh:mm");

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: formatHeight(42),
                width: formatWidth(42),
                decoration: const BoxDecoration(shape: BoxShape.circle),
                clipBehavior: Clip.hardEdge,
                child: CachedNetworkImage(
                    imageUrl: widget.notification.userInfo!.profilImage!,
                    fit: BoxFit.cover,
                    placeholderFadeInDuration: const Duration(seconds: 2),
                    placeholder: (_, __) => Shimmer(
                        child: Container(
                          width: formatWidth(42),
                          height: formatHeight(42),
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                        gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [Colors.grey.shade100, Colors.grey]))),
              ),
              sw(19),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${widget.notification.userInfo!.firstname} ${widget.notification.userInfo!.lastname}', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: sp(17), fontFamily: 'PlayfairDisplay')),
                        Timeago(
                            builder: ((context, str) => Text(
                                  str,
                                  style: const TextStyle(color: Color(0xff737D8A)),
                                )),
                            date: widget.notification.sendAt!,
                            locale: 'fr_short'),
                      ],
                    ),
                    Text(
                      widget.notification.message!,
                      style: TextStyle(color: const Color(0xff737D8A), fontSize: sp(12), fontWeight: FontWeight.w500),
                    ),
                    if (widget.notification.booking?.productName != null) ...[
                      Text(
                        "Produit : ${widget.notification.booking!.productName}",
                        style: TextStyle(color: const Color(0xff737D8A), fontSize: sp(12), fontWeight: FontWeight.w500),
                      ),
                    ],
                    if (widget.notification.state == NotificationState.accept) ...[
                      Text(
                        "Créneau confirmé : ${formatDate2.format(widget.notification.booking!.acceptDate!)}",
                        style: TextStyle(color: const Color(0xff737D8A), fontSize: sp(12), fontWeight: FontWeight.w500),
                      ),
                    ],
                    if (widget.notification.state == NotificationState.request || widget.notification.state == NotificationState.newRequest) ...[
                      if (widget.notification.state == NotificationState.request) ...[
                        Text(
                          "Date souhaitée : ${formatDate.format(widget.notification.requestAt!)}",
                          style: TextStyle(color: const Color(0xff737D8A), fontSize: sp(12), fontWeight: FontWeight.w500),
                        ),
                        Row(
                          children: [
                            Text(
                              "Taille de vêtement : ",
                              style: TextStyle(color: const Color(0xff737D8A), fontSize: sp(12), fontWeight: FontWeight.w500),
                            ),
                            Expanded(
                                child: Wrap(
                                    children: widget.notification.booking!.sizeList!
                                        .map((e) => Text(e + (widget.notification.booking!.sizeList!.indexOf(e) == widget.notification.booking!.sizeList!.length - 1 ? '.' : ', '), style: TextStyle(color: const Color(0xff737D8A), fontSize: sp(12), fontWeight: FontWeight.w500)))
                                        .toList())),
                          ],
                        ),
                        Text(
                          "Nombre de robe recherché : ${widget.notification.booking?.robeNumberResearch}.",
                          style: TextStyle(color: const Color(0xff737D8A), fontSize: sp(12), fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Type de robe recherché :",
                          style: TextStyle(color: const Color(0xff737D8A), fontSize: sp(12), fontWeight: FontWeight.w500),
                        ),
                        Wrap(
                            children: widget.notification.booking!.typeList!
                                .map((e) => Text(e + (widget.notification.booking!.typeList!.indexOf(e) == widget.notification.booking!.typeList!.length - 1 ? '.' : ', '), style: TextStyle(color: const Color(0xff737D8A), fontSize: sp(12), fontWeight: FontWeight.w500)))
                                .toList()),
                        ReadMoreText(
                          "Message : ${widget.notification.booking?.userMessage}.",
                          trimLines: 2,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'utils.seemore'.tr(),
                          trimExpandedText: 'utils.seeless'.tr(),
                          style: TextStyle(color: const Color(0xff737D8A), fontSize: sp(12), fontWeight: FontWeight.w500),
                          moreStyle: TextStyle(fontSize: sp(11), fontWeight: FontWeight.w400, color: AppColor.linearFirst),
                          lessStyle: TextStyle(fontSize: sp(11), fontWeight: FontWeight.w400, color: AppColor.linearFirst),
                        ),
                      ],
                      if (widget.notification.state == NotificationState.newRequest && widget.notification.userMessage != null) ...[
                        ReadMoreText(
                          "Message : ${widget.notification.userMessage}.",
                          trimLines: 2,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'utils.seemore'.tr(),
                          trimExpandedText: 'utils.seeless'.tr(),
                          style: TextStyle(color: const Color(0xff737D8A), fontSize: sp(12), fontWeight: FontWeight.w500),
                          moreStyle: TextStyle(fontSize: sp(11), fontWeight: FontWeight.w400, color: AppColor.linearFirst),
                          lessStyle: TextStyle(fontSize: sp(11), fontWeight: FontWeight.w400, color: AppColor.linearFirst),
                        ),
                      ],
                      sh(widget.notification.state == NotificationState.request ? 42 : 18),
                      Row(children: [
                        CTA.tiers(
                          onTap: () async {
                            await ref.read(notificationManageNewProvider(FirebaseAuth.instance.currentUser!.uid)).declineNotification(widget.notification);
                          },
                          theme: CtaThemeData(
                            constraints: BoxConstraints(minWidth: formatWidth(60), minHeight: formatHeight(34)),
                          ),
                          textButtonStyle: TextStyle(color: Colors.black, fontSize: sp(12), fontWeight: FontWeight.w500),
                          textButton: 'content.decline'.tr(),
                        ),
                        Expanded(
                          child: CTA.primary(
                            onTap: () {
                              AutoRouter.of(context).navigate(OfferSlotsRoute(notification: widget.notification));
                            },
                            height: formatHeight(34),
                            textButtonStyle: TextStyle(color: Colors.white, fontSize: sp(12), fontWeight: FontWeight.w600),
                            textButton: widget.notification.state == NotificationState.request ? 'content.offer-slots'.tr() : "content.button-new-request".tr(),
                          ),
                        )
                      ])
                    ],
                    if (widget.notification.state == NotificationState.propose) ...[
                      sh(24),
                      Row(children: [
                        InkWell(
                          onTap: () async {
                            await ref.read(notificationManageNewProvider(FirebaseAuth.instance.currentUser!.uid)).cancelNotification(widget.notification);
                          },
                          child: Container(
                            width: formatWidth(110),
                            padding: EdgeInsets.only(right: formatWidth(20)),
                            child: Text(
                              'content.cancel-mine'.tr(),
                              style: TextStyle(color: Colors.black, fontSize: sp(12), fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Expanded(
                          child: CTA.primary(
                            onTap: () {
                              AutoRouter.of(context).navigate(ChooseSlotRoute(notification: widget.notification));
                            },
                            height: formatHeight(34),
                            textButtonStyle: TextStyle(color: Colors.white, fontSize: sp(12), fontWeight: FontWeight.w600),
                            textButton: 'content.see-slot'.tr(),
                          ),
                        )
                      ])
                    ],
                  ],
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
