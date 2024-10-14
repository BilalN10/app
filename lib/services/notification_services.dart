import 'package:auto_route/auto_route.dart';
import 'dart:convert';
import 'package:core_kosmos/core_kosmos.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';

AndroidNotificationChannel channel = const AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  importance: Importance.max,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class NotificationServices {
  static Future initialize({required BuildContext context, required WidgetRef ref}) async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('splash');
    const IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings();
    const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: (payload) async {
      if (payload != null) {
        final Map<String, dynamic> map = Map<String, dynamic>.from(jsonDecode(payload));

        if (map['bookingId'] != 'none') {
          printInDebug('notification payload: ' + payload);
          AutoRouter.of(context).navigateNamed("/dashboard/index/fitting");
        } else {
          AutoRouter.of(context).navigateNamed("/dashboard/notification/page");
        }
      }
    });
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      printInDebug(message.notification);
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: android.smallIcon,
              ),
            ));
      } else if (notification != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            iOS: IOSNotificationDetails(
              presentAlert: true,
              presentSound: true,
              presentBadge: true,
            ),
          ),
          payload: jsonEncode(message.data),
        );
      }
    });
  }

  static Future firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    flutterLocalNotificationsPlugin.show(
      message.notification.hashCode,
      message.notification?.title ?? '',
      message.notification?.body ?? '',
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: message.notification?.android?.smallIcon,
        ),
      ),
      payload: jsonEncode(message.data),
    );
  }
}
