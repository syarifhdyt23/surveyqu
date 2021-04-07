import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:surveyqu/domain.dart';
import 'dart:async';
import 'dart:convert';

import 'package:surveyqu/info.dart';

class Home extends StatefulWidget {
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  Info info = new Info();
  Size size;
  Domain domain = new Domain();
  bool _visible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blue.withOpacity(.2),
      body: new Stack(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.only(top: 250),
            color: Colors.white ,
            child: new Scrollbar(
              child: new ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: 15,
                itemBuilder: (context, i) {
                  return new InkWell(
                    onTap: () {
                    },
                    child: new Container(
                      height: 100,
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 20, right: 20),
                      child: new Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.circular(15),
                            side: BorderSide(width: 1)
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: new Container(
                          alignment: Alignment.center,
                          child: new Text("Lorem Ipsum"),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ),
          // new Container(
          //   width: size.width,
          //   height: 50,
          //   margin: EdgeInsets.only(top: 200),
          //   decoration: BoxDecoration(
          //     color: Colors.green,
          //   ),
          // ),
          new Container(
            height: 150,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                new Container(
                  width: 150,
                  margin: const EdgeInsets.only(left: 10.0),
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new AssetImage('images/logo.png'),
                    ),
                  ),
                ),
                new Container(
                  margin: const EdgeInsets.only(right: 30.0),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(20.0))
                  ),
                  child: new Icon(Icons.insert_drive_file, color: Colors.white,),
                ),
              ],
            ),
          ),
          new Container(
            width: size.width,
            height: 45,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 20, right: 20, top: 120),
            child: new Text("Hi Faisal, Selamat Datang", style: TextStyle(),)
          ),
          new Container(
            height: 80,
            width: size.width,
            margin: const EdgeInsets.only(top: 160, left: 20, right: 20),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1),
                borderRadius: BorderRadius.all(Radius.circular(15.0))
            ),
            child: new Row(
              children: <Widget>[
                new Expanded(
                  flex: 1,
                  child: new Container(
                    child: new Row(
                      children: [
                        new Container(
                            margin: const EdgeInsets.only(
                              left: 20,
                            ),
                            child: new Icon(CupertinoIcons.money_dollar)
                        ),
                        new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            new Container(
                              margin: const EdgeInsets.only(left: 10, right: 10),
                              child: new Text(
                                'Reward',
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: new TextStyle(
                                  fontFamily: "helvetica,bold",
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                              ),
                            ),
                            new Container(
                              margin: const EdgeInsets.only(left: 10,),
                              child: new Text(
                                'Rp, 0',
                                style: new TextStyle(
                                    fontFamily: "helvetica, bold",
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                new VerticalDivider(width: 1, color: Colors.black, thickness: 1,),
                new Expanded(
                  flex: 1,
                  child: new Container(
                    child: new Row(
                      children: [
                        new Container(
                            margin: const EdgeInsets.only(
                              left: 20,
                            ),
                            child: new Icon(CupertinoIcons.money_dollar)
                        ),

                        new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            new Container(
                              margin: const EdgeInsets.only(left: 10, right: 10),
                              child: new Text(
                                'Score',
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: new TextStyle(
                                  fontFamily: "helvetica,bold",
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                              ),
                            ),
                            new Container(
                              margin: const EdgeInsets.only(left: 10,),
                              child: new Text(
                                '100 Poin',
                                style: new TextStyle(
                                    fontFamily: "helvetica, bold",
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
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
  }
}
