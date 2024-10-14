import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findyourdresse_app/model/notification_fyd/notificationfydmodel.dart';

abstract class NotificationFydController {
  static Future<void> addNotification(NotificationFydModel notification) async {
    var ref = FirebaseFirestore.instance.collection("users").doc(notification.receiverId).collection('notifications').doc();
    await ref.set(notification.copyWith(id: ref.id).toJson());
  }

  static Future<void> deleteNotification(NotificationFydModel? notification) async {
    await FirebaseFirestore.instance.collection('users').doc(notification!.receiverId).collection('notifications').doc(notification.id).delete();
    await FirebaseFirestore.instance.collection('users').doc(notification.senderId).collection('notifications').doc(notification.id).delete();
  }

  static Future<void> updateNotification(NotificationFydModel notification) async {
    await FirebaseFirestore.instance.collection("users").doc(notification.receiverId).collection('notifications').doc(notification.id).set(notification.toJson());
  }
}
