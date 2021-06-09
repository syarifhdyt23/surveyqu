import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surveyqu/network_utils/api.dart';
import 'dart:async';
import 'dart:convert';

import '../domain.dart';
import '../hexacolor.dart';
import '../info.dart';


class ChangePass extends StatefulWidget {

  @override
  _ChangePass createState() => _ChangePass();
}

class _ChangePass extends State<ChangePass> {
  Domain domain = new Domain();
  List passJson, pwdJson;
  String message, email, passwordA, passwordB, passwordC;
  int wishlist;
  Size size;
  Timer timer;
  Info info = new Info();
  bool visibleNewPassword, visibleRePassword, visibleCurPassword;

  TextEditingController textNewPassword = new TextEditingController();
  TextEditingController textRePassword = new TextEditingController();
  TextEditingController textCurPassword = new TextEditingController();

  // Initialise outside the build method
  FocusNode nodeOne = FocusNode();
  FocusNode nodeTwo = FocusNode();
  FocusNode nodeThree = FocusNode();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var id = jsonDecode(localStorage.getString('id'));

    if (id != null) {
      setState(() {
        id = id;
        email = jsonDecode(localStorage.getString('email'));
      });
    }
  }

  void _onLoading() {
    showDialog(
      context: context,
      // barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.all(5),
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new Container(
                padding: EdgeInsets.all(10),
                child: new CircularProgressIndicator(),
              ),
              new Container(
                padding: EdgeInsets.all(10),
                child: new Text("Loading"),
              ),
            ],
          ),
        );
      },
    );
    new Future.delayed(new Duration(seconds: 3), () {
      Navigator.pop(context); //pop dialog
      changePass();
    });
  }

  void changePass() async {
    var data = {
      'email': email,
      'oldpass': textCurPassword.text,
      'newpass' : textNewPassword.text
    };

    var res = await Network().postDataToken(data, '/changepass');
    if (res.statusCode == 200) {
      info.messagesSuccess(context, true, 'info','Ganti password sukses');
    } else {
      info.messagesNoButton(context, 'info','Password lama anda salah');
    }
  }

  @override
  void initState() {
    super.initState();
    this._loadUserData();
    visibleNewPassword = false;
    visibleRePassword = false;
    visibleCurPassword = false;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    // TODO: implement build
    return
      // message == "0" ?
      new Scaffold(
        key: _scaffoldKey,
          backgroundColor: Colors.white,
          appBar: new AppBar(
            brightness: Brightness.dark,
            elevation: 0,
            centerTitle: true,
            title: new Text("Change Password", style: TextStyle(color: Colors.white),),
            // actions: [
            //   new Container(
            //     margin: EdgeInsets.only(right: 15, top: 17),
            //     child: new InkWell(
            //         highlightColor: Colors.transparent,
            //         splashColor: Colors.transparent,
            //         onTap: (){
            //           String passwordA = textNewPassword.text;
            //           String passwordB = textRePassword.text;
            //           String passwordC = textCurPassword.text;
            //
            //           if (textCurPassword.text == '' && textNewPassword.text == '' && textRePassword.text == '') {
            //             info.MessageInfo(context, 'Message', 'Please input data to change password');
            //           } else if(textNewPassword.text == '') {
            //             info.MessageInfo(context, 'Message', 'Please input new password');
            //           } else if(textRePassword.text == '') {
            //             info.MessageInfo(context, 'Message', 'Please input retype password');
            //           } else if(textCurPassword.text == '') {
            //             info.MessageInfo(context, 'Message', 'Please input current password');
            //           } else if(textNewPassword.text != textRePassword.text) {
            //             info.MessageInfo(context, 'Message', 'Retype Password not match');
            //           } else if(passwordA.length < 6 || passwordB.length < 6 || passwordC.length < 6){
            //             info.MessageInfo(context, 'Message', 'Password min 6 character');
            //           } else {
            //             setState(() {
            //               this._onLoading();
            //               // this.getCurPassword(textCurPassword.text);
            //             });
            //           }
            //         },
            //         child: new Text('Save',
            //           style: new TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 20),)
            //     ),
            //   ),
            // ],
          ),
          bottomNavigationBar: new Container(
            height: 45,
            margin: const EdgeInsets.only(top: 20, bottom: 30, left: 20, right: 20),
            child: new FlatButton(
                onPressed: () {
                  String passwordA = textNewPassword.text;
                  String passwordB = textRePassword.text;
                  String passwordC = textCurPassword.text;

                  if (textCurPassword.text == '' && textNewPassword.text == '' && textRePassword.text == '') {
                    info.MessageInfo(context, 'Message', 'Please input data to change password');
                  } else if(textNewPassword.text == '') {
                    info.MessageInfo(context, 'Message', 'Please input new password');
                  } else if(textRePassword.text == '') {
                    info.MessageInfo(context, 'Message', 'Please input retype password');
                  } else if(textCurPassword.text == '') {
                    info.MessageInfo(context, 'Message', 'Please input current password');
                  } else if(textNewPassword.text != textRePassword.text) {
                    info.MessageInfo(context, 'Message', 'Retype Password not match');
                  } else if(passwordA.length < 6 || passwordB.length < 6 || passwordC.length < 6){
                    info.MessageInfo(context, 'Message', 'Password min 6 character');
                  } else {
                    setState(() {
                      this._onLoading();
                      // this.getCurPassword(textCurPassword.text);
                    });
                  }
                },
                color: new HexColor("#EA5455"),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(7.0),
                ),
                child: new Text(
                  'Kirim',
                  style: new TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                )),
          ),
          body: new GestureDetector(
            onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            },
            child: new Container(
              height: size.height,
              width: size.width,
              child: new ListView(
                padding: EdgeInsets.only(left: 20, right: 20),
                children: [
                  new Container(
                    padding: EdgeInsets.only(top: 20),
                    child: new Text('Current Password', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                  ),

                  new Container(
                    width: size.width,
                    height: 40,
                    margin: const EdgeInsets.only(top: 5),
                    child: new CupertinoTextField(
                        controller: textCurPassword,
                        // placeholder: "test",
                        focusNode: nodeOne,
                        obscureText: !visibleCurPassword,
                        textInputAction: TextInputAction.next,
                        suffix: new Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                if(visibleCurPassword){
                                  visibleCurPassword = false;
                                }else{
                                  visibleCurPassword = true;
                                }

                              });
                            },
                            child: new Icon(visibleCurPassword ? Icons.visibility : Icons.visibility_off),
                          ),)),
                  ),

                  new Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: new Text('New Password', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
                  ),

                  new Container(
                    width: size.width,
                    height: 40,
                    margin: const EdgeInsets.only(top: 5),
                    child: new CupertinoTextField(
                      // placeholder: "test",
                        focusNode: nodeTwo,
                        obscureText: !visibleNewPassword,
                        controller: textNewPassword,
                        textInputAction: TextInputAction.next,
                        suffix: new Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                if(visibleNewPassword){
                                  visibleNewPassword = false;
                                }else{
                                  visibleNewPassword = true;
                                }

                              });
                            },
                            child: new Icon(visibleNewPassword ? Icons.visibility : Icons.visibility_off),
                          ),
                        )
                    ),
                  ),

                  new Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: new Text('Retype Password', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
                  ),

                  new Container(
                    width: size.width,
                    height: 40,
                    margin: const EdgeInsets.only(top: 5),
                    child: new CupertinoTextField(
                      // placeholder: "test",
                        focusNode: nodeThree,
                        controller: textRePassword,
                        obscureText: !visibleRePassword,
                        textInputAction: TextInputAction.done,
                        suffix: new Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                if(visibleRePassword){
                                  visibleRePassword = false;
                                }else{
                                  visibleRePassword = true;
                                }
                              });
                            },
                            child: new Icon(visibleRePassword ? Icons.visibility : Icons.visibility_off),
                          ),)),
                  ),
                ],
              ),
            ),
          ),
      );
  }
}
