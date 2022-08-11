import 'dart:developer' as dev;
import 'dart:math';
import 'package:activstar/api/newsApi.dart';
import 'package:activstar/api/signApi.dart';
import 'package:activstar/models/testimonialModel.dart';
import 'package:activstar/screens/BottomNavBar.dart';
import 'package:activstar/screens/notification_icon.dart';
import 'package:activstar/screens/signIn.dart';
import 'package:activstar/screens/testimonialView.dart';
import 'package:activstar/services/notificationServices.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/constants.dart';
import '../constants/navigation.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'articleScreen.dart';
import 'notificationsPage.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message...........................");
  // SharedPreferences.setMockInitialValues({});
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  // final docUser = FirebaseFirestore.instance.collection("notifications");

  try {
    // if (message.notification!.android!.link != null) {
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

  } on Exception catch (e) {
    print(e);
  }

  // FutureBuilder<dynamic>(
  //   future: check(),
  //   builder: ((context, snapshot) {
  //     print("hairs.....sada........");
  //     if(snapshot.connectionState == ConnectionState.done){
  //       print("hair.............");
  //       print(snapshot.data.toString());
  //       return snapshot.data;
  //     } else {
  //       return snapshot.data;
  //     }
  //   }),
  // );
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<NavigationItem> navigationItems = getNavigationItemList();
  NavigationItem? selectedItem;
  newsApi api = new newsApi();
  List<cards>? _list = [
    cards(image: "juice.png", name: "Produkty"),
    cards(image: "newspaper.png", name: "Články")
  ];

  double _value = 0;
  Random random = new Random();
  Size? _outerSize;

  bool notification = false;
  int i = 0;
  int x = 0;
