import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:surveyqu/hexacolor.dart';

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
          margin: EdgeInsets.only(left: 80,right: 80),
          height: 200,
          child: new Image.asset('images/logo.png',fit: BoxFit.scaleDown,),
        ),
        new Container(
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

class LoadingLogoNoConnection extends StatefulWidget {

  _LoadingLogoNoConnectionState createState() => new _LoadingLogoNoConnectionState();
}

class _LoadingLogoNoConnectionState extends State<LoadingLogoNoConnection> {

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
                  child: new Text('Tidak terhubung ke jaringan', style: new TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w400),),
                )
              ],
            )
        ),
      ],
    );
  }
}

class LoadingHome extends StatefulWidget {
  @override
  _LoadingHomeState createState() => _LoadingHomeState();
}

class _LoadingHomeState extends State<LoadingHome> {
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (context, i) {
        return new InkWell(
          onTap: () {},
          child: new Container(
            padding: const EdgeInsets.only(
                top: 20.0, left: 20, right: 20),
            child: new Shimmer.fromColors(
              baseColor: new HexColor("#f0f0f0"),
              highlightColor: new HexColor("#f8f8f8"),
              child: new Container(
                width: 300,
                height: 150,
                color: Colors.grey,
              ),
            ),
          ),
        );
      },
    );
  }
}

class LoadingCard extends StatefulWidget {

  _LoadingCard createState() => new _LoadingCard();
}

class _LoadingCard extends State<LoadingCard> {

  Size size;

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    size = MediaQuery.of(context).size;

    return new Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: new ListView.builder(
        physics: new NeverScrollableScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, i) {
          return new SizedBox(
            width: size.width,
            height: 70,
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[200],
              child: Card(
                margin: EdgeInsets.only(top: 10),
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                color: Colors.black,
              ),
            ),
          );
        },
      ),
    );
  }
}
