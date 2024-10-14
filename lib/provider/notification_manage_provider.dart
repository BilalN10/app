import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:findyourdresse_app/controller/booking_controller.dart';
import 'package:findyourdresse_app/controller/notification_controller.dart';
import 'package:findyourdresse_app/model/booking_model/bookingmodel.dart';
import 'package:findyourdresse_app/model/notification_fyd/notificationfydmodel.dart';
import 'package:findyourdresse_app/model/product_model/productmodel.dart';
import 'package:findyourdresse_app/model/user_model_fyd/user_model_fyd.dart';
import 'package:findyourdresse_app/provider/product_provider.dart';
import 'package:findyourdresse_app/provider/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notification_kosmos/notification_kosmos.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';

import '../model/_enum/_notification_state.dart';
import '../model/user_info_model/user_info_model.dart';

final notificationManageProvider = ChangeNotifierProvider.autoDispose.family<NotificationManageNotifier, String>((ref, id) {
  return NotificationManageNotifier(ref, id);
});

class NotificationManageNotifier with ChangeNotifier {
  // ignore: unused_field
  final AutoDisposeChangeNotifierProviderRef _ref;
  final String id;

  late List<NotificationDataModel> _notifications;
  StreamSubscription? notificationStream;

  NotificationManageNotifier(this._ref, this.id) {
    _notifications = [];
    notificationStream = FirebaseFirestore.instance.collection("users").doc(id).collection('notifications').snapshots().listen((event) {
      for (final e in event.docChanges) {
        switch (e.type) {
          case DocumentChangeType.added:
            _notifications.add(NotificationDataModel.fromJson(e.doc.data()!).copyWith(id: e.doc.id));
            break;
          case DocumentChangeType.modified:
            final index = notifications.indexWhere((element) => element.id == e.doc.id);
            if (index == -1) return;
            _notifications[index] = NotificationDataModel.fromJson(e.doc.data()!).copyWith(id: e.doc.id);
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

  List<NotificationDataModel> get notifications => _notifications;

  List<NotificationDataModel> getNotificationsById() => notifications.where((element) => element.user!.id == id).toList();

  Future<void> declineNotification({required notificationId, required userId}) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).collection("notifications").doc(notificationId).update({
      'metadata.state': NotificationState.decline.label,
      "seenByUser": false,
    });
  }

  // bool getNotificationActiveByOwner() => notifications.where((element) => element.metadata!['creatorId'] == id).where((element) => element.metadata!['state'] == NotificationState.none.label).toList().isEmpty;

  // NotificationDataModel? getPictureById(String id) => notifications.firstWhereOrNull((element) => element.id == id);
  // List<NotificationDataModel> getModelPictures(String id) => notifications.where((element) => element.ownerId == id).toList();
}
