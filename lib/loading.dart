import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loading extends StatefulWidget {

  _Loading createState() => new _Loading();
}

class _Loading extends State<Loading> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      alignment: Alignment.center,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new CupertinoActivityIndicator(),
          new Container(
            margin: const EdgeInsets.only(left: 10, top: 10),
            child: new Text('Memuat...', style: new TextStyle(color: Colors.grey[500], fontSize: 17, fontWeight: FontWeight.w400),),
          )
        ],
      ),
    );
  }
}

class LoadingLogo extends StatefulWidget {

  _LoadingLogoState createState() => new _LoadingLogoState();
}

class _LoadingLogoState extends State<LoadingLogo> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Container(
          height: 140,
          child: new Image.asset('images/logo.png',fit: BoxFit.scaleDown,),
        ),
        new Container(
          margin: EdgeInsets.only(top: 20),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new CupertinoActivityIndicator(),
              new Container(
                margin: EdgeInsets.only(left: 10),
                child: new Text('Memuat...', style: new TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w400),),
              )
            ],
          )
        ),
      ],
    );
  }
}