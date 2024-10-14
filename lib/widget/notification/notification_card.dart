import 'package:cached_network_image/cached_network_image.dart';
import 'package:core_kosmos/core_kosmos.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:findyourdresse_app/model/_enum/_notification_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeago_flutter/timeago_flutter.dart';
import '../../config/theme.dart';
import '../../model/notification_fyd/notificationfydmodel.dart';

final formatDate = DateFormat('dd/MM/yyyy hh:mm');

class NotificationCard extends ConsumerStatefulWidget {
  final NotificationFydModel notification;
  const NotificationCard({super.key, required this.notification});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NotificationCardState();
}

class _NotificationCardState extends ConsumerState<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                    ],
                  ),
                  Text(
                    widget.notification.message!,
                    style: TextStyle(color: const Color(0xff737D8A), fontSize: sp(12), fontWeight: FontWeight.w500),
                  ),
                  if (widget.notification.booking?.productName != null) ...[
                    Text(
                      "Produit : ${widget.notification.booking?.productName}",
                      style: TextStyle(color: const Color(0xff737D8A), fontSize: sp(12), fontWeight: FontWeight.w500),
                    ),
                  ],
                  Text(
                    "Date souhaitée : ${formatDate.format(widget.notification.requestAt!)}",
                    style: TextStyle(color: const Color(0xff737D8A), fontSize: sp(12), fontWeight: FontWeight.w500),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                    "Message : ${widget.notification.booking!.userMessage}.",
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'utils.seemore'.tr(),
                    trimExpandedText: 'utils.seeless'.tr(),
                    style: TextStyle(color: const Color(0xff737D8A), fontSize: sp(12), fontWeight: FontWeight.w500),
                    moreStyle: TextStyle(fontSize: sp(11), fontWeight: FontWeight.w400, color: AppColor.linearFirst),
                    lessStyle: TextStyle(fontSize: sp(11), fontWeight: FontWeight.w400, color: AppColor.linearFirst),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
