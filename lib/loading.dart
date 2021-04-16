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
            child: new Text('Loading...', style: new TextStyle(color: Colors.grey[500], fontSize: 17, fontWeight: FontWeight.w400),),
          )
        ],
      ),
    );
  }
}

class LoadingVertical extends StatefulWidget {

  _LoadingVertical createState() => new _LoadingVertical();
}

class _LoadingVertical extends State<LoadingVertical> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
        new Container(
          height: 20,
          width: 20,
          child: new CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
        new Container(
          margin: EdgeInsets.only(left: 10),
          child: new Text('Loading...', style: new TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w400),),
        )
      ],
    );
  }
}