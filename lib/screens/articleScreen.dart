import 'package:activstar/api/newsApi.dart';
import 'package:activstar/models/newsModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:html/dom.dart' as dom;
import 'package:url_launcher/url_launcher.dart';

class ArticleScreen extends StatelessWidget {
  ArticleScreen({required this.index});
  int index;
  List<String> _titles = [
    "INZERCIA - Texty na oslovanie",
    "INZERCIA - Texty na oslovanie",
    "INZERCIA - Texty na oslovanie"
  ];
  newsApi api = new newsApi();

  Future<void> share(var title, var linkUrl) async {
    await FlutterShare.share(
        title: title,
        linkUrl: linkUrl,);
  }

  
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<newsModel>(
        future:api.getNews(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        // //get Link
        // dom.Document document = htmlparser.parse(snapshot.data?.items.elementAt(index).excerpt);
        // var data = document.getElementsByTagName('a')[0].attributes;
        // var dataLink = data['href'].toString();
        // String dataT = document.getElementsByTagName('span')[0].innerHtml.toString().trim();
        // var dataText = dataT.substring(1, (dataT.length - 1));


        // //get description
        // var descriptionTemp = snapshot.data?.items.elementAt(index).excerpt;
        // int x = descriptionTemp!.indexOf('<p class=\"link-more\">');
        // var description = descriptionTemp.substring(0, x-2);
        



       return SingleChildScrollView(
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                            color: Colors.red,
                            width: _size.width,
                            child: Image(image:  NetworkImage("${snapshot.data?.items!.elementAt(index).image}"),)),
                            
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
                          child: Ink(
                            decoration: BoxDecoration(
                                    color: Colors.red,
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
                      padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "${snapshot.data?.items!.elementAt(index).title}",
                              style: TextStyle(
                                  fontFamily: 'SFProDisplay',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              SizedBox(width: 10,),
                              Text(
                                "${snapshot.data?.items!.elementAt(index).publishedDate.toString().replaceAll("T09:10:18+00:00", "")} ",
                                style: TextStyle(
                                    fontFamily: 'SFProDisplay',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.grey),
                              ),
                              Container(
                                height: 20,
                                width: _size.width * 0.45,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.items!.elementAt(index).category!.length,
                                  itemBuilder: (context, indexx) {
                                    return Text(
                                        indexx == (snapshot.data!.items!.elementAt(index).category!.length- 1) ? 
                                        "${snapshot.data!.items!.elementAt(index).category!.elementAt(indexx)}": 
                                        "${snapshot.data!.items!.elementAt(index).category!.elementAt(indexx)}" + ", " 
                                        , 
                                        style: TextStyle(
                                            fontFamily: 'SFProDisplay',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                    );
                                  },
                                ),
                              ),
                              // Text(
                              //             "Nezaradené",
                              //             style: TextStyle(
                              //                 fontFamily: 'SFProDisplay',
                              //                 fontWeight: FontWeight.bold,
                              //                 fontSize: 14),
                              //         ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                            child: GestureDetector(
                              onTap: () {
                                share(snapshot.data!.items!.elementAt(index).title, snapshot.data!.items!.elementAt(index).link);
                              },
                              child: Container(
                                width: 145,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Color(0xFFDEC13C),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                            ..color = Colors.black
                                        ),
                                      ),
                                      // Solid text as fill.
                                      Text(
                                        'Zdieľajte článok',
                                        style: TextStyle(
                                          color: Colors.transparent
                                        ),
                                      ),
                                    ],
                                  )
                                ]),
                              ),
                            ),
                          ),

                          Html(
                            data:
                            '${snapshot.data?.items!.elementAt(index).fullDescription}',
                          ),
                            Padding(
                                padding: const EdgeInsets.only(left: 10.0, bottom: 30),
                                child: Row( 
                                  children: [
                                    Text('Continue Reading: '),
                                    GestureDetector(
                                      onTap: () {
                                        launchUrl(Uri.parse("${snapshot.data?.items!.elementAt(index).link}"),
                                        mode: LaunchMode.externalApplication
                                        );  
                                      },
                                      child: Container(
                                        width: _size.width * 0.53,
                                        child: Text('''${snapshot.data?.items!.elementAt(index).title}''', style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline, decorationThickness: 1.5, overflow: TextOverflow.clip),))),
                                  ],
                                ),
                              ),
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
        );
      } else {
        return Center(child: Container(
          height: 30, width: 30,
          child: CircularProgressIndicator(color: Colors.brown,),
        ),);
      }
    }
    ),
      ),
    );
  }
}
