import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:findyourdresse_app/model/notification_fyd/notificationfydmodel.dart';
import 'package:findyourdresse_app/provider/notification_manage_new_provider.dart';
import 'package:findyourdresse_app/widget/notification/notification_card_template.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';
import '../../../config/theme.dart';

class NotificationNewPage extends ConsumerStatefulWidget {
  const NotificationNewPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NotificationNewPageState();
}

class _NotificationNewPageState extends ConsumerState<NotificationNewPage> {
  Future<void> seenNotif(List<NotificationFydModel> notification) async {
    ref.read(notificationManageNewProvider(FirebaseAuth.instance.currentUser!.uid)).updateSeenNotification(notification);
  }

  @override
  Widget build(BuildContext context) {
    List<NotificationFydModel> notifications = ref.watch(notificationManageNewProvider(FirebaseAuth.instance.currentUser!.uid)).notifications;
    seenNotif(notifications);
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: formatHeight(51), horizontal: formatWidth(28)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Stack(
                alignment: AlignmentDirectional.centerStart,
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    child: Text(
                      'content.notification-title'.tr(),
                      style: AppThemeStyle.descriptionSubtitle.copyWith(fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(-formatWidth(10), 0),
                    child: CTA.back(
                      height: 50,
                      width: 50,
                      onTap: () {
                        AutoRouter.of(context).navigateBack();
                      },
                    ),
                  ),
                ],
              ),
            ),
            sh(21),
            notifications.isNotEmpty
                ? ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: ((context, index) {
                      NotificationFydModel notification = notifications[index];
                      return NotificationCardTemplate(notification: notification);
                    }),
                    separatorBuilder: ((context, index) => Padding(
                          padding: EdgeInsets.symmetric(vertical: formatHeight(10)),
                          child: const Divider(),
                        )),
                    itemCount: notifications.length)
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      sh(300),
                      Center(
                        child: Text('content.notification-empty'.tr()),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
