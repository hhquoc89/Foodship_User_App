import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:foodship_user_app/global/global.dart';
import 'package:http/http.dart' as http;

class PushNotificationService {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission!');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declend or has not accepted permission');
    }
  }

  getToken() async {
    String token = '';
    await FirebaseMessaging.instance.getToken().then((value) {
      token = value ?? '';
      print('My token is :$token');
    });
    saveToken(token);
  }

  saveToken(String token) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .collection("userToken")
        .doc('token')
        .set({
      'tokenID': token,
    });
  }

  initInfo() {
    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: androidInitialize);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('----------onMessage-----------');
      print(
          'onMessage :  ${message.notification?.title}/${message.notification?.body}');
      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        message.notification!.body.toString(),
        htmlFormatBigText: true,
        contentTitle: message.notification!.title.toString(),
        htmlFormatContentTitle: true,
      );
      AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails('kitchen', 'kitchen',
              importance: Importance.high,
              styleInformation: bigTextStyleInformation,
              priority: Priority.high,
              playSound: true);
      NotificationDetails platformChanel =
          NotificationDetails(android: androidNotificationDetails);
      await flutterLocalNotificationsPlugin.show(0, message.notification?.title,
          message.notification?.body, platformChanel,
          payload: message.data['title']);
    });
  }

  void sendPushMessage(String token, String body, String title) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization":
              "key=AAAABhNWQCE:APA91bEHeF9blKRRB4umuUhH8HOVrn4kAvZOYgDP_T2FgyN8w9ie_XkJfzXIT-V7mTwfAxh1C78J0F61e9YMz2QYXFLK5ELEbU_qZ_P67ltORdmAv3lxAM3Vu6yB3sR8QLhkjPrTECGn"
        },
        body: jsonEncode(<String, dynamic>{
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'status': 'done',
            'body': body,
            'title': title,
          },
          'notification': <String, dynamic>{
            'title': title,
            'body': body,
          },
          'to': token,
        }),
      );
    } catch (e) {
      if (kDebugMode) {
        print('error');
      }
    }
  }
}
