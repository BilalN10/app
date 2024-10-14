import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notification_kosmos/notification_kosmos.dart';

final notificationsNormalUser = ChangeNotifierProvider<NotificationsUser>((ref) {
  return NotificationsUser(ref);
});

class NotificationsUser with ChangeNotifier {
  // ignore: unused_field
  final ChangeNotifierProviderRef _ref;
  Map<String, NotificationDataModel> _notifications = {};

  List<NotificationDataModel> get notifications {
    List<NotificationDataModel> _list = _notifications.values.toList();

    _list.sort((a, b) => b.sendAt == null
        ? 1
        : a.sendAt == null
            ? -1
            : b.sendAt!.compareTo(a.sendAt!));
    return _list;
  }

  String? homePicture;
  StreamSubscription? homePictureStream;

  NotificationsUser(this._ref);
  void initNotifications() {
    FirebaseFirestore.instance
        .collectionGroup("notifications")
        .where("user.id", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .orderBy("sendAt", descending: true)
        .snapshots()
        .listen((event) {
      for (final e in event.docChanges) {
        switch (e.type) {
          case DocumentChangeType.added:
            _notifications[e.doc.id] = NotificationDataModel.fromJson(e.doc.data()!).copyWith(id: e.doc.id);
            break;
          case DocumentChangeType.modified:
            _notifications[e.doc.id] = NotificationDataModel.fromJson(e.doc.data()!).copyWith(id: e.doc.id);
            break;
          case DocumentChangeType.removed:
            _notifications.remove(e.doc.id);
            break;
        }
        notifyListeners();
      }
    });
  }
}
