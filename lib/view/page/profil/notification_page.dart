import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:findyourdresse_app/config/theme.dart';
import 'package:findyourdresse_app/model/_enum/_notification_state.dart';
import 'package:findyourdresse_app/model/user_model_fyd/user_model_fyd.dart';
import 'package:findyourdresse_app/provider/notification_manage_provider.dart';
import 'package:findyourdresse_app/provider/notifications_user.dart';
import 'package:findyourdresse_app/provider/product_provider.dart';
import 'package:findyourdresse_app/provider/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notification_kosmos/notification_kosmos.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';

class NotificationPage extends ConsumerStatefulWidget {
  const NotificationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NotificationPageState();
}

class _NotificationPageState extends ConsumerState<NotificationPage> {
  final formatDate = DateFormat("dd/MM/y à HH'h'mm");
  List<NotificationDataModel> notification = [];

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<NotificationDataModel> notifications =
        ref.watch(notificationManageProvider(FirebaseAuth.instance.currentUser!.uid)).notifications;

    return notifications.map<DateTime?>((e) => e.sendAt).toList().contains(null)
        ? const SizedBox()
        : NotificationWidget(
            onBackButtonPressed: () {
              AutoRouter.of(context).pop();
            },
            pageName: 'title.asking-fitting'.tr(),
            pageTitleTextStyle: AppThemeStyle.notificationTitle,
            usernameTextStyle: TextStyle(
                color: Colors.black, fontSize: sp(17), fontWeight: FontWeight.w600, fontFamily: 'PlayfairDisplay'),
            notificationTypeTextStyle: AppThemeStyle.textNotification,
            isBackButton: true,
            ctaBackButtonClr: Colors.white,
            profilePicture: true,
            notifications: notifications
                .map((e) => e.metadata!["creatorId"] != FirebaseAuth.instance.currentUser!.uid
                    ? NotificationModel(
                        onClick: () {},
                        notificationDataModel: e.copyWith(
                          message: e.metadata!["state"] == "envoyé"
                              ? "Votre demande d'essayage a été envoyé"
                              : e.metadata!["state"] == "accepté"
                                  ? "Votre demande d'essayage a été accepté"
                                  : e.metadata!["state"] == "refusé"
                                      ? "Votre demande d'essayage a été refusé"
                                      : "",
                          user: NotificationUserDataModel(
                            id: FirebaseAuth.instance.currentUser!.uid,
                            firstname:
                                (ref.watch(userModelProvider).getModelById(e.metadata!['creatorId']) as UserModelFyd)
                                    .shopNickname,
                            lastname: "",
                            picture:
                                (ref.watch(userModelProvider).getModelById(e.metadata!['creatorId']) as UserModelFyd)
                                    .profilImage,
                          ),
                        ))
                    : NotificationModel(
                        onClick: () {},
                        notificationDataModel: e,
                        notificationChildBuilder: (_, __) => _builder(_, __, e),
                      ))
                .toList(),
            // ref.watch(userModelProvider).getModelById(FirebaseAuth.instance.currentUser!.uid)!.type !=
            //         "ProfilType.creator"
            //     ? ref
            //         .watch(notificationsNormalUser)
            //         .notifications
            //         .map((e) => NotificationModel(
            //             onClick: () {},
            //             notificationDataModel: e.copyWith(
            //               message: e.metadata!["state"] == "envoyé"
            //                   ? "Votre demande d'essayage a été envoyé"
            //                   : e.metadata!["state"] == "accepté"
            //                       ? "Votre demande d'essayage a été accepté"
            //                       : e.metadata!["state"] == "refusé"
            //                           ? "Votre demande d'essayage a été refusé"
            //                           : "",
            //               user: NotificationUserDataModel(
            //                 id: FirebaseAuth.instance.currentUser!.uid,
            //                 firstname: (ref.watch(userModelProvider).getModelById(e.metadata!['creatorId']) as UserModelFyd)
            //                     .shopNickname,
            //                 lastname: "",
            //                 picture: (ref.watch(userModelProvider).getModelById(e.metadata!['creatorId']) as UserModelFyd)
            //                     .profilImage,
            //               ),
            //             )))
            //         .toList()
            //     : ref
            //         .watch(notificationProvider)
            //         .data
            //         .map((e) => NotificationModel(
            //               onClick: () {},
            //               notificationDataModel: e,
            //               notificationChildBuilder: (_, __) => _builder(_, __, e),
            //             ))
            //         .toList(),
          );
  }

  Widget _builder(BuildContext buildContext, WidgetRef _, NotificationDataModel e) {
    if (e.metadata!['state'] == NotificationState.slotRequest.label) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (e.metadata!['productId'] != 'null') ...[
            Text(
              "${'title.product'.tr()} ${ref.watch(productProvider).getProductById(e.metadata!['productId'])!.name ?? ''}  - ${ref.watch(userModelProvider).getModelById(e.metadata!['creatorId'])?.shopNickname ?? ''}",
              style: AppThemeStyle.textNotification,
            ),
          ],
          if (e.metadata!['date'] != null) ...[
            Text(
              'Date souhaitée : Le ${formatDate.format(e.metadata!['date'].toDate())}',
              style: AppThemeStyle.textNotification,
            ),
          ],
          if (e.metadata!['sizeList'] != null) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Taille vêtement : ',
                  style: AppThemeStyle.textNotification,
                ),
                Expanded(
                  child: Wrap(
                    children: e.metadata!['sizeList']
                        .map<Widget>(
                          (element) => Text(
                              element.toString() +
                                  (e.metadata!['sizeList'].indexOf(element) == (e.metadata!['sizeList'].length - 1)
                                      ? '.'
                                      : ', '),
                              style: AppThemeStyle.textNotification),
                        )
                        .toList(),
                  ),
                )
              ],
            ),
          ],
          if (e.metadata!['robeNumberlookingFor'] != null) ...[
            Text(
              'Nombre de robe recherchés : ${e.metadata!['robeNumberlookingFor']}',
              style: AppThemeStyle.textNotification,
            ),
          ],
          if (e.metadata!['typeList'] != null) ...[
            Text(
              'Types de robe recherché : ',
              style: AppThemeStyle.textNotification,
            ),
            Wrap(
              children: e.metadata!['typeList']
                  .map<Widget>((element) => Text(
                      element.toString() +
                          (e.metadata!['typeList'].indexOf(element) == (e.metadata!['typeList'].length - 1)
                              ? '.'
                              : ', '),
                      style: AppThemeStyle.textNotification))
                  .toList(),
            ),
          ],
          if (e.metadata!['userMessage'] != null) ...[
            Text(
              'Message :' + e.metadata!['userMessage'],
              style: AppThemeStyle.textNotification,
            ),
          ],
          sh(24),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (e.metadata!['state'] == 'envoyé') ...[
                InkWell(
                    onTap: () {
                      ref
                          .read(notificationManageProvider(e.metadata!['creatorId']))
                          .declineNotification(notificationId: e.id!, userId: e.metadata!['creatorId']);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(14.0).copyWith(left: 0),
                      child: Text(
                        'utils.decline'.tr(),
                        style: AppThemeStyle.declineNotification,
                      ),
                    )),
                sw(16),
                CTA.primary(
                  width: formatWidth(175),
                  textButton: 'utils.accept-reservation'.tr(),
                  textButtonStyle: AppThemeStyle.acceptNotification,
                  onTap: () async {
                    // ref.read(notificationManageProvider(e.metadata!['creatorId'])).acceptNotification(
                    //       notificationId: e.id!,
                    //       ownerId: e.user!.id!,
                    //       creatorId: e.metadata!['creatorId'],
                    //       bookingDate: e.metadata!['date'].toDate(),
                    //       productId: e.metadata!['productId'],
                    //     );
                  },
                )
              ] else if (e.metadata!['state'] == NotificationState.validate.label) ...[
                Text(
                  'utils.accepted'.tr(),
                )
              ] else if (e.metadata!['state'] == NotificationState.decline.label) ...[
                Text(
                  'utils.declined'.tr(),
                )
              ] else if (e.metadata!['state'] == NotificationState.slotRequest.label) ...[
                Text(
                  'utils.declined'.tr(),
                )
              ]
            ],
          )
        ],
      );
    }
    return SizedBox();
  }
}
