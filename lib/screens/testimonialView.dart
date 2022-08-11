import 'package:activstar/models/testimonialModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api/newsApi.dart';

class testimonialScreen extends StatelessWidget {
  testimonialScreen({Key? key, required this.finalSnapshot}) : super(key: key);
  Items finalSnapshot;

  newsApi api = new newsApi();

  Future<void> share(var title, var linkUrl) async {
    await FlutterShare.share(
      title: title,
      linkUrl: linkUrl,
    );
  }

  @override
  Widget build(BuildContext context) {
    //print(finalSnapshot);

    Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                            color: Colors.red,
                            width: _size.width,
                            child: Image(
                              image: NetworkImage("${finalSnapshot.image}"),
                            )),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
                          child: Ink(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            child: SizedBox(
                              width: 35,
                              height: 35,
                              child: IconButton(
                                  color: Colors.black,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      size: 18,
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "${finalSnapshot.title}",
                              style: TextStyle(
                                  fontFamily: 'SFProDisplay',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 4, 0, 4),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  // TextSpan(
                                  //     text: 'endTime is empty String ',
                                  //     style: TextStyle(
                                  //       color: Colors.black,
                                  //       fontFamily: 'SFProDisplay',
                                  //     )),
                                  TextSpan(
                                      text: " Aktuality",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'SFProDisplay',
                                      ))
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                            child: GestureDetector(
                              onTap: () {
                                share(finalSnapshot.title, finalSnapshot.link);
                              },
                              child: Container(
                                width: 145,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Color(0xFFDEC13C),
                                ),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.share, size: 17),
                                      Stack(
                                        children: <Widget>[
                                          // Stroked text as border.
                                          Text(
                                            'Zdieľajte článok',
                                            style: TextStyle(
                                                foreground: Paint()
                                                  ..style = PaintingStyle.stroke
                                                  ..strokeWidth = 1
                                                  ..color = Colors.black),
                                          ),
                                          // Solid text as fill.
                                          Text(
                                            'Zdieľajte článok',
                                            style: TextStyle(
                                                color: Colors.transparent),
                                          ),
                                        ],
                                      )
                                    ]),
                              ),
                            ),
                          ),
                          Html(
                            data: '${finalSnapshot.fullDescription}',
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, bottom: 30),
                            child: Row(
                              children: [
                                Text('Continue Reading: '),
                                GestureDetector(
                                    onTap: () {
                                      launchUrl(
                                          Uri.parse("${finalSnapshot.link}"),
                                          mode: LaunchMode.externalApplication);
                                    },
                                    child: Container(
                                        width: _size.width * 0.53,
                                        child: Text(
                                          '''${finalSnapshot.title}''',
                                          style: TextStyle(
                                              color: Colors.blue,
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationThickness: 1.5,
                                              overflow: TextOverflow.clip),
                                        ))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
