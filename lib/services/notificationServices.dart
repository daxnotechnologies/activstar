import 'dart:typed_data';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LocalNotificationService {
  // final IOSInitializationSettings initializationSettingsIOS =
  //     IOSInitializationSettings(
  //   requestSoundPermission: false,
  //   requestBadgePermission: false,
  //   requestAlertPermission: false,
  //   // onDidReceiveLocalNotification: onDidReceiveLocalNotification,
  // );

  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context) {
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: IOSInitializationSettings(
          // requestSoundPermission: false,
          // requestBadgePermission: false,
          // requestAlertPermission: false,
          // onDidReceiveLocalNotification: onDidReceiveLocalNotification,
          ),
    );

    _notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? route) async {});
  }

  static Future<Uint8List> _getByteArrayFromUrl(String url) async {
    final http.Response response = await http.get(Uri.parse(url));
    return response.bodyBytes;
  }

  static void display(RemoteMessage message) async {
    try {
      // AndroidNotification? n = message.notification!.android;

      // print("andorid" + message.notification!.toMap().toString());

      // print("Hello" + message.notification!.android!.link.toString());

      // SharedPreferences preferences = await SharedPreferences.getInstance();
      // print("NOtification Lenght" + preferences.get("notificationTitle").toString());
      
  
    final docUser = FirebaseFirestore.instance.collection("notifications");



      if (message.notification!.android!.imageUrl == "xxx" ||
          message.notification!.android!.imageUrl == null) {
      //   if (message.notification!.android!.link != null) {
      //   final json1 = {
      //     "title": message.notification!.title.toString(),
      //     "text": message.notification!.body.toString(),
      //     "link": message.notification!.android!.link.toString(),
      //     "read": false,
      //     "time": DateTime.now()
      //     };
      //     await docUser.add(json1);
      // } else {
      //   final json2 = {
      //     "title": message.notification!.title.toString(),
      //     "text": message.notification!.body.toString(),
      //     "link": "xxx",
      //     "read": false,
      //     "time": DateTime.now()
      //     };
      //     await docUser.add(json2);
      // }

      //add current user email to the notification that is received

        // final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
        //
        // final NotificationDetails notificationDetails = NotificationDetails(
        //   android: AndroidNotificationDetails(
        //     "1",
        //     "activstar-supplement",
        //     importance: Importance.max,
        //     priority: Priority.high,
        //   ),
        //   iOS: IOSNotificationDetails(),
        // );

        print("No        aaaaaaaaaaaaaaaaaaaaa      big Picture");


        await AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: 10, channelKey: 'basic_channel', title: message.notification!.title, body: message.notification!.body,
              displayOnBackground: true,
              displayOnForeground: true
          ));

        // await _notificationsPlugin.show(
        //   id,
        //   message.notification!.title,
        //   message.notification!.body,
        //   notificationDetails,
        // );
      } else {
        // if (message.notification!.android!.link != null) {
        //   final json3 = {
        //     "title": message.notification!.title.toString(),
        //     "text": message.notification!.body.toString(),
        //     "link": message.notification!.android!.link.toString(),
        //     "read": false,
        //     "time": DateTime.now()
        //     };
        //     await docUser.add(json3);
        // } else {
        //   final json4 = {
        //     "title": message.notification!.title.toString(),
        //     "text": message.notification!.body.toString(),
        //     "link": "xxx",
        //     "read": false,
        //     "time": DateTime.now()
        //     };
        //     await docUser.add(json4);
        // }

        print("big Picture");
        print(message.notification!.android!.imageUrl);

        // final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
        //
        // final ByteArrayAndroidBitmap bigPicture = ByteArrayAndroidBitmap(
        //     await _getByteArrayFromUrl(
        //         '${message.notification!.android!.imageUrl}'));
        //
        // final BigPictureStyleInformation bigPictureStyleInformation =
        //     BigPictureStyleInformation(bigPicture,
        //         htmlFormatContentTitle: true, htmlFormatSummaryText: true);
        //
        // final NotificationDetails notificationDetails = NotificationDetails(
        //   android: AndroidNotificationDetails(
        //     "1",
        //     "activstar-supplement",
        //     importance: Importance.max,
        //     priority: Priority.high,
        //     styleInformation: bigPictureStyleInformation,
        //   ),
        //   iOS: IOSNotificationDetails(
        //     presentAlert: true,
        //     presentBadge: true,
        //     presentSound: true,
        //   ),
        // );

        await AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: 5, channelKey: 'big_picture', title: message.notification!.title, body: message.notification!.body,
              displayOnBackground: true,
              displayOnForeground: true,
              bigPicture: message.notification!.android!.imageUrl,
            notificationLayout: NotificationLayout.BigPicture
          ));

        // await _notificationsPlugin.show(
        //   id,
        //   message.notification!.title,
        //   message.notification!.body,
        //   notificationDetails,
        // );
      }

      // .notification!.toMap().toString()

    } on Exception catch (e) {
      print(e);
    }
  }
}
