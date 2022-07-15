import 'package:activstar/api/productApi.dart';
import 'package:activstar/models/productModel.dart';
import 'package:activstar/screens/notification_icon.dart';
import 'package:activstar/screens/signIn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:activstar/screens/BottomNavBar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api/signApi.dart';
import '../constants/constants.dart';
import 'notificationsPage.dart';

class Produkty extends StatefulWidget {
  const Produkty({Key, key}) : super(key: key);

  @override
  _ProduktyState createState() => _ProduktyState();
}

class _ProduktyState extends State<Produkty> {
  @override
  void initState() {
    super.initState();
  }

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

  productApi api = new productApi();
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder<dynamic>(
          future: getNotification(),
          builder: (context, snapshotss) {
            if (snapshotss.hasData) {
              return SafeArea(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                                NotificationIcon(),

                                SizedBox(
                                  width: _size.width * 0.03,
                                ),
                                PopupMenuButton(
                                    onSelected: (value) {
                                      if (value == 2) {
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
                                                  fontFamily: 'SFProDisplay',
                                                  fontSize: 11),
                                            ),
                                            value: 1,
                                          ),
                                          PopupMenuItem(
                                            child: Text(
                                              "Odhlásiť sa",
                                              style: TextStyle(
                                                  fontFamily: 'SFProDisplay',
                                                  fontSize: 11),
                                            ),
                                            value: 2,
                                          )
                                        ]),
                                // Icon(Icons.more_vert, size: _size.width * 0.07)
                              ],
                            )
                          ],
                        ),
                        Text(
                          'Produkty',
                          style: TextStyle(
                              fontFamily: 'SFProDisplay',
                              fontWeight: FontWeight.w700,
                              fontSize: 24),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: FutureBuilder<productModel>(
                              future: api.getproduct(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return GridView.builder(
                                      itemCount: snapshot.data!.items!.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent: 300,
                                              childAspectRatio: 1.45 / 2,
                                              crossAxisSpacing: 20,
                                              mainAxisSpacing: 20),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: InkWell(
                                            onTap: () {
                                              launchUrl(
                                                  Uri.parse(
                                                      "${snapshot.data?.items?.elementAt(index).url}"),
                                                  mode: LaunchMode
                                                      .externalApplication);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  20, 10, 20, 10),
                                              width: _size.width * 0.41,
                                              decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.grey,
                                                        spreadRadius: 1,
                                                        blurRadius: 10)
                                                  ]),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Image(
                                                      image: NetworkImage(
                                                          "${snapshot.data?.items?.elementAt(index).imageUrl}"),
                                                    ),
                                                  ),
                                                  Text(
                                                    '${snapshot.data?.items?.elementAt(index).title}',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontFamily: 'SFProText',
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 12),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    '${snapshot.data?.items?.elementAt(index).priceWithoutVat}€ bez DPH',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'SFProDisplay',
                                                        fontSize: 12,
                                                        color:
                                                            Color(0xFF9FA6B2)),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    '${snapshot.data?.items?.elementAt(index).priceWithVat}€ s DPH',
                                                    style: TextStyle(
                                                        fontFamily: 'SFProText',
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 14,
                                                        color: kPrimaryColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
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
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(color: Colors.brown),
              );
            }
          }),
    );
    // return Container(
    //   padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
    //   width: _size.width * 0.41,
    //   decoration: const BoxDecoration(color: Colors.white, boxShadow: [
    //     BoxShadow(
    //         color: Color(0x33000000), blurRadius: 30, offset: Offset(0, 4))
    //   ]),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Image.asset('assets/images/juice.png'),
    //       Text(
    //         'Activ NO Drink 1 sáčok',
    //         maxLines: 2,
    //         overflow: TextOverflow.ellipsis,
    //         style: TextStyle(
    //             fontFamily: 'SFProText',
    //
    //             fontWeight: FontWeight.w700,
    //             fontSize: _size.width * 0.04),
    //       ),
    //       SizedBox(
    //         height: _size.height * 0.005,
    //       ),
    //       Text(
    //         '0,88€ bez DPH',
    //         style: TextStyle(
    //             fontFamily: 'SFProDisplay',
    //             fontSize: 12,
    //             color: Color(0xFF9FA6B2)),
    //       ),
    //       SizedBox(
    //         height: _size.height * 0.0025,
    //       ),
    //       Text(
    //         '1,06€ s DPH',
    //         style: TextStyle(
    //             fontFamily: 'SFProText',
    //             fontWeight: FontWeight.w700,
    //             fontSize: 14,
    //             color: kPrimaryColor),
    //       ),
    //     ],
    //   ),
    // );
  }
}
