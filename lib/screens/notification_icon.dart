import 'package:activstar/constants/constants.dart';
import 'package:activstar/screens/notificationsPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationIcon extends StatefulWidget {
  const NotificationIcon({Key? key}) : super(key: key);

  @override
  State<NotificationIcon> createState() => _NotificationIconState();
}

int x = 0;

class _NotificationIconState extends State<NotificationIcon> {
  @override
  void initState() {
    getNotification();
    super.initState();
  }

  getemail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var emailUser = preferences.getString('email');
    email = emailUser;
    print(emailUser);
    return emailUser;
  }

  getNotification() async {
    email = await getemail();
    var firestore = FirebaseFirestore.instance;

    print(email.toString());
    firestore
        .collection('notifications')
        .where('users', whereNotIn: [email] /* [...list]*/)
        .snapshots()
        .forEach((element) {
          print(element.docs.length.toString() +
              "                Elements.length");

          element.docs.forEach((element) {
            !((element.data()['users'] as List)
                    .map((item) => item as String)
                    .toList()
                    .contains(email))
                ? x += 1
                : x += 0;
          });
          setState(() {
            x = x;
          });
        });

    firestore.collection('notifications').snapshots().forEach((element) {
      print(element.docs.length.toString() + "                Elements.length");

      if (element.docs.any((element) => element.data()['users'] == null)) {
        setState(() {
          x = x + 1;
        });
      }
    });

    return x;
  }

  // Stream<int> getstream() async* {
  //   int? out = 0;
  //   yield* getNotification();
  // }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    print("Notificationicon x= " + "===================" + x.toString());

    return InkWell(
      onTap: () {
        setState(() {
          x = 0;
        });
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => NotificationsPage()));
      },
      child: Stack(
        children: [
          Icon(Icons.mail_outline_outlined, size: _size.width * 0.07),
          x > 0
              ? Positioned(
                  // draw a red marble
                  top: 0.0,
                  right: 0.0,
                  child: new Icon(Icons.brightness_1,
                      size: 10.0, color: Colors.redAccent),
                )
              : Container()
        ],
      ),
    );
  }
}
