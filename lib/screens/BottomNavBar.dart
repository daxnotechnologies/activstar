import 'package:activstar/screens/Clanky.dart';
import 'package:activstar/screens/Product.dart';
import 'package:activstar/screens/homePage.dart';
import 'package:activstar/screens/notificationsPage.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class bottomNavigationBar extends StatefulWidget {
  bottomNavigationBar(this.selectedIndex);
  var selectedIndex;

  final RouteLogin = true;
  static var notification = false;
  @override
  bottomNavigationBarState createState() => bottomNavigationBarState();
}

class bottomNavigationBarState extends State<bottomNavigationBar> {
  @override
  void initState() {
    super.initState();
  }

  var smallHeading = 15.0;
  var largeHeading = 20.0;
  static List<Widget> _widgetOptions = <Widget>[
    Produkty(),
    HomePage(),
    clanky(),
  ];

  Future<bool> onWillPop() {
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 1,
                  spreadRadius: 1,
                  offset: Offset(0, 0))
            ]),
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  child: Container(
                    height: 55,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widget.selectedIndex != 0
                            ? Image(
                                image: AssetImage(
                                    'assets/images/product_disabled.png'),
                                height: 25,
                                width: 25,
                              )
                            : Image(
                                image: AssetImage(
                                    'assets/images/product_enabled.png'),
                                height: 25,
                                width: 25,
                              ),
                        Text(
                          "Produkty",
                          style: TextStyle(
                              fontFamily: 'SFProDisplay',
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: widget.selectedIndex == 0
                                  ? Colors.brown
                                  : Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      widget.selectedIndex = 0;
                    });
                  },
                ),
                InkWell(
                  child: Container(
                    height: 55,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widget.selectedIndex != 1
                            ? Image(
                                image: AssetImage(
                                    'assets/images/home_disabled.png'),
                                height: 25,
                                width: 25,
                              )
                            : Image(
                                image: AssetImage(
                                    'assets/images/home_disabled.png'),
                                height: 25,
                                width: 25,
                                color: Colors.brown,
                              ),
                        Text(
                          "Domov",
                          style: TextStyle(
                              fontFamily: 'SFProDisplay',
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: widget.selectedIndex == 1
                                  ? Colors.brown
                                  : Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      widget.selectedIndex = 1;
                    });
                  },
                ),
                InkWell(
                  child: Container(
                    height: 55,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widget.selectedIndex != 2
                            ? Image(
                                image: AssetImage(
                                    'assets/images/articles_disabled.png'),
                                height: 25,
                                width: 25,
                              )
                            : Image(
                                image: AssetImage(
                                    'assets/images/articles_disabled.png'),
                                height: 25,
                                width: 25,
                                color: Colors.brown,
                              ),
                        Text(
                          "Články",
                          style: TextStyle(
                              fontFamily: 'SFProDisplay',
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: widget.selectedIndex == 2
                                  ? Colors.brown
                                  : Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      widget.selectedIndex = 2;
                    });
                  },
                ),
              ],
            )),
        elevation: 2,
      ),
      body: WillPopScope(
        onWillPop: onWillPop,
        child: bottomNavigationBar.notification
            ? Visibility(
                child: Scaffold(
                body: SafeArea(
                  child: NotificationsPage(),
                ),
              ))
            : _widgetOptions.elementAt(widget.selectedIndex),
      ),
    );
  }

  void _onTap(int index) {
    widget.selectedIndex = index;
    setState(() {});
  }
}
