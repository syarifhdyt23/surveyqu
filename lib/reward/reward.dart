import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:surveyqu/domain.dart';
import 'dart:async';
import 'dart:convert';

import 'package:surveyqu/info.dart';

class Reward extends StatefulWidget {
  _Reward createState() => _Reward();
}

class _Reward extends State<Reward> {
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

    return new Scaffold(
      body: new Container(
        color: Colors.white,
        child: new Stack(
          children: <Widget>[
            new Container(
                width: size.width,
                margin: const EdgeInsets.only(top: 100, left: 15, right: 15),
                child: new Column(
                  children: [
                    new Container(
                      alignment: Alignment.centerLeft,
                      child: new Text(
                        'Saldo Anda',
                        style: new TextStyle(
                          fontFamily: "helvetica",
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    new Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(top: 5),
                      child: new Text(
                        'Rp200,000',
                        style: new TextStyle(
                          fontFamily: "helvetica",
                          fontWeight: FontWeight.w600,
                          fontSize: 25,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    new Container(
                      width: 120,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 50, bottom: 20),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.all(Radius.circular(5.0))
                      ),
                      child: new Text(
                        'Tarik Dana',
                        style: new TextStyle(
                          fontFamily: "helvetica",
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    new Divider(thickness: 1,),
                  ],
                )
            ),
            new Container(
              padding: const EdgeInsets.only(
                  top: 300, left: 15, right: 15
              ),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage('images/logo.png'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
