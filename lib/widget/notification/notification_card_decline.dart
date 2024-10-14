import 'package:cached_network_image/cached_network_image.dart';
import 'package:core_kosmos/core_kosmos.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeago_flutter/timeago_flutter.dart';
import '../../model/notification_fyd/notificationfydmodel.dart';

final formatDate = DateFormat('dd/MM/yyyy hh:mm');

class NotificationDeclineCard extends ConsumerStatefulWidget {
  final NotificationFydModel notification;
  const NotificationDeclineCard({super.key, required this.notification});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NotificationDeclineCardState();
}

class _NotificationDeclineCardState extends ConsumerState<NotificationDeclineCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container(
        //   height: formatHeight(42),
        //   width: formatWidth(42),
        //   decoration: const BoxDecoration(shape: BoxShape.circle),
        //   clipBehavior: Clip.hardEdge,
        //   child: CachedNetworkImage(
        //       // imageUrl: widget.notification.requestorInfo!.profilImage!,
        //       fit: BoxFit.cover,
        //       placeholderFadeInDuration: const Duration(seconds: 2),
        //       placeholder: (_, __) => Shimmer(
        //           child: Container(
        //             width: formatWidth(42),
        //             height: formatHeight(42),
        //             clipBehavior: Clip.hardEdge,
        //             decoration: const BoxDecoration(
        //               shape: BoxShape.circle,
        //               color: Colors.white,
        //             ),
        //           ),
        //           gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [Colors.grey.shade100, Colors.grey]))),
        // ),
        sw(19),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text('${widget.notification.requestorInfo!.firstname} ${widget.notification.requestorInfo!.lastname}', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: sp(17), fontFamily: 'PlayfairDisplay')),
                  Timeago(
                      builder: ((context, str) => Text(
                            str,
                            style: const TextStyle(color: Color(0xff737D8A)),
                          )),
                      date: DateTime.now().subtract(const Duration(minutes: 5)),
                      locale: 'fr_short'),
                ],
              ),
              Text(
                widget.notification.message!,
                style: TextStyle(color: const Color(0xff737D8A), fontSize: sp(12), fontWeight: FontWeight.w500),
              ),
            ],
          ),
        )
      ],
    );
  }
}
