import 'package:activstar/api/newsApi.dart';
import 'package:activstar/models/categoryModel.dart';
import 'package:activstar/models/newsModel.dart';
import 'package:activstar/screens/notification_icon.dart';
import 'package:activstar/screens/notificationsPage.dart';
import 'package:activstar/screens/BottomNavBar.dart';
import 'package:activstar/screens/signIn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api/signApi.dart';
import 'articleScreen.dart';

class clanky extends StatefulWidget {
  const clanky({Key, key}) : super(key: key);

  @override
  _clankyState createState() => _clankyState();
}

class _clankyState extends State<clanky> {
  @override
  void initState() {
    super.initState();
  }

  newsApi api = new newsApi();
  var category = "";

  String blogCategory = "category";

  getNotification() async {
    var firestore = FirebaseFirestore.instance;

    int x = 0;
    var list = [];

    firestore
        .collection('notifications')
        .where('read', isEqualTo: false)
        .snapshots()
        .forEach((element) {
      x = element.docs.length;
    });

    return Future.delayed(Duration(seconds: 2), () {
      return x;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return FutureBuilder<dynamic>(
        future: getNotification(),
        builder: (context, snapshotss) {
          if (snapshotss.hasData) {
            return SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                height: _size.height * 0.09,
                                width: _size.height * 0.09,
                                child: Image.asset('assets/images/logo.png')),
                            Row(
                              children: [
                                Stack(
                                  children: [
                                    NotificationIcon(),
                                    // GestureDetector(
                                    //     onTap: () {
                                    //       setState(() {
                                    //         bottomNavigationBar.notification =
                                    //             true;
                                    //       });
                                    //     },
                                    //     child: InkWell(
                                    //       onTap: () {
                                    //         Navigator.of(context).push(
                                    //             MaterialPageRoute(
                                    //                 builder: (context) =>
                                    //                     NotificationsPage()));
                                    //       },
                                    //       child: Stack(
                                    //         children: [
                                    //           Icon(Icons.mail_outline_outlined,
                                    //               size: _size.width * 0.07),
                                    //           snapshotss.data > 0
                                    //               ? Positioned(
                                    //                   // draw a red marble
                                    //                   top: 0.0,
                                    //                   right: 0.0,
                                    //                   child: new Icon(
                                    //                       Icons.brightness_1,
                                    //                       size: 10.0,
                                    //                       color:
                                    //                           Colors.redAccent),
                                    //                 )
                                    //               : Container()
                                    //         ],
                                    //       ),
                                    //     )),
                                  ],
                                ),
                                SizedBox(
                                  width: _size.width * 0.03,
                                ),
                                PopupMenuButton(
                                    onSelected: (value) {
                                      if (value == 3) {
                                        signApi api = new signApi();
                                        api.logout();

                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => signIn()),
                                        );
                                        setState(() {});
                                      } else if (value == 1) {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Dialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0)), //this right here
                                                child: Container(
                                                  height: _size.height * 0.53,
                                                  width: _size.width * 0.9,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 25, 0, 20),
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            'O aplikácii',
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    'SFProDisplay',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                          Image.asset(
                                                              'assets/images/activstarbox.png',
                                                              width: 100,
                                                              height: 100),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            'Activstar',
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    'SFProDisplay',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                          SizedBox(
                                                            height: 8,
                                                          ),
                                                          Text(
                                                            'Verzia: 2.0.0',
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    'SFProDisplay',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          Text(
                                                            'Vývojár:',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    'SFProDisplay',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                          GestureDetector(
                                                              onTap: () {
                                                                launchUrl(
                                                                    Uri.parse(
                                                                        "https://www.zarf.sk/"),
                                                                    mode: LaunchMode
                                                                        .externalApplication);
                                                              },
                                                              child: Image.asset(
                                                                  'assets/images/zarf.png',
                                                                  width: 150,
                                                                  height: 150)),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              GestureDetector(
                                                                  onTap: () {
                                                                    launchUrl(
                                                                        Uri.parse(
                                                                            "https://www.activstar.eu/dokumenty/ochrana-osobnych-udajov.pdf?v=1610242271"),
                                                                        mode: LaunchMode
                                                                            .externalApplication);
                                                                  },
                                                                  child: Text(
                                                                    'Ochrana súkromia',
                                                                    style: TextStyle(
                                                                        decoration:
                                                                            TextDecoration
                                                                                .underline,
                                                                        fontSize:
                                                                            10,
                                                                        fontFamily:
                                                                            'SFProDisplay',
                                                                        fontWeight:
                                                                            FontWeight.w400),
                                                                  )),
                                                              GestureDetector(
                                                                  onTap: () {
                                                                    launchUrl(
                                                                        Uri.parse(
                                                                            "https://www.activstar.eu/"),
                                                                        mode: LaunchMode
                                                                            .externalApplication);
                                                                  },
                                                                  child: Text(
                                                                    'Activstar.eu',
                                                                    style: TextStyle(
                                                                        decoration:
                                                                            TextDecoration
                                                                                .underline,
                                                                        fontSize:
                                                                            10,
                                                                        fontFamily:
                                                                            'SFProDisplay',
                                                                        fontWeight:
                                                                            FontWeight.w400),
                                                                  )),
                                                            ],
                                                          )
                                                        ]),
                                                  ),
                                                ),
                                              );
                                            });
                                      } else if (value==2){
                                        signApi sign = new signApi();
                                        showDialog(context: context,
                                            builder: (context) {
                                              return Dialog(
                                                backgroundColor: Colors.transparent,
                                                child: Container(
                                                    height: 200,
                                                    width: MediaQuery.of(context).size.width * 0.6,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                                        color: Colors.white
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: [
                                                          Text(
                                                            'Moj ucet',
                                                            style: TextStyle(
                                                                color: Colors.black,
                                                                fontSize: 18,
                                                                fontFamily: 'SFProDisplay',
                                                                fontWeight: FontWeight.w600),
                                                          ),

                                                          GestureDetector(
                                                            onTap: () {
                                                              launchUrl(Uri.parse("https://www.activstar.eu/account"),
                                                                  mode: LaunchMode.inAppWebView
                                                              );
                                                            },
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Text(
                                                                  'Zobrazit moj ucet',
                                                                  style: TextStyle(
                                                                      fontSize: 18,
                                                                      fontFamily: 'SFProDisplay',
                                                                      color: Colors.yellow,
                                                                      fontWeight: FontWeight.w600),
                                                                ),
                                                                SizedBox(width: 2,),
                                                                Icon(EvaIcons.externalLink,
                                                                  color: Colors.yellow, size: 20,)
                                                              ],
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              Navigator.pop(context);
                                                              showDialog(context: context,
                                                                  builder: (context) {
                                                                    return Dialog(
                                                                      backgroundColor: Colors.transparent,
                                                                      child: Container(
                                                                          height: 200,
                                                                          width: MediaQuery.of(context).size.width * 0.6,
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.all(Radius.circular(20)),
                                                                              color: Colors.white
                                                                          ),
                                                                          child: Padding(
                                                                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                                                            child: Column(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                              children: [
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                                  children: [
                                                                                    Text(
                                                                                      'Vymazat ucet',
                                                                                      style: TextStyle(
                                                                                          color: Colors.black,
                                                                                          fontSize: 18,
                                                                                          fontFamily: 'SFProDisplay',
                                                                                          fontWeight: FontWeight.w600),
                                                                                    ),
                                                                                    SizedBox(width: 20,),
                                                                                    IconButton(
                                                                                        onPressed: () {
                                                                                          Navigator.pop(context);
                                                                                        },
                                                                                        icon: Icon(Icons.close, size: 22, color: Colors.black,)),
                                                                                    SizedBox(width: 10,)
                                                                                  ],
                                                                                ),

                                                                                Center(
                                                                                  child: SizedBox(
                                                                                    width: MediaQuery.of(context).size.width * 0.5,
                                                                                    child: Text(
                                                                                      'Ste si isty ze chcete naozaj vymazat svoj ucet',
                                                                                      style: TextStyle(
                                                                                        fontSize: 16,
                                                                                        fontFamily: 'SFProDisplay',
                                                                                        color: Colors.red,
                                                                                        fontWeight: FontWeight.w600,),
                                                                                      textAlign: TextAlign.center,
                                                                                    ),
                                                                                  ),
                                                                                ),

                                                                                GestureDetector(
                                                                                  onTap: () {
                                                                                    sign.deleteAccount();
                                                                                    Navigator.pop(context);
                                                                                    Navigator.pushReplacement(
                                                                                        context,
                                                                                        MaterialPageRoute(
                                                                                            builder: (context) =>
                                                                                                signIn()));
                                                                                  },
                                                                                  child: Container(
                                                                                    width: MediaQuery.of(context).size.width * 0.4,
                                                                                    height: 40,
                                                                                    decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                                      color: Colors.red,
                                                                                    ),
                                                                                    child: Center(
                                                                                      child: Text(
                                                                                        'VYMAZAT UCET',
                                                                                        style: TextStyle(
                                                                                            fontSize: 14,
                                                                                            fontFamily: 'SFProDisplay',
                                                                                            color: Colors.white,
                                                                                            fontWeight: FontWeight.w600),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                              ],),
                                                                          )
                                                                      ),
                                                                    );
                                                                  });
                                                            },
                                                            child: Container(
                                                              width: MediaQuery.of(context).size.width * 0.4,
                                                              height: 40,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                color: Colors.red,
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  'VYMAZAT UCET',
                                                                  style: TextStyle(
                                                                      fontSize: 14,
                                                                      fontFamily: 'SFProDisplay',
                                                                      color: Colors.white,
                                                                      fontWeight: FontWeight.w600),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],),
                                                    )
                                                ),
                                              );
                                            });

                                      }
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    padding: EdgeInsets.all(0),
                                    color: Color(0XFFE5E5E5),
                                    icon: Icon(Icons.more_vert,
                                        size: _size.width * 0.07),
                                    itemBuilder: (context) => [

                                      PopupMenuItem(
                                        child: Text(
                                          "O aplikácii",
                                          style: TextStyle(
                                              fontFamily:
                                              'SFProDisplay',
                                              fontSize: 11),
                                        ),
                                        value: 1,
                                      ),
                                      PopupMenuItem(
                                        child: Text(
                                          "Môj účet",
                                          style: TextStyle(
                                              fontFamily:
                                              'SFProDisplay',
                                              fontSize: 11),
                                        ),
                                        value: 2,
                                      ),
                                      PopupMenuItem(
                                        child: Text(
                                          "Odhlásiť sa",
                                          style: TextStyle(
                                              fontFamily:
                                              'SFProDisplay',
                                              fontSize: 11),
                                        ),
                                        value: 3,
                                      ),

                                    ]),
                                // Icon(Icons.more_vert, size: _size.width * 0.07)
                              ],
                            )
                          ],
                        ),
                        Text(
                          'Články',
                          style: TextStyle(
                              fontFamily: 'SFProDisplay',
                              fontWeight: FontWeight.w700,
                              fontSize: 24),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            20.0)), //this right here
                                    child: Container(
                                      width: _size.width * 0.9,
                                      height: 360,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            'Kategórie',
                                            style: TextStyle(
                                                fontFamily: 'SFProDisplay',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    if (blogCategory !=
                                                        "Dovolenky")
                                                      blogCategory =
                                                          "Dovolenky";
                                                    else
                                                      blogCategory = "category";
                                                    setState(() {});
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    width: _size.width * 0.3,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      color: blogCategory ==
                                                              "Dovolenky"
                                                          ? Color(0XFFDEC13C)
                                                          : Color(0xFFE5E5E5),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        blogCategory ==
                                                                "Dovolenky"
                                                            ? Image.asset(
                                                                'assets/images/DovolenkyEnabled.png',
                                                                width: 22,
                                                                height: 22,
                                                              )
                                                            : Image.asset(
                                                                'assets/images/Dovolenky.png',
                                                                width: 22,
                                                                height: 22,
                                                              ),
                                                        Text(
                                                          "Dovolenky",
                                                          style: TextStyle(
                                                              color: blogCategory ==
                                                                      "Dovolenky"
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                              fontFamily:
                                                                  'SFProDisplay',
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    if (blogCategory !=
                                                        "Aktuality")
                                                      blogCategory =
                                                          "Aktuality";
                                                    else
                                                      blogCategory = "category";
                                                    setState(() {});
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    width: _size.width * 0.3,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      color: blogCategory ==
                                                              "Aktuality"
                                                          ? Color(0XFFDEC13C)
                                                          : Color(0xFFE5E5E5),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        blogCategory ==
                                                                "Aktuality"
                                                            ? Image.asset(
                                                                'assets/images/AktualityEnabled.png',
                                                                width: 22,
                                                                height: 22,
                                                              )
                                                            : Image.asset(
                                                                'assets/images/Aktuality.png',
                                                                width: 22,
                                                                height: 22,
                                                              ),
                                                        Text(
                                                          'Aktuality',
                                                          style: TextStyle(
                                                              color: blogCategory ==
                                                                      "Aktuality"
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                              fontFamily:
                                                                  'SFProDisplay',
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    if (blogCategory !=
                                                        "Motivancy")
                                                      blogCategory =
                                                          "Motivancy";
                                                    else
                                                      blogCategory = "category";
                                                    setState(() {});
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    width: _size.width * 0.3,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      color: blogCategory ==
                                                              "Motivancy"
                                                          ? Color(0XFFDEC13C)
                                                          : Color(0xFFE5E5E5),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        blogCategory ==
                                                                "Motivancy"
                                                            ? Image.asset(
                                                                'assets/images/MotivancyEnabled.png',
                                                                width: 22,
                                                                height: 22,
                                                              )
                                                            : Image.asset(
                                                                'assets/images/Motivancy.png',
                                                                width: 22,
                                                                height: 22,
                                                              ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "Motivačný",
                                                              style: TextStyle(
                                                                  color: blogCategory ==
                                                                          "Motivancy"
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                                  fontFamily:
                                                                      'SFProDisplay',
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            ),
                                                            Text(
                                                              "program",
                                                              style: TextStyle(
                                                                  color: blogCategory ==
                                                                          "Motivancy"
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                                  fontFamily:
                                                                      'SFProDisplay',
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    if (blogCategory !=
                                                        "Biznis")
                                                      blogCategory = "Biznis";
                                                    else
                                                      blogCategory = "category";
                                                    setState(() {});
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    width: _size.width * 0.3,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      color: blogCategory ==
                                                              "Biznis"
                                                          ? Color(0XFFDEC13C)
                                                          : Color(0xFFE5E5E5),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        blogCategory == "Biznis"
                                                            ? Image.asset(
                                                                'assets/images/BiznisEnabled.png',
                                                                width: 22,
                                                                height: 22,
                                                              )
                                                            : Image.asset(
                                                                'assets/images/Biznis.png',
                                                                width: 22,
                                                                height: 22,
                                                              ),
                                                        Text(
                                                          'Biznis',
                                                          style: TextStyle(
                                                              color: blogCategory ==
                                                                      "Biznis"
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                              fontFamily:
                                                                  'SFProDisplay',
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    if (blogCategory !=
                                                        "Spolupraca")
                                                      blogCategory =
                                                          "Spolupraca";
                                                    else
                                                      blogCategory = "category";
                                                    setState(() {});
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    width: _size.width * 0.3,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      color: blogCategory ==
                                                              "Spolupraca"
                                                          ? Color(0XFFDEC13C)
                                                          : Color(0xFFE5E5E5),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        blogCategory ==
                                                                "Spolupraca"
                                                            ? Image.asset(
                                                                'assets/images/SpolupracaEnabled.png',
                                                                width: 22,
                                                                height: 22,
                                                              )
                                                            : Image.asset(
                                                                'assets/images/Spolupraca.png',
                                                                width: 22,
                                                                height: 22,
                                                              ),
                                                        Text(
                                                          "Spolupráca",
                                                          style: TextStyle(
                                                              color: blogCategory ==
                                                                      "Spolupraca"
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                              fontFamily:
                                                                  'SFProDisplay',
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    if (blogCategory !=
                                                        "Aktualna")
                                                      blogCategory = "Aktualna";
                                                    else
                                                      blogCategory = "category";
                                                    setState(() {});
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    width: _size.width * 0.3,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      color: blogCategory ==
                                                              "Aktualna"
                                                          ? Color(0XFFDEC13C)
                                                          : Color(0xFFE5E5E5),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        blogCategory ==
                                                                "Aktualna"
                                                            ? Image.asset(
                                                                'assets/images/AktualnaEnabled.png',
                                                                width: 22,
                                                                height: 22,
                                                              )
                                                            : Image.asset(
                                                                'assets/images/Aktualna.png',
                                                                width: 22,
                                                                height: 22,
                                                              ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              'Aktuálna',
                                                              style: TextStyle(
                                                                  color: blogCategory ==
                                                                          "Aktualna"
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                                  fontFamily:
                                                                      'SFProDisplay',
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            ),
                                                            Text(
                                                              'kampaň',
                                                              style: TextStyle(
                                                                  color: blogCategory ==
                                                                          "Aktualna"
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                                  fontFamily:
                                                                      'SFProDisplay',
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    if (blogCategory !=
                                                        "Produkty")
                                                      blogCategory = "Produkty";
                                                    else
                                                      blogCategory = "category";
                                                    setState(() {});
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    width: _size.width * 0.3,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      color: blogCategory ==
                                                              "Produkty"
                                                          ? Color(0XFFDEC13C)
                                                          : Color(0xFFE5E5E5),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        blogCategory ==
                                                                "Produkty"
                                                            ? Image.asset(
                                                                'assets/images/ProduktyEnabled.png',
                                                                width: 22,
                                                                height: 22,
                                                              )
                                                            : Image.asset(
                                                                'assets/images/Produkty.png',
                                                                width: 22,
                                                                height: 22,
                                                              ),
                                                        Text(
                                                          'Produkty',
                                                          style: TextStyle(
                                                              color: blogCategory ==
                                                                      "Produkty"
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                              fontFamily:
                                                                  'SFProDisplay',
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: _size.width * 0.3,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Container(
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                Image.asset(
                                  'assets/images/category.png',
                                  width: 19,
                                  height: 19,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Kategórie',
                                  style: TextStyle(
                                      fontFamily: 'SFProDisplay',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder<newsModel>(
                        future: api.getNews(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                primary: true,
                                itemCount: (snapshot.data?.items!.length),
                                itemBuilder: (context, index) {
                                  // print("Blog Category: " + blogCategory);
                                  // print(snapshot.data!.items.elementAt(index).category == "Aktuality");
                                  // print(snapshot.data!.items.elementAt(index).title);
                                  if (blogCategory == "Dovolenky") {
                                    if ((snapshot.data!.items!
                                            .elementAt(index)
                                            .category!
                                            .contains("Dovolenky")) &&
                                        !snapshot.data!.items!
                                            .elementAt(index)
                                            .category!
                                            .contains("Referencie"))
                                      return getBlog(snapshot, _size, index);
                                    else
                                      return Container();
                                  } else if (blogCategory == "Aktuality") {
                                    if ((snapshot.data!.items!
                                            .elementAt(index)
                                            .category!
                                            .contains("Aktuality")) &&
                                        !snapshot.data!.items!
                                            .elementAt(index)
                                            .category!
                                            .contains("Referencie"))
                                      return getBlog(snapshot, _size, index);
                                    else
                                      return Container();
                                  } else if (blogCategory == "Motivancy") {
                                    if ((snapshot.data!.items!
                                            .elementAt(index)
                                            .category!
                                            .contains("Motivačný program")) &&
                                        !snapshot.data!.items!
                                            .elementAt(index)
                                            .category!
                                            .contains("Referencie"))
                                      return getBlog(snapshot, _size, index);
                                    else
                                      return Container();
                                  } else if (blogCategory == "Biznis") {
                                    if ((snapshot.data!.items!
                                            .elementAt(index)
                                            .category!
                                            .contains("Biznis")) &&
                                        !snapshot.data!.items!
                                            .elementAt(index)
                                            .category!
                                            .contains("Referencie"))
                                      return getBlog(snapshot, _size, index);
                                    else
                                      return Container();
                                  } else if (blogCategory == "Spolupraca") {
                                    if ((snapshot.data!.items!
                                            .elementAt(index)
                                            .category!
                                            .contains("Spolupráca")) &&
                                        !snapshot.data!.items!
                                            .elementAt(index)
                                            .category!
                                            .contains("Referencie"))
                                      return getBlog(snapshot, _size, index);
                                    else
                                      return Container();
                                  } else if (blogCategory == "Aktualna") {
                                    if ((snapshot.data!.items!
                                            .elementAt(index)
                                            .category!
                                            .contains("Aktuálna kampaň")) &&
                                        !snapshot.data!.items!
                                            .elementAt(index)
                                            .category!
                                            .contains("Referencie"))
                                      return getBlog(snapshot, _size, index);
                                    else
                                      return Container();
                                  } else if (blogCategory == "Produkty") {
                                    if ((snapshot.data!.items!
                                            .elementAt(index)
                                            .category!
                                            .contains("Produkty")) &&
                                        !snapshot.data!.items!
                                            .elementAt(index)
                                            .category!
                                            .contains("Referencie"))
                                      return getBlog(snapshot, _size, index);
                                    else
                                      return Container();
                                  } else {
                                    if (!snapshot.data!.items!
                                        .elementAt(index)
                                        .category!
                                        .contains("Referencie"))
                                      return getBlog(snapshot, _size, index);
                                    else
                                      return Container();
                                  }
                                });
                          } else {
                            return Center(
                              child: Container(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(
                                  color: Colors.brown,
                                ),
                              ),
                            );
                          }
                        }),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(color: Colors.brown),
            );
          }
        });
  }

  getBlog(var snapshot, var _size, var index) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              launchUrl(
                  Uri.parse("${snapshot.data!.items.elementAt(index).link}"),
                  mode: LaunchMode.externalApplication);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => ArticleScreen(
              //             index: index,
              //           )),
              // );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                width: _size.width,
                decoration: new BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 30,
                      spreadRadius: 1)
                ]),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: _size.width,
                            height: 150,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  "${snapshot.data?.items.elementAt(index).image}"),
                            )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "${snapshot.data?.items.elementAt(index).title}",
                            style: TextStyle(
                                fontFamily: 'SFProDisplay',
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Html(
                            data:
                                '${snapshot.data?.items.elementAt(index).dDescription}',
                          ),
                          // Text(
                          //   "${snapshot.data?.items?.elementAt(index).excerpt}",
                          //   textAlign: TextAlign.justify,
                          //   style: TextStyle(
                          //       fontFamily: 'SFProText',
                          //       fontSize: 15),
                          // ),
                          SizedBox(
                            height: 30,
                          ),
                        ]),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: _size.height * 0.02,
          ),
        ],
      ),
    );
  }

  getChip(Size _size, String img, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: _size.width * 0.3,
          height: 40,
          decoration: BoxDecoration(
              color: Color(0xffE5E5E5),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset('assets/images/$img.png'),
            SizedBox(
              width: 7,
            ),
            Text(
              '$title',
              style: TextStyle(
                  fontFamily: 'SFProDisplay',
                  fontWeight: FontWeight.w400,
                  fontSize: 13),
            )
          ]),
        ),
        Container(
          width: _size.width * 0.3,
          height: 40,
          decoration: BoxDecoration(
              color: Color(0xffE5E5E5),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset('assets/images/$img.png'),
            SizedBox(
              width: 7,
            ),
            Text(
              '$title',
              style: TextStyle(
                  fontFamily: 'SFProDisplay',
                  fontWeight: FontWeight.w400,
                  fontSize: 13),
            )
          ]),
        )
      ],
    );
  }
}
