import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:async';

import 'package:surveyqu/domain.dart';
import 'package:surveyqu/hexacolor.dart';
import 'package:surveyqu/home/mainhome.dart';
import 'package:url_launcher/url_launcher.dart';

class Info {
  Size size;
  String version = '1.0.00';
  String sku, email, phoneWS, type;
  Domain domain = new Domain();
  FToast toast = new FToast();

  Future<void> openURL(BuildContext context, String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      MessageInfo(context, 'Message', "Please install this apps");
    }
  }

  void MessageInfo(BuildContext context, String title, String message) {
    Dialog fancyDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
        ),
        height: 200.0,
        width: 350.0,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            Container(
              width: double.infinity,
              color: new HexColor('#256fa0'),
              height: 50,
              alignment: Alignment.bottomCenter,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: new Text(
                message,
                textAlign: TextAlign.center,
                style: new TextStyle(fontSize: 15),
              ),
            ),
            new Align(
              alignment: Alignment.bottomCenter,
              child: new Container(
                //padding: const EdgeInsets.only(top: 400.0, left: 10.0, right: 10.0,),
                child: new Container(
                    height: 45,
                    width: 350,
                    margin: const EdgeInsets.only(top: 2.0, left: 10.0, right: 10.0, bottom: 10),
                    decoration: BoxDecoration(
                      color: HexColor("#F07B3F"),
                      borderRadius: BorderRadius.all(new Radius.circular(7.0)),
                    ),
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Expanded(
                          flex: 1,
                          child: new Container(
                            height: 45,
                            child: new FlatButton(
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true).pop();
                              },
                              child: new Text('Ok', style: new TextStyle( fontWeight: FontWeight.w600, color: Colors.white),
                              ),
                              shape: RoundedRectangleBorder(
                                //borderRadius: BorderRadius.only(bottomLeft: new Radius.circular(15)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => fancyDialog);
  }

  void LoadingToast(BuildContext context, String message) {
    toast.init(context);

    Widget _toast = new Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(10),
        color: Colors.black.withOpacity(.5)
      ),
      child: new Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          new CupertinoActivityIndicator(),

          new Container(
            margin: const EdgeInsets.only(left: 10),
            child: new Text('Loading...', style: new TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),),
          )
        ],
      ),
    );

    toast.showToast(
      child: _toast,
      gravity: ToastGravity.CENTER,
      toastDuration: Duration(seconds: 1)
    );
  }

  void MessageToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        fontSize: 15,
        backgroundColor: Colors.black.withOpacity(.6),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
    );
  }

  void LoadingProgress(BuildContext context) {
    Dialog fancyDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        height: 200.0,
        width: 100.0,
        child: new Stack(
          children: [
            new Align(
              alignment: Alignment.center,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new Container(
                    height: 60,
                    width: 200,
                    decoration: new BoxDecoration(
                      image: new DecorationImage(image: new AssetImage('images/logo.png')),
                    ),
                  ),
                  new Container(
                    height: 20,
                    width: 20,
                    child: new CupertinoActivityIndicator(),
                  )
                ],
              )
            ),
          ],
        ),
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) => fancyDialog,
    );
  }

  void messagesNoButton(BuildContext context, String title, String desc) {
    AwesomeDialog(
      context: context,
      headerAnimationLoop: true,
      animType: AnimType.BOTTOMSLIDE,
      title: title,
      desc: desc,
    )..show();
  }

  void messagesAutoHide(BuildContext context, String title, String desc) {
    AwesomeDialog(
      context: context,
      headerAnimationLoop: true,
      // useRootNavigator: true,
      animType: AnimType.BOTTOMSLIDE,
      title: title,
      desc: desc,
      autoHide: Duration(seconds: 3),
    )..show();
  }

  void messagesSuccess(BuildContext context, bool root, String title, String desc) {
    AwesomeDialog(
        context: context,
        animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        useRootNavigator: root,
        dismissOnTouchOutside: false,
        dialogType: DialogType.SUCCES,
        title: title,
        desc: desc,
        btnOkOnPress: () {
          // debugPrint('OnClick');
          // Navigator.of(context, rootNavigator: true).pop();
          Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (context) => MainHome()), (route) => false);
        },
        btnOkIcon: Icons.check_circle,
        onDissmissCallback: () {
          debugPrint('Dialog Dissmiss from callback');
        })
      ..show();
  }

  void messagesWarning(BuildContext context, String title, String desc) {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.WARNING,
        headerAnimationLoop: false,
        animType: AnimType.TOPSLIDE,
        showCloseIcon: true,
        closeIcon: Icon(Icons.close_fullscreen_outlined),
        title: title,
        desc: desc,
        btnCancelOnPress: () {},
        btnOkOnPress: () {})
      ..show();
  }

  void messagesError(BuildContext context, String title, String desc) {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: false,
        title: title,
        desc: desc,
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red)
      ..show();
  }

  void ShowDescriptionItem(BuildContext context, String judul, String image,
      String desk, String url) {
    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        isDismissible: false,
        enableDrag: false,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return new Container(
              height: MediaQuery.of(context).size.height * 0.80,
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(7),
                  topRight: const Radius.circular(7),
                ),
              ),
              child: new Stack(
                children: <Widget>[
                  new Container(
                    child: new Column(
                      children: [
                        new Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: new HexColor('#256fa0'),
                            borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(7),
                              topRight: const Radius.circular(7),
                            ),
                          ),
                          child: new Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                new Align(
                                  alignment: Alignment.topCenter,
                                  child: new Text(judul, style: new TextStyle(color: Colors.white, fontSize: 20),),
                                ),
                                new Container(
                                  width: 50,
                                  child: new FlatButton(
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onPressed: () {
                                      // this.openURL(context, url);
                                      Navigator.of(context).pop();
                                    },
                                    child: new Icon(Icons.close, color: Colors.white, size: 30,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // new Container(
                        //   margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                        //   height: 215,
                        //   width: 500,
                        //   decoration: BoxDecoration(
                        //     //boxShadow: kElevationToShadow[2],
                        //     borderRadius: new BorderRadius.circular(7.0),
                        //     image: new DecorationImage(
                        //       image: new NetworkImage(image),
                        //       fit: BoxFit.cover,
                        //     ),
                        //   ),
                        // ),

                        Expanded(
                          child: ListView(
                            children: [
                              new Container(
                                // height: 200,
                                padding: EdgeInsets.only(right: 10, left: 10, top: 10),
                                margin: EdgeInsets.only(bottom: 10),
                                child: new Text(
                                  desk,
                                  textAlign: TextAlign.justify,
                                  style: new TextStyle(
                                    fontFamily: 'helvetica',
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
          );
        });
  }

  void ShowResult(BuildContext context, String judul, String image,
      String desk, String url) {
    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        isDismissible: false,
        enableDrag: false,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return new Container(
              height: MediaQuery.of(context).size.height * 0.50,
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(7),
                  topRight: const Radius.circular(7),
                ),
              ),
              child: new Stack(
                children: <Widget>[
                  new Container(
                    child: new Column(
                      children: [
                        new Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: new HexColor('#256fa0'),
                            borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(7),
                              topRight: const Radius.circular(7),
                            ),
                          ),
                          child: new Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                new Align(
                                  alignment: Alignment.topCenter,
                                  child: new Text(judul, style: new TextStyle(color: Colors.white, fontSize: 20),),
                                ),
                                new Container(
                                  width: 50,
                                  child: new FlatButton(
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onPressed: () {
                                      // this.openURL(context, url);
                                      Navigator.of(context).pop();
                                    },
                                    child: new Icon(Icons.close, color: Colors.white, size: 30,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // new Container(
                        //   margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                        //   height: 215,
                        //   width: 500,
                        //   decoration: BoxDecoration(
                        //     //boxShadow: kElevationToShadow[2],
                        //     borderRadius: new BorderRadius.circular(7.0),
                        //     image: new DecorationImage(
                        //       image: new NetworkImage(image),
                        //       fit: BoxFit.cover,
                        //     ),
                        //   ),
                        // ),

                        Expanded(
                          child: Column(
                            children: [
                              new Container(
                                // height: 200,
                                padding: EdgeInsets.only(right: 10, left: 10),
                                margin: EdgeInsets.only(top: 10),
                                alignment: Alignment.centerLeft,
                                child: new Text(
                                  'Jawaban A',
                                  textAlign: TextAlign.justify,
                                  style: new TextStyle(
                                    fontFamily: 'helvetica',
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              new LinearPercentIndicator(
                                padding: EdgeInsets.only(right: 10, left: 10, top: 10),
                                // radius: 50.0,
                                animation: true,
                                animationDuration: 1000,
                                // lineWidth: 8.0,
                                percent: 1.0,
                                // startAngle: double.parse(quota),
                                // circularStrokeCap: CircularStrokeCap.round,
                                backgroundColor: Colors.yellow,
                                progressColor: Colors.red,
                              ),
                              new Container(
                                // height: 200,
                                padding: EdgeInsets.only(right: 10, left: 10),
                                margin: EdgeInsets.only(top: 10),
                                alignment: Alignment.centerLeft,
                                child: new Text(
                                  'Jawaban B',
                                  textAlign: TextAlign.justify,
                                  style: new TextStyle(
                                    fontFamily: 'helvetica',
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              new LinearPercentIndicator(
                                padding: EdgeInsets.only(right: 10, left: 10, top: 10),
                                // radius: 50.0,
                                animation: true,
                                animationDuration: 1000,
                                // lineWidth: 8.0,
                                percent: 0.6,
                                // startAngle: double.parse(quota),
                                // circularStrokeCap: CircularStrokeCap.round,
                                backgroundColor: Colors.yellow,
                                progressColor: Colors.red,
                              ),
                              new Container(
                                // height: 200,
                                padding: EdgeInsets.only(right: 10, left: 10),
                                margin: EdgeInsets.only(top: 10),
                                alignment: Alignment.centerLeft,
                                child: new Text(
                                  'Jawaban C',
                                  textAlign: TextAlign.justify,
                                  style: new TextStyle(
                                    fontFamily: 'helvetica',
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              new LinearPercentIndicator(
                                padding: EdgeInsets.only(right: 10, left: 10, top: 10),
                                // radius: 50.0,
                                animation: true,
                                animationDuration: 1000,
                                // lineWidth: 8.0,
                                percent: 0.8,
                                // startAngle: double.parse(quota),
                                // circularStrokeCap: CircularStrokeCap.round,
                                backgroundColor: Colors.yellow,
                                progressColor: Colors.red,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
          );
        });
  }

}