// setup(BuildContext context)async{
//  await LocalNotificationService.initialize(context);
// }

  @override
  void initState() {
    x = 0;
    randomItem();

    LocalNotificationService.initialize(context);

    ///gives you the message on which user taps
    ///and it opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {});

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    ///forground work
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("noooheellll");
      if (message.data != null) {
        //   var jsonMessage = jsonDecode(message.data.toString());
        // print(jsonMessage['body']);
        // print(jsonMessage['title']);
        print("heellll");

        LocalNotificationService.display(message);
      }
    });

    ///When the app is in background but opened and user taps
    ///on the notification
    // FirebaseMessaging.onMessageOpenedApp.listen((message) {
    //   final routeFromMessage = message.data["route"];

    //   Navigator.of(context).pushNamed(routeFromMessage);
    // });

    //     FirebaseMessaging.onBackgroundMessage((message) {
    //       print("background");
    //   final routeFromMessage = message.data["route"];

    //   Navigator.of(context).pushNamed(routeFromMessage);
    //     // do something
    //   return backgroundMessage();

    // });

    // TODO: implement initState
    super.initState();
    selectedItem = navigationItems[1];
    getFirstUser();
  }

  getemail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var emailUser = preferences.getString('email');
    email = emailUser;
    print(emailUser);
    return emailUser;
  }

  getNotification() async {
    // email = await getemail();
    // var firestore = FirebaseFirestore.instance;

    // print(email.toString());
    // firestore
    //     .collection('notifications')
    //     .where('users', whereNotIn: [email] /* [...list]*/)
    //     .snapshots()
    //     .forEach((element) {
    //       // x += 1;
    //       print(element.docs.length.toString() +
    //           "                Elements.length");
    //       //setState(() {});

    //       element.docs.forEach((element) {
    //         !((element.data()['users'] as List)
    //                 .map((item) => item as String)
    //                 .toList()
    //                 .contains(email))
    //             ? x += 1
    //             : x += 0;
    //       });
    //     });

    return Future.delayed(Duration(seconds: 2), () {
      print("x=" + x.toString() + "===================" + email.toString());
      return x;
    });
  }

  getFirstUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var users = preferences.getStringList('users');
    var emailUser = preferences.getString('email');

    var present = false;

    if (users != null) {
      for (int i = 0; i < users.length; i++) {
        if (emailUser == users[i]) {
          present = true;
          break;
        }
      }
    }

    if (present == false) {
      getDialog(_outerSize!);
      if (users == null)
        preferences.setStringList('users', [email.toString()]);
      else {
        var userEmail = preferences.getString('email');
        users.add(userEmail!);
        preferences.setStringList('users', users);
      }
    }
  }

  Future<void> backgroundMessage() async {
    return;
  }

  // late Size imageSize = const Size(0.00, 0.00);

  // Future<Size> _getImageDimension(String? imageURL) async{
  //   Size size  = Size(0.00, 0.00);;
  //   Image image = Image.network(imageURL!);
  //   image.image.resolve(const ImageConfiguration()).addListener(
  //     ImageStreamListener(
  //       (ImageInfo image, bool synchronousCall) {
  //         var myImage = image.image;
  //           size =
  //               Size(myImage.width.toDouble(), myImage.height.toDouble());
  //       },
  //     ),
  //   );
  //   return size;
  // }

  Future<bool> onWillPop() {
    setState(() {});
    return Future.value(true);
  }

  Future<Items> randomItem() async {
    print("hereee");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var result = await api.getTestimonials();
    bool rand = true;
    var ele;

    int randomNumber = random.nextInt(result.items!.length) + 0;
    print("================================================ random number   " +
        randomNumber.toString());

    result.items!.forEach((element) {
      if(element.stickyDisplay == 1){
        rand = false;
        ele = element;
      }
    });

    if(rand == false){
      return ele;
    } else {
      var testimonialId = preferences.get("testimonialId");
      var testimonialDate = preferences.get("testimonialDate");

      if(testimonialId == null){
        dev.log("h44444444444444444444444444444444444");
        preferences.setInt("testimonialId", int.parse(result.items![randomNumber].iD.toString()));
        preferences.setString("testimonialDate", DateTime.now().add(Duration(days: 1)).toString());
        return result.items![randomNumber];
      } else {
        var date = DateTime.parse(testimonialDate.toString());
          if(DateTime.now().isAfter(date)){
             dev.log("h2222222222222222222222222222222222222");
            int randomNumber1 = random.nextInt(result.items!.length) + 0;
            preferences.setInt("testimonialId", int.parse(result.items![randomNumber].iD.toString()));
            preferences.setString("testimonialDate", DateTime.now().add(Duration(days: 1)).toString());
            return result.items!.elementAt(randomNumber1);
          } else {
            dev.log("h3333333333333333333333333333333333");
            result.items!.forEach((element) {
              if(element.iD == testimonialId)
                ele = element;
            });   
            return ele;
          }
      }
    }
  }
  TextEditingController _emailController = new TextEditingController();

  String dropdownvalueFacebook = 'SK';

  // List of items in our dropdown menu
  var facebook = [
    'SK',
    'CZ',
    'EN',
    'DE'
  ];

  String dropdownvalueTelegram = 'SK';

  // List of items in our dropdown menu
  var telegram = [
    'SK',
    'CZ',
    'EN',
    'DE'
  ];

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    _outerSize = _size;

    return SafeArea(
      child: Scaffold(
          backgroundColor: kBackgroundColor,
          // bottomNavigationBar: Container(
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     boxShadow: [
          //       BoxShadow(
          //         color: Color(0x0D000000),
          //         spreadRadius: 1,
          //         blurRadius: 1,
          //         offset: Offset(0, -1), // changes position of shadow
          //       ),
          //     ],
          //   ),
          //   height: 75,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: buildNavigationItems(),
          //   ),
          // ),
          body: FutureBuilder<dynamic>(
              future: getNotification(),
              builder: (context, snapshotss) {
                if (snapshotss.hasData) {
                  return WillPopScope(
                    onWillPop: onWillPop,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            ///Appbar
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                  ),
                                  SizedBox(
                                      height: 120,
                                      width: 120,
                                      child: Image(
                                          image: AssetImage(
                                              'assets/images/logo.png'))),
                                  Container(
                                    child: Row(
                                      children: [
                                        Stack(
                                          children: [
                                            NotificationIcon(),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 13,
                                        ),
                                        PopupMenuButton(
                                            onSelected: (value) async{
                                              if (value == 3) {
                                                signApi api = new signApi();
                                                api.logout();

                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          signIn()),
                                                );
                                                setState(() {});
                                              } else if (value == 1) {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Dialog(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0)), //this right here
                                                        child: Container(
                                                          height: _size.height *
                                                              0.53,
                                                          width:
                                                              _size.width * 0.9,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    0,
                                                                    25,
                                                                    0,
                                                                    20),
                                                            child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    'O aplikácii',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontFamily:
                                                                            'SFProDisplay',
                                                                        fontWeight:
                                                                            FontWeight.w700),
                                                                  ),
                                                                  Image.asset(
                                                                      'assets/images/activstarbox.png',
                                                                      width:
                                                                          100,
                                                                      height:
                                                                          100),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Text(
                                                                    'Activstar',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontFamily:
                                                                            'SFProDisplay',
                                                                        fontWeight:
                                                                            FontWeight.w700),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 8,
                                                                  ),
                                                                  Text(
                                                                    'Verzia: 2.0.0',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontFamily:
                                                                            'SFProDisplay',
                                                                        fontWeight:
                                                                            FontWeight.w400),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  Text(
                                                                    'Vývojár:',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontFamily:
                                                                            'SFProDisplay',
                                                                        fontWeight:
                                                                            FontWeight.w400),
                                                                  ),
                                                                  GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        launchUrl(
                                                                            Uri.parse(
                                                                                "https://www.zarf.sk/"),
                                                                            mode:
                                                                                LaunchMode.externalApplication);
                                                                      },
                                                                      child: Image.asset(
                                                                          'assets/images/zarf.png',
                                                                          width:
                                                                              150,
                                                                          height:
                                                                              150)),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    children: [
                                                                      GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            launchUrl(Uri.parse("https://www.activstar.eu/dokumenty/ochrana-osobnych-udajov.pdf?v=1610242271"),
                                                                                mode: LaunchMode.externalApplication);
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            'Ochrana súkromia',
                                                                            style: TextStyle(
                                                                                decoration: TextDecoration.underline,
                                                                                fontSize: 10,
                                                                                fontFamily: 'SFProDisplay',
                                                                                fontWeight: FontWeight.w400),
                                                                          )),
                                                                      GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            launchUrl(Uri.parse("https://www.activstar.eu/"),
                                                                                mode: LaunchMode.externalApplication);
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            'Activstar.eu',
                                                                            style: TextStyle(
                                                                                decoration: TextDecoration.underline,
                                                                                fontSize: 10,
                                                                                fontFamily: 'SFProDisplay',
                                                                                fontWeight: FontWeight.w400),
                                                                          )),
                                                                    ],
                                                                  )
                                                                ]),
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              }else if (value==2){
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
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              height: MediaQuery.of(context).size.height * 0.25,
                              child: FutureBuilder<Items>(
                                  future: randomItem(), //api.getTestimonials(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      testimonialScreen(
                                                        finalSnapshot: snapshot
                                                            .data as Items,
                                                      )));
                                        },
                                        child: Stack(
                                          children: [
                                            Center(
                                              child: Container(
                                                width: 228,
                                                height: 228,
                                                child: DecoratedBox(
                                                  position: DecorationPosition
                                                      .background,
                                                  decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color:
                                                              Color(0x33000000),
                                                          blurRadius: 30,
                                                          offset: Offset(0, 4))
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    image: DecorationImage(
                                                        opacity: 0.8,
                                                        image: NetworkImage(
                                                            "${snapshot.data!.image}"),
                                                        fit: BoxFit.fill),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: Container(
                                                width: 228,
                                                height: 228,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  gradient: LinearGradient(
                                                    begin:
                                                        Alignment.bottomCenter,
                                                    end: Alignment.topCenter,
                                                    stops: [0.1, 0.7],
                                                    colors: [
                                                      Colors.black
                                                          .withOpacity(0.8),
                                                      Colors.transparent
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                              child: Column(
                                                children: [
                                                  Center(
                                                    child: Container(
                                                      width: 228,
                                                      height: 195,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            width: 190,
                                                            child: Text(
                                                              '''${snapshot.data!.title}''',
                                                              maxLines: 8,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  shadows: [
                                                                    BoxShadow(
                                                                        color: Colors
                                                                            .black12,
                                                                        spreadRadius:
                                                                            1,
                                                                        blurRadius:
                                                                            10)
                                                                  ],
                                                                  fontFamily:
                                                                      'SFProDisplay',
                                                                  fontSize: 21,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );

                                      // return FutureBuilder<dynamic>(
                                      //     future: getPrefs(randomNumber),
                                      //     builder: (context, snapshots) {
                                      //       if (snapshots.hasData) {
                                      //         print("Random Number " +
                                      //             snapshots.data.toString());
                                      //         return InkWell(
                                      //           onTap: () {
                                      //             Navigator.of(context).push(
                                      //                 MaterialPageRoute(
                                      //                     builder: (context) =>
                                      //                         testimonialScreen(
                                      //                           finalSnapshot: snapshot
                                      //                               .data!
                                      //                               .items!
                                      //                               .elementAt(
                                      //                                   snapshots
                                      //                                       .data),
                                      //                         )));
                                      //           },
                                      //           child: Stack(
                                      //             children: [
                                      //               Center(
                                      //                 child: Container(
                                      //                   width: 228,
                                      //                   height: 228,
                                      //                   child: DecoratedBox(
                                      //                     position:
                                      //                         DecorationPosition
                                      //                             .background,
                                      //                     decoration:
                                      //                         BoxDecoration(
                                      //                       boxShadow: [
                                      //                         BoxShadow(
                                      //                             color: Color(
                                      //                                 0x33000000),
                                      //                             blurRadius:
                                      //                                 30,
                                      //                             offset:
                                      //                                 Offset(
                                      //                                     0,
                                      //                                     4))
                                      //                       ],
                                      //                       borderRadius: BorderRadius
                                      //                           .all(Radius
                                      //                               .circular(
                                      //                                   10)),
                                      //                       image: DecorationImage(
                                      //                           opacity: 0.8,
                                      //                           image: NetworkImage(
                                      //                               "${snapshot.data!.items!.elementAt(snapshots.data).image}"),
                                      //                           fit: BoxFit
                                      //                               .fill),
                                      //                     ),
                                      //                   ),
                                      //                 ),
                                      //               ),
                                      //               Center(
                                      //                 child: Container(
                                      //                   width: 228,
                                      //                   height: 228,
                                      //                   decoration:
                                      //                       BoxDecoration(
                                      //                     borderRadius:
                                      //                         BorderRadius
                                      //                             .all(Radius
                                      //                                 .circular(
                                      //                                     10)),
                                      //                     gradient:
                                      //                         LinearGradient(
                                      //                       begin: Alignment
                                      //                           .bottomCenter,
                                      //                       end: Alignment
                                      //                           .topCenter,
                                      //                       stops: [0.1, 0.7],
                                      //                       colors: [
                                      //                         Colors.black
                                      //                             .withOpacity(
                                      //                                 0.8),
                                      //                         Colors
                                      //                             .transparent
                                      //                       ],
                                      //                     ),
                                      //                   ),
                                      //                 ),
                                      //               ),
                                      //               Padding(
                                      //                 padding:
                                      //                     EdgeInsets.fromLTRB(
                                      //                         0, 0, 0, 0),
                                      //                 child: Column(
                                      //                   children: [
                                      //                     Center(
                                      //                       child: Container(
                                      //                         width: 228,
                                      //                         height: 195,
                                      //                         child: Row(
                                      //                           crossAxisAlignment:
                                      //                               CrossAxisAlignment
                                      //                                   .end,
                                      //                           mainAxisAlignment:
                                      //                               MainAxisAlignment
                                      //                                   .center,
                                      //                           children: [
                                      //                             Container(
                                      //                               width:
                                      //                                   190,
                                      //                               child:
                                      //                                   Text(
                                      //                                 '''${snapshot.data!.items!.elementAt(snapshots.data).title}''',
                                      //                                 maxLines:
                                      //                                     8,
                                      //                                 textAlign:
                                      //                                     TextAlign.center,
                                      //                                 style: TextStyle(
                                      //                                     shadows: [
                                      //                                       BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 10)
                                      //                                     ],
                                      //                                     fontFamily:
                                      //                                         'SFProDisplay',
                                      //                                     fontSize:
                                      //                                         21,
                                      //                                     fontWeight:
                                      //                                         FontWeight.w700,
                                      //                                     color: Colors.white),
                                      //                               ),
                                      //                             ),
                                      //                           ],
                                      //                         ),
                                      //                       ),
                                      //                     ),
                                      //                   ],
                                      //                 ),
                                      //               ),
                                      //             ],
                                      //           ),
                                      //         );
                                      //       } else {
                                      //         return CircularProgressIndicator();
                                      //       }
                                      //     });
                                    }

                                    //_getImageDimension(snapshot.data?.items?.elementAt(randomNumber).thumbnail);

                                    else {
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
                            SizedBox(
                              height: _size.height * 0.03,
                            ),
                            FutureBuilder<Map<String, dynamic>>(
                                future: newsApi().getAccountInfo(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data!["group"]["id"]
                                            .toString() ==
                                        "1") {
                                      return Container();
                                    } else {
                                      var widthInstances =
                                          (_size.width * 0.9) / 8;
                                      var totalWidth = (widthInstances) *
                                          snapshot.data!["recruiter"]["rank"]
                                              ["level"];
                                      return Container(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Aktuálna výška provízii:',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'SFProDisplay',
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${snapshot.hasData ? snapshot.data!["provision"] : ""}Є‎',
                                                      style: TextStyle(
                                                          fontSize: 32,
                                                          fontFamily:
                                                              'SFProDisplay',
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: _size.width * 0.2,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Počet ľudí v tíme:',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'SFProDisplay',
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Icon(
                                                          Icons.person_outline,
                                                          size: 30,
                                                        ),
                                                        Text(
                                                          '${snapshot.hasData ? snapshot.data!["team"]["count"] : ""}',
                                                          style: TextStyle(
                                                              fontSize: 32,
                                                              fontFamily:
                                                                  'SFProDisplay',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      sliderMarks(
                                                          ammount: "200Є",
                                                          persons: "20"),
                                                      sliderMarks(
                                                          ammount: "500Є",
                                                          persons: "50"),
                                                      sliderMarks(
                                                          ammount: "1000Є",
                                                          persons: "100"),
                                                      sliderMarks(
                                                          ammount: "2500Є",
                                                          persons: "250"),
                                                      sliderMarks(
                                                          ammount: "5000Є",
                                                          persons: "500"),
                                                      sliderMarks(
                                                          ammount: "10000Є",
                                                          persons: "1000"),
                                                      sliderMarks(
                                                          ammount: "20000Є",
                                                          persons: "2000"),
                                                    ],
                                                  ),
                                                  Container(
                                                      height: 30,
                                                      width: _size.width * 0.9,
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .grey.shade300,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: totalWidth,
                                                            height: 30,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFF775434),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),

                                            //Invitationnn hereeeeeeeeeeeeeeeeeeeeee
                                            GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Dialog(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                20.0)), //this right here
                                                        child: Container(
                                                          height: _size.height *
                                                              0.75,
                                                          width:
                                                          _size.width * 0.95,
                                                          child: Padding(
                                                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                                            child: Column(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                                children: [
                                                                  Text('Poslať známemu', style: TextStyle(
                                                                      fontSize: 20,
                                                                      color: Colors.black,
                                                                      fontFamily:
                                                                      'SFProDisplay',
                                                                      fontWeight:
                                                                      FontWeight.w700),),
                                                                  Text('Emailová adresa vášho známeho', style: TextStyle(
                                                                      fontSize: 11,
                                                                      color: Colors.black,
                                                                      fontFamily:
                                                                      'SFProDisplay',
                                                                      fontWeight:
                                                                      FontWeight.w400),),
                                                                  Container(
                                                                    height: 60,
                                                                    width: MediaQuery.of(context).size.width * 0.6,
                                                                    decoration: BoxDecoration(
                                                                      color: Colors.white,
                                                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                      border: Border.all(color: Color(0xffE5E5E5), width: 2)
                                                                    ),
                                                                    child: Card(
                                                                      elevation: 0.0,
                                                                      color: Colors.transparent,
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                                                                        child: TextFormField(
                                                                          validator:  (String? value) {
                                                                            return null;
                                                                          },
                                                                          controller: _emailController,
                                                                          decoration: const InputDecoration(
                                                                              border: InputBorder.none,
                                                                              hintText: "Email",
                                                                              hintStyle: TextStyle(
                                                                                fontFamily: 'SFProDisplay',
                                                                                color: Colors.black,
                                                                                fontSize: 16,)),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Text('Váš známy dostane email s týmito informáciami:', style: TextStyle(
                                                                      fontSize: 11,
                                                                      color: Colors.black,
                                                                      fontFamily:
                                                                      'SFProDisplay',
                                                                      fontWeight:
                                                                      FontWeight.w400),),

                                                                  getCheckRow('Registrácia', 'Bezplatné členstvo a vlastný eshop'),
                                                                  getCheckRow('Produktový katalóg', 'Aktuálna ponuka produktov'),
                                                                  getCheckRow('Obchodná príležitosť', 'Spolupráca - marža, bonusy, renta'),
                                                                  getCheckRow('Produktová ochutnávka', 'Ochutnávka + analýza zdravia'),
                                                                  getCheckRow('Skúsenosti s produktami', 'Referencie našich odberateľov'),

                                                                  GestureDetector(
                                                                    onTap: () async{

                                                                      signApi sign = new signApi();
                                                                      var res = await sign.invitePerson(_emailController.text.trim());
                                                                      Navigator.pop(context);
                                                                      if(res == true){
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
                                                                                        Container(
                                                                                          height: 50,
                                                                                          width: 50,
                                                                                          decoration: BoxDecoration(
                                                                                              shape: BoxShape.circle,
                                                                                              border: Border.all(color: Colors.black, width: 1)
                                                                                          ),
                                                                                          child: Icon(EvaIcons.checkmark, color: Colors.green, size: 40,),
                                                                                        ),
                                                                                        Text(
                                                                                          'Pozvanie Odoslať úspešne',
                                                                                          style: TextStyle(
                                                                                              color: Colors.black,
                                                                                              fontSize: 18,
                                                                                              fontFamily: 'SFProDisplay',
                                                                                              fontWeight: FontWeight.w600),
                                                                                        ),
                                                                                      ],),
                                                                                  )
                                                                              ),
                                                                            );
                                                                          });
                                                                      } else {
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
                                                                                          Container(
                                                                                            height: 50,
                                                                                            width: 50,
                                                                                            decoration: BoxDecoration(
                                                                                                shape: BoxShape.circle,
                                                                                                border: Border.all(color: Colors.black, width: 1)
                                                                                            ),
                                                                                            child: Icon(EvaIcons.close, color: Colors.red, size: 40,),
                                                                                          ),
                                                                                          Text(
                                                                                            'Pozvánka nebola odoslaná',
                                                                                            style: TextStyle(
                                                                                                color: Colors.black,
                                                                                                fontSize: 18,
                                                                                                fontFamily: 'SFProDisplay',
                                                                                                fontWeight: FontWeight.w600),
                                                                                          ),
                                                                                        ],),
                                                                                    )
                                                                                ),
                                                                              );
                                                                            });
                                                                      }



                                                                    },
                                                                    child: Container(
                                                                      width: 145,
                                                                      height: 40,
                                                                      decoration: BoxDecoration(
                                                                          color: Color(0xFFDEC13C),
                                                                            borderRadius: BorderRadius.circular(5)),
                                                                      child: const Center(
                                                                        child: Text(
                                                                          "ODOSLAŤ",
                                                                          style: TextStyle(
                                                                              fontFamily: 'SFProDisplay',
                                                                              fontWeight: FontWeight.w600,
                                                                              fontSize: 14,
                                                                              color: Colors.white),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                    children: [
                                                                      Container(
                                                                        width: _size.width *
                                                                            0.27,
                                                                        height: 30,
                                                                        decoration: BoxDecoration(
                                                                            border: Border.all(color: Color(0xffDEC13C), width: 2)

                                                                        ),
                                                                        child: DropdownButtonHideUnderline(
                                                                          child:  DropdownButton<String>(
                                                                            // Initial Value
                                                                            value: dropdownvalueFacebook,
                                                                            // Down Arrow Icon
                                                                            icon: const Icon(Icons.arrow_drop_down_outlined),
                                                                            // Array list of items
                                                                            items: facebook.map((String items) {
                                                                              return DropdownMenuItem(
                                                                                value: items,
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                  children: [
                                                                                    SizedBox(width: 5,),
                                                                                    Icon(Icons.facebook, color: Color(0xff039BE5),),
                                                                                    SizedBox(width: 5,),
                                                                                    Text(items,
                                                                                      style: TextStyle(
                                                                                          fontFamily: 'SFProText',
                                                                                          fontWeight: FontWeight.w500,
                                                                                          fontSize: 13,
                                                                                          color: Colors.black),),
                                                                                  ],
                                                                                ),
                                                                              );
                                                                            }).toList(),
                                                                            // After selecting the desired option,it will
                                                                            // change button value to selected value
                                                                            onChanged: (String? newValue) async{
                                                                              SharedPreferences prefs = await SharedPreferences.getInstance();
                                                                              String? facebookLink = prefs.getString("fbShare");
                                                                              String? temp = facebookLink?.substring(0, facebookLink.length - 2);
                                                                              String facebookFinal = temp! + newValue!.toLowerCase();
                                                                              print(facebookFinal);
                                                                              if((facebookLink == null) || (facebookLink.length == 0)){

                                                                              } else
                                                                                launchUrl(
                                                                                  Uri.parse(
                                                                                      facebookLink),
                                                                                  mode: LaunchMode
                                                                                      .inAppWebView);
                                                                              setState(() {
                                                                                dropdownvalueFacebook = newValue!;
                                                                              });

                                                                            },
                                                                          ),),

                                                                      ),

                                                                      Container(
                                                                        width: _size.width *
                                                                            0.27,
                                                                        height: 30,
                                                                        decoration: BoxDecoration(
                                                                          border: Border.all(color: Color(0xffDEC13C), width: 2)

                                                                        ),
                                                                        child: DropdownButtonHideUnderline(
                                                                          child: DropdownButton<String>(

                                                                            // Initial Value
                                                                            value: dropdownvalueTelegram,
                                                                            // Down Arrow Icon
                                                                            icon: const Icon(Icons.arrow_drop_down_outlined),
                                                                            // Array list of items
                                                                            items: telegram.map((String items) {
                                                                              return DropdownMenuItem(
                                                                                value: items,
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                  children: [
                                                                                    SizedBox(width: 5,),
                                                                                    Icon(Icons.telegram_outlined, color: Color(0xff1976D2),),
                                                                                    SizedBox(width: 5,),
                                                                                    Text(items,
                                                                                      style: TextStyle(
                                                                                          fontFamily: 'SFProText',
                                                                                          fontWeight: FontWeight.w500,
                                                                                          fontSize: 13,
                                                                                          color: Colors.black),),
                                                                                  ],
                                                                                ),
                                                                              );
                                                                            }).toList(),
                                                                            // After selecting the desired option,it will
                                                                            // change button value to selected value
                                                                            onChanged: (String? newValue) async{
                                                                              SharedPreferences prefs = await SharedPreferences.getInstance();
                                                                              String? telegramLink = prefs.getString("telegramShare");
                                                                              String? temp = telegramLink?.substring(0, telegramLink.length - 2);
                                                                              String telegramFinal = temp! + newValue!.toLowerCase();
                                                                              print(telegramFinal);
                                                                              if((telegramLink == null) || (telegramLink.length == 0)){

                                                                              } else
                                                                                launchUrl(
                                                                                    Uri.parse(
                                                                                        telegramLink),
                                                                                    mode: LaunchMode
                                                                                        .inAppWebView);
                                                                              setState(() {
                                                                                dropdownvalueTelegram = newValue!;
                                                                              });
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                ]),
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    bottom: 15,
                                                    left: 30,
                                                    right: 30),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    SizedBox(
                                                        height: 17,
                                                        width: 17,
                                                        child: Image.asset(
                                                            'assets/images/account.png')),
                                                    Text(
                                                      'Pozvať známeho',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.brown,
                                                          fontFamily:
                                                              'SFProText',
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  bottomNavigationBar(0)),
                                        );
                                      });
                                    },
                                    child: _getItem(_size,
                                        'assets/images/juice.png', 'Produkty')),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  bottomNavigationBar(2)),
                                        );
                                      });
                                    },
                                    child: _getItem(
                                        _size,
                                        'assets/images/newspaper.png',
                                        'Články')),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Colors.brown,
                  ));
                }
              })),
    );
  }

  getPrefs(randomNumbers) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? getDate = preferences.getString('testimonialDate');

    if (getDate == null) {
      print("Here 1");
      preferences.setString(
          'testimonialDate', DateTime.now().add(Duration(days: 1)).toString());
      preferences.setInt('testimonialNumber', randomNumbers);
      print(randomNumbers);
      return randomNumbers;
    } else {
      print("Here 2");
      DateTime dateTime = DateTime.parse(getDate);
      if (DateTime.now().compareTo(dateTime) > 0) {
        print("Here 3");
        preferences.setString('testimonialDate',
            DateTime.now().add(Duration(days: 1)).toString());
        preferences.setInt('testimonialNumber', randomNumbers);
        print(randomNumbers);
        return randomNumbers;
      } else {
        print("Here 4");
        int? randomNumber = preferences.getInt('testimonialNumber');
        print(randomNumber);
        return randomNumber;
      }
    }
  }

  getCheckRow(String title, String description){
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 5, 0, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        Container(
          height: 25,
          width: 25,
          decoration: BoxDecoration(
              color: Color(0xff00FF29),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 2)
          ),
          child: Icon(Icons.check, color: Colors.white, size: 20,),
        ),
        SizedBox(width: 20,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(title, style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontFamily:
              'SFProText',
              fontWeight:
              FontWeight.w600),),
          Text(description, style: TextStyle(
              fontSize: 10,
              color: Colors.black,
              fontFamily:
              'SFProText',
              fontWeight:
              FontWeight.w400),)
        ],)
      ],),
    );
  }

  getDialog(Size _size) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              width: _size.width * 0.9,
              height: 450,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Vitajte!',
                    style: TextStyle(
                        fontFamily: 'SFProDisplay',
                        fontWeight: FontWeight.w700,
                        fontSize: 20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/images/sparkLeft.png',
                          width: 100, height: 100),
                      Image.asset('assets/images/logo.png',
                          width: 100, height: 100),
                      Image.asset('assets/images/sparkRight.png',
                          width: 100, height: 100),
                    ],
                  ),
                  Text(
                    'Ďakujeme, že ste si stiahli aplikáciu Activstar. Veríme, že vám prinesie mnoho hodnotných informácií a akciových ponúk. Ako poďakovanie sme pre vás pripravili darček.',
                    style: TextStyle(fontFamily: 'SFProText'),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Pri prvej objednávke nad 100 bodov získate darček v hodnote 40€+!',
                    style: TextStyle(
                        fontFamily: 'SFProText', fontWeight: FontWeight.w700),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          launchUrl(
                              Uri.parse("https://www.activstar.eu/account"),
                              mode: LaunchMode.externalApplication);
                        },
                        child: Container(
                            width: _size.width * 0.35,
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xFFDEC13C),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'OBJEDNAŤ',
                                  style: TextStyle(
                                      fontFamily: 'SFProText',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                                Text(
                                  'prejsť do e-shopu',
                                  style: TextStyle(
                                      fontFamily: 'SFProText',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 8,
                                      color: Colors.white),
                                ),
                              ],
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: _size.width * 0.35,
                          height: 45,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Color(0xFFDEC13C), width: 2),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          child: Center(
                              child: Text(
                            'ZATVORIŤ',
                            style: TextStyle(
                              fontFamily: 'SFProText',
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Color(0xFFDEC13C),
                            ),
                          )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _getItem(Size _size, String image, String title) {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Color(0x33DEC13C), blurRadius: 30, offset: Offset(0, 4))
        ],
        borderRadius: BorderRadius.circular(15),
        color: Color(0xFFDEC13C),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
              child: Container(
                  height: title != 'Produckty' ? 100 : 106,
                  width: title != 'Produckty' ? 123 : 106,
                  child: Image(image: AssetImage('$image'), fit: BoxFit.fill))),
          title != 'Produckty'
              ? SizedBox(
                  height: 6,
                )
              : Container(),
          Text(
            '$title',
            style: TextStyle(
                fontSize: 18,
                fontFamily: 'SFProDisplay',
                fontWeight: FontWeight.w700,
                color: Colors.white),
          ),
          SizedBox(
            height: 10,
          )
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

  List<Widget> buildNavigationItems() {
    List<Widget> list = [];
    for (var navigationItem in navigationItems) {
      list.add(buildNavigationItem(navigationItem));
    }
    return list;
  }

  Widget buildNavigationItem(NavigationItem item) {
    return item.name == 'Notifications'
        ? SizedBox.shrink()
        : GestureDetector(
            onTap: () {
              setState(() {
                selectedItem = item;
              });
            },
            child: Container(
              padding: EdgeInsets.all(14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 24,
                      width: 24,
                      child: selectedItem == item
                          ? Image.asset('${item.enabledImage}')
                          : Image.asset('${item.image}')),
                  // Icon(
                  //     item.iconData,
                  //     color: selectedItem == item ? kPrimaryColor : Colors.grey[400],
                  //     size: 28,
                  //   ),

                  Container(
                    height: 5,
                  ),

                  Text(
                    '${item.name}',
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w700,
                      color: selectedItem == item
                          ? kPrimaryColor
                          : Colors.grey[400],
                    ),
                  )
                ],
              ),
            ),
          );
  }

  Widget item(n1, n2) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.person_outlined,
              size: 18,
            ),
            Text(
              "$n1",
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            )
          ],
        ),
        Text(
          "$n2",
          style: TextStyle(
            fontSize: 11,
          ),
        ),
        const Text(
          "I",
          style: TextStyle(
            fontSize: 11,
          ),
        )
      ],
    );
  }

  sliderMarks({var persons, var ammount}) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.person_outline,
                size: 11,
              ),
              Text(
                '$persons',
                style: TextStyle(
                    fontFamily: 'SFProDisplay',
                    fontSize: 12,
                    color: Colors.black),
              ),
            ],
          ),
          Text(
            '$ammount',
            style: TextStyle(
              fontFamily: 'SFProDisplay',
              fontSize: 11,
              color: Color(0XFF9FA6B2),
            ),
          ),
          Container(
              height: 10,
              child: VerticalDivider(
                width: 3,
                color: Colors.black,
              ))
        ],
      ),
    );
  }

  Widget _getContainer(Size _size) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      width: _size.width * 0.41,
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Color(0x33000000), blurRadius: 30, offset: Offset(0, 4))
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/images/juice.png'),
          Text(
            'Activ NO Drink 1 sáčok',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontFamily: 'SFProText',
                fontWeight: FontWeight.w700,
                fontSize: _size.width * 0.04),
          ),
          SizedBox(
            height: _size.height * 0.005,
          ),
          Text(
            '0,88€ bez DPH',
            style: TextStyle(
                fontFamily: 'SFProDisplay',
                fontSize: 12,
                color: Color(0xFF9FA6B2)),
          ),
          SizedBox(
            height: _size.height * 0.0025,
          ),
          Text(
            '1,06€ s DPH',
            style: TextStyle(
                fontFamily: 'SFProText',
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: kPrimaryColor),
          ),
        ],
      ),
    );
  }
}

class cards {
  cards({this.name, this.image});
  String? name;
  String? image;
}
