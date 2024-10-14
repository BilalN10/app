// import 'package:auto_route/auto_route.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:findyourdresse_app/routes/app_router.gr.dart';
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:skeleton_kosmos/skeleton_kosmos.dart';
// import 'package:timeago_flutter/timeago_flutter.dart';
// import 'package:ui_kosmos_v4/cta/theme.dart';
// import '../../model/notification_fyd/notificationfydmodel.dart';
// import '../../model/product_model/productmodel.dart';

// final formatDate = DateFormat('dd/MM/yyyy hh:mm');

// class NotificationCardOffer extends ConsumerStatefulWidget {
//   final NotificationFydModel notification;
//   final ProductModel? product;
//   const NotificationCardOffer({super.key, required this.notification, this.product});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _NotificationCardOfferState();
// }

// class _NotificationCardOfferState extends ConsumerState<NotificationCardOffer> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           height: formatHeight(42),
//           width: formatWidth(42),
//           decoration: const BoxDecoration(shape: BoxShape.circle),
//           clipBehavior: Clip.hardEdge,
//           child: CachedNetworkImage(
//               imageUrl: widget.notification.creatorInfo!.profilImage!,
//               fit: BoxFit.cover,
//               placeholderFadeInDuration: const Duration(seconds: 2),
//               placeholder: (_, __) => Shimmer(
//                   child: Container(
//                     width: formatWidth(42),
//                     height: formatHeight(42),
//                     clipBehavior: Clip.hardEdge,
//                     decoration: const BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.white,
//                     ),
//                   ),
//                   gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [Colors.grey.shade100, Colors.grey]))),
//         ),
//         sw(19),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text('${widget.notification.creatorInfo!.shopName}', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: sp(17), fontFamily: 'PlayfairDisplay')),
//                   Timeago(
//                       builder: ((context, str) => Text(
//                             str,
//                             style: const TextStyle(color: Color(0xff737D8A)),
//                           )),
//                       date: DateTime.now().subtract(const Duration(minutes: 5)),
//                       locale: 'fr_short'),
//                 ],
//               ),
//               Text(
//                 widget.notification.message!,
//                 style: TextStyle(color: const Color(0xff737D8A), fontSize: sp(12), fontWeight: FontWeight.w500),
//               ),
//               if (widget.product != null) ...[
//                 Text(
//                   "Produit : ${widget.product!.name}",
//                   style: TextStyle(color: const Color(0xff737D8A), fontSize: sp(12), fontWeight: FontWeight.w500),
//                 ),
//               ],
//               sh(24),
//               Row(children: [
//                 InkWell(
//                   onTap: () {},
//                   child: Container(
//                     width: formatWidth(110),
//                     padding: EdgeInsets.only(right: formatWidth(20)),
//                     child: Text(
//                       'content.cancel-mine'.tr(),
//                       style: TextStyle(color: Colors.black, fontSize: sp(12), fontWeight: FontWeight.w500),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: CTA.primary(
//                     onTap: () {
//                       AutoRouter.of(context).navigate(ChooseSlotRoute(notification: widget.notification, product: widget.product));
//                     },
//                     height: formatHeight(34),
//                     textButtonStyle: TextStyle(color: Colors.white, fontSize: sp(12), fontWeight: FontWeight.w600),
//                     textButton: 'content.see-slot'.tr(),
//                   ),
//                 )
//               ])
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
