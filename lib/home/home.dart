import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:surveyqu/domain.dart';
import 'dart:async';
import 'dart:convert';

import 'package:surveyqu/info.dart';

import '../hexacolor.dart';
import '../hexacolor.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
            return <Widget>[
              appbarWidget(),
              imageWidget(),
              pointWidget()
            ];
          },
          body: Card(
            child: ListTile(
              title: Text('3'),
            ),
          )
      ),
    );
  }

  SliverAppBar imageWidget() {
    return SliverAppBar(
      backgroundColor: new HexColor('#2670A1'),
      expandedHeight: 100,
      elevation: 0,
      flexibleSpace: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
          background: Container(
            decoration: BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage('images/bannerlandscape.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: new Stack(
              children: [
                new Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(bottom: 10),
                  child: new Text(
                    "Hai Faisal, Selamat Datang",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )
                )
              ],
            )
          ),
        );
      }),
    );
  }

  SliverAppBar appbarWidget() {
    return SliverAppBar(
      backgroundColor: new HexColor('#256fa0'),
      pinned: true,
      expandedHeight: 80,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(left: 20,bottom: 15),
        title: new Container(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              new Text("SurveyQu",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  )),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  new Container(
                    margin: const EdgeInsets.only(right: 10.0,),
                    child: new Icon(
                      Icons.search,
                      color: Colors.white,
                      size: kToolbarHeight - 30,
                    ),
                  ),
                  new Container(
                    margin: const EdgeInsets.only(right: 15.0,),
                    child: new Icon(
                      Icons.notifications,
                      color: Colors.white,
                      size: kToolbarHeight - 30,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ),
    );
  }

  SliverAppBar profileWidget() {
    return SliverAppBar(
      // pinned: false,
      backgroundColor: Colors.transparent,
      floating: true,
      expandedHeight: 100,
      elevation: 0,
      title: SizedBox(
          child: new Positioned(
            bottom: 10,
              child: new Text(
                "Hi Faisal, Selamat Datang",
                style: TextStyle(color: Colors.black),
              )
          )
      ),
    );
  }

  SliverAppBar pointWidget() {
    return SliverAppBar(
      backgroundColor: Colors.white,
      pinned: false,
      expandedHeight: 68,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
          titlePadding: EdgeInsets.all(0),
          title: new Container(
            height: 70,
            child: new Stack(
              children: [
                new Container(
                  height: 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          new HexColor('#2e7eb3'),
                          new HexColor('#2670A1'),
                        ],
                      ),
                    // color: new HexColor('#2670A1'),
                  ),
                ),
                new Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: new Card(
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Expanded(
                          flex: 1,
                          child: new Container(
                            child: new Row(
                              children: [
                                new Container(
                                    margin: const EdgeInsets.only(
                                      left: 10,
                                    ),
                                    child: new Icon(CupertinoIcons.bookmark)),
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
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        maxLines: 1,
                                      ),
                                    ),
                                    new Container(
                                      margin: const EdgeInsets.only(
                                        left: 10,
                                      ),
                                      child: new Text(
                                        'Rp, 0',
                                        style: new TextStyle(
                                            fontFamily: "helvetica, bold",
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        new Expanded(
                          flex: 1,
                          child: new Container(
                            child: new Row(
                              children: [
                                new Container(
                                    margin: const EdgeInsets.only(
                                      left: 20,
                                    ),
                                    child: new Icon(CupertinoIcons.money_dollar)),
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
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        maxLines: 1,
                                      ),
                                    ),
                                    new Container(
                                      margin: const EdgeInsets.only(
                                        left: 10,
                                      ),
                                      child: new Text(
                                        '100 Poin',
                                        style: new TextStyle(
                                            fontFamily: "helvetica, bold",
                                            color: Colors.black,
                                            fontSize: 10,
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
                )
              ],
            )
          ),
      ),
    );
  }
}