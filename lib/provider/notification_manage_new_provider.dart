import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:findyourdresse_app/controller/notification_controller.dart';
import 'package:findyourdresse_app/model/_enum/_booking_state.dart';
import 'package:findyourdresse_app/model/notification_fyd/notificationfydmodel.dart';
import 'package:findyourdresse_app/model/user_info_model/user_info_model.dart';
import 'package:findyourdresse_app/model/user_model_fyd/user_model_fyd.dart';
import 'package:findyourdresse_app/provider/booking_provider.dart';
import 'package:findyourdresse_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';
import '../model/_enum/_notification_state.dart';

final notificationManageNewProvider = ChangeNotifierProvider.autoDispose.family<NotificationManageNew, String>((ref, id) {
  return NotificationManageNew(ref, id);
});

class NotificationManageNew with ChangeNotifier {
  // ignore: unused_field
  final AutoDisposeChangeNotifierProviderRef _ref;
  final String id;

  late List<NotificationFydModel> _notifications;
  StreamSubscription? notificationStream;

  NotificationManageNew(this._ref, this.id) {
    _notifications = [];
    notificationStream = FirebaseFirestore.instance.collection("users").doc(id).collection('notifications').snapshots().listen((event) {
      for (final e in event.docChanges) {
        switch (e.type) {
          case DocumentChangeType.added:
            _notifications.add(NotificationFydModel.fromJson(e.doc.data()!).copyWith(id: e.doc.id));
            break;
          case DocumentChangeType.modified:
            final index = notifications.indexWhere((element) => element.id == e.doc.id);
            if (index == -1) return;
            _notifications[index] = NotificationFydModel.fromJson(e.doc.data()!).copyWith(id: e.doc.id);
            break;
          case DocumentChangeType.removed:
            _notifications.removeWhere((element) => element.id == e.doc.id);
            break;
        }
        _notifications.sort((a, b) => b.sendAt!.compareTo(a.sendAt!));
        notifyListeners();
      }
    });
  }

  List<NotificationFydModel> get notifications => _notifications;
  bool? get modelhasNotification => notifications.where((element) => element.seenByReceiver == false).isNotEmpty;

  bool? get hasNotification => notifications.where((element) => element.seen == false).isNotEmpty;

  int get notificationsLength => notifications.length;

  Future<void> updateSeenNotification(List<NotificationFydModel> notifications) async {
    for (final notification in notifications) {
      await NotificationFydController.updateNotification(notification.copyWith(seen: true));
    }
  }

  Future<void> declineNotification(NotificationFydModel notification) async {
    await NotificationFydController.deleteNotification(notification);
    await NotificationFydController.addNotification(NotificationFydModel(
      message: "content.decline-request-message-client".tr(),
      userInfo: UserInfoModel.fromUserFydModel(_ref.read(userChangeNotifierProvider).userData as UserModelFyd),
      state: NotificationState.decline,
      receiverId: notification.senderId,
      senderId: notification.receiverId,
      sendAt: DateTime.now(),
    ));
  }

  Future<void> proposeSlot(NotificationFydModel notification) async {
    await NotificationFydController.deleteNotification(notification);
    await NotificationFydController.addNotification(
      notification.copyWith(
        message: "content.discover-slot-available".tr(),
        state: NotificationState.propose,
        receiverId: notification.senderId,
        senderId: notification.receiverId,
        sendAt: DateTime.now(),
        userInfo: UserInfoModel.fromUserFydModel(_ref.read(userChangeNotifierProvider).userData as UserModelFyd),
      ),
    );
  }

  Future<void> cancelNotification(NotificationFydModel notification) async {
    await NotificationFydController.deleteNotification(notification);
    await NotificationFydController.addNotification(
      notification.copyWith(
        message: "content.cancel-notification".tr(),
        state: NotificationState.cancel,
        receiverId: notification.senderId,
        senderId: notification.receiverId,
        sendAt: DateTime.now(),
        userInfo: UserInfoModel.fromUserFydModel(_ref.read(userChangeNotifierProvider).userData as UserModelFyd),
      ),
    );
  }

  Future<void> acceptSlot(NotificationFydModel notification, DateTime? validateSlot) async {
    await NotificationFydController.deleteNotification(notification);

    String? bookingId = await _ref.read(bookingProvider).addBooking(notification.booking!.copyWith(
          bookingDate: validateSlot,
          creatorId: notification.senderId,
          requestorId: notification.receiverId,
          productId: notification.booking?.productId,
          requestorInfo: UserInfoModel.fromUserFydModel(_ref.read(userChangeNotifierProvider).userData as UserModelFyd),
          creatorInfo: UserInfoModel.fromUserFydModel(_ref.read(userModelProvider).getModelById(notification.senderId!)!),
        ));

    await NotificationFydController.addNotification(
      notification.copyWith(
        booking: notification.booking!.copyWith(
          state: BookingState.validate,
          acceptDate: validateSlot,
          id: bookingId,
        ),
        message: "content.accept-message".tr(),
        state: NotificationState.accept,
        receiverId: notification.senderId,
        senderId: notification.receiverId,
        sendAt: DateTime.now(),
        userInfo: UserInfoModel.fromUserFydModel(_ref.read(userChangeNotifierProvider).userData as UserModelFyd),
      ),
    );
  }

  Future<void> askForSlot(NotificationFydModel notification, String? message) async {
    await NotificationFydController.deleteNotification(notification);
    await NotificationFydController.addNotification(
      notification.copyWith(
        message: "content.more-slot".tr(),
        userMessage: message,
        state: NotificationState.newRequest,
        receiverId: notification.senderId,
        senderId: notification.receiverId,
        sendAt: DateTime.now(),
        userInfo: UserInfoModel.fromUserFydModel(_ref.read(userChangeNotifierProvider).userData as UserModelFyd),
      ),
    );
  }

  Future<void> createNotificationNew({
    required NotificationFydModel notification,
  }) async {
    await NotificationFydController.addNotification(notification);
  }

  Future<void> updateNotification({
    required NotificationFydModel notification,
  }) async {
    await NotificationFydController.updateNotification(notification);
    //notification au client
    // await createNotificationNew(notification: notification.copyWith(forWhoId: notification.requestorId, message: "content.decline-request-message-client".tr(), requestorInfo: UserInfoModel.fromUserFydModel(_ref.read(userChangeNotifierProvider).userData as UserModelFyd)));
  }

  @override
  void dispose() {
    notificationStream?.cancel();
    super.dispose();
  }

  // Future<void> declineNotification({required notificationId, required userId}) async {
  //   await FirebaseFirestore.instance.collection('users').doc(userId).collection("notifications").doc(notificationId).update({
  //     'metadata.state': NotificationState.decline.label,
  //     "seenByUser": false,
  //   });
  // }
}
