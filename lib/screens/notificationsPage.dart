import 'dart:async';
import 'dart:developer';

import 'package:activstar/constants/constants.dart';
import 'package:activstar/models/notificationModel.dart';
import 'package:activstar/screens/articleScreen.dart';
import 'package:activstar/screens/homePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/navigation.dart';

class NotificationsPage extends StatefulWidget {
  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<LocalNotifications> notifications = [];
  late Timer timer;
  var a;
  var idList = [];
  List<String> locallist = [];
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      print("SchedulerBinding");
      await initialize();
    });
  }

  getemail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String useremail = prefs.getString("email") ?? "";
    return useremail;
  }

  initialize() async {
    email = await getemail();
    Color color = Color(0xffDEC13C);
    QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore.instance
        .collection('notifications')
        .orderBy('time', descending: true)
        .get();

    data.docs.forEach((element) {
      print(element.data()['users'].toString() +
          "==" +
          "==" +
          element.data()['time'].toString());
      if (element.data()['users'] != null) {
        element.data()['users'] = <dynamic>[];
        print(
            "adding []=============================================================================");
        color = !((element.data()['users'] as List)
                .map((item) => item as String)
                .toList()
                .contains(email))
            ? Color(0xffDEC13C)   
            : Colors.white;
      }
      // Color color = !((element.data()['users'] as List)
      //         .map((item) => item as String)
      //         .toList()
      //         .contains(email))
      //     ? Color(0xffDEC13C)
      //     : Colors.white;
      print(color.toString() + email.toString());
      notifications.add(LocalNotifications(
          element.data()['title'],
          element.data()['text'],
          element.data()['link'],
          element.data()['time'].toDate(),
          color));
    });
    notifications.sort((a, b) => b.time.compareTo(a.time));
    // return notifications;
    setState(() {
      notifications = notifications;
    });
  }

  change() {
    if (a != "done" && mounted) {
      setState(() {
        notifications
            .where((element) => element.color == Color(0xffDEC13C))
            .forEach((element) {
          element.color = Colors.white;
        });
      });
    }

    var n = FirebaseFirestore.instance.collection('notifications').get();

    n.then((docs) {
      docs.docs.forEach((element) async {
        if (element.data()['users'] != null) {
          if (!((element.data()['users'] as List)
              .map((item) => item as String)
              .toList()
              .contains(email))) {
            await FirebaseFirestore.instance
                .collection('notifications')
                .doc(element.id)
                .update({
              'users': FieldValue.arrayUnion([email])
            });
          }
        } else
          await FirebaseFirestore.instance
              .collection('notifications')
              .doc(element.id)
              .update({
            'users': FieldValue.arrayUnion([email])
          });
        ;
      });
    });

    a = "done";
  }

  cancelTimer() {
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    print(notifications.length);

    timer = new Timer(const Duration(seconds: 1), change);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {});
                                Navigator.of(context).pop();
                              },
                              child: Icon(Icons.arrow_back,
                                  size: _size.width * 0.07),
                            ),
                            SizedBox(
                                height: _size.height * 0.09,
                                width: _size.height * 0.09,
                                child: Image.asset('assets/images/logo.png')),
                            Row(
                              children: [
                                SizedBox(
                                  width: _size.width * 0.03,
                                ),
                              ],
                            )
                          ],
                        ),
                        Text(
                          'Notifikácie',
                          style: TextStyle(
                              fontFamily: 'SFProDisplay',
                              fontWeight: FontWeight.w700,
                              fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: _size.height * 0.03,
                  ),
                  NotificationList(size: _size, notifications: notifications)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    notifications.clear();
    a = "";
    print("disposed");
  }
}

class NotificationList extends StatelessWidget {
  const NotificationList({
    Key? key,
    required Size size,
    required List<LocalNotifications> notifications,
  })  : _size = size,
        notifications = notifications,
        super(key: key);

  final Size _size;
  final List<LocalNotifications> notifications;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // child: Column(
      //   children: [
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: notifications.length,
          itemBuilder: (context, i) {
            return GestureDetector(
              onTap: () {
                if (notifications[i].link == "xxx" ||
                    notifications[i].link == " ") {
                } else {
                  launchUrl(Uri.parse(notifications[i].link),
                      mode: LaunchMode.externalApplication);
                }
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: AnimatedContainer(
                      // height: _size.height / 5,
                      padding: EdgeInsets.fromLTRB(20, 17, 15, 20),
                      width: _size.width * 0.9,
                      decoration: BoxDecoration(
                          color: (notifications[i].color),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              spreadRadius: 1,
                              blurRadius: 30,
                            )
                          ]),
                      duration: Duration(seconds: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: _size.width * 0.72,
                                child: Text(
                                  notifications[i].title,
                                  style: TextStyle(
                                      fontFamily: 'SFProText',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                height: _size.height * 0.01,
                              ),
                              SizedBox(
                                width: _size.width * 0.65,
                                child: Text(
                                  notifications[i].text,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: 'SFProText', fontSize: 12),
                                  maxLines: 200,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          notifications[i].link == "xxx" ||
                                  notifications[i].link == ' '
                              ? Container()
                              : Image.asset(
                                  'assets/images/link.png',
                                )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
      //   ],
      // ),
    );
  }
}

class LocalNotifications {
  String title = " ", text = " ", link = " ";
  DateTime time = DateTime.now();
  Color color = Colors.white;

  LocalNotifications(this.title, this.text, this.link, this.time, this.color);
}


//  Future.delayed(const Duration(milliseconds: 500), () {
// // Here you can write your code

//                         setState(() {
//                           notifications[i].color == Colors.white;
//                         });
//                       });