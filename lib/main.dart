// import 'dart:convert';

import 'package:activstar/constants/constants.dart';
import 'package:activstar/screens/BottomNavBar.dart';
// import 'package:activstar/screens/homePage.dart';
import 'package:activstar/screens/signIn.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/notificationsPage.dart';
// import 'package:http/http.dart' as http;
// Import the generated file
// import 'firebase_options.dart';

void main() async { 
  WidgetsFlutterBinding.ensureInitialized();

  AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelGroupKey: 'basic_tests',
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        importance: NotificationImportance.High,
        channelShowBadge: true,
    ),
    NotificationChannel(
        channelGroupKey: 'image_tests',
        channelKey: 'big_picture',
        channelName: 'Big pictures',
        channelDescription: 'Notifications with big and beautiful images',
        importance: NotificationImportance.High,
        channelShowBadge: true,
    ),
  ],
        channelGroups: [
          NotificationChannelGroup(channelGroupkey: 'basic_tests', channelGroupName: 'Basic tests'),
          NotificationChannelGroup(channelGroupkey: 'image_tests', channelGroupName: 'Images tests'),
        ],
        debug: true
    );

  await Firebase.initializeApp(
          // options: DefaultFirebaseOptions.currentPlatform,
    )
      .then((value) => {
            FirebaseMessaging.instance.getToken().then((value) {
              FirebaseMessaging.instance.subscribeToTopic('global');
              String? token = value;
              print("Main Token" + token.toString());
            })
          });

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {

    AwesomeNotifications().actionStream.listen((receivedAction) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context){
        return NotificationsPage();
      }));
      // Builder()
    });

    // TODO: implement initState
    GetPrefs();
    super.initState();
  }

  // var loginedd;

  Future<dynamic> GetPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    access_token = prefs.getString('access_token');
    logined = prefs.getBool('Logined');
      return logined;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: GetPrefs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done){
            if(snapshot.data == true){
              return bottomNavigationBar(1);
            } else {
              return signIn();
            }
          }
          else
            return CircularProgressIndicator(color: Colors.brown,);
        },
      ),
      // home : (loginedd == true) ? bottomNavigationBar(1) : signIn(),
    );
  }
}