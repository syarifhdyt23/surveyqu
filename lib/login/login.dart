import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surveyqu/domain.dart';
import 'package:surveyqu/hexacolor.dart';
import 'package:surveyqu/home/home.dart';
import 'package:surveyqu/home/mainhome.dart';
import 'package:surveyqu/info.dart';
import 'package:surveyqu/login/forgotpass.dart';
import 'package:surveyqu/login/register.dart';
import 'package:surveyqu/network_utils/api.dart';

import '../hexacolor.dart';
import '../hexacolor.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Size size;
  bool visiblePassword;
  Domain domain = Domain();
  Info info = Info();
  bool _isLoading = false;

  TextEditingController textEmaill = new TextEditingController();
  TextEditingController textPassword = new TextEditingController();

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
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
      _login();
    });
  }

  void _login() async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'username': textEmaill.text,
      'password': textPassword.text,
    };

    var res = await Network().postDataAuth(data, '/login');
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['token']));
      localStorage.setString('id', json.encode(body['id']));
      localStorage.setString('sqpoint', json.encode(body['sqpoint']));
      localStorage.setString('nama', json.encode(body['nama']));
      localStorage.setString('email', json.encode(body['email']));
      Navigator.push(context, new MaterialPageRoute(builder: (context) => MainHome()),
      );
    } else {
      info.messagesNoButton(context, 'info','Gagal Masuk');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    visiblePassword = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return new Scaffold(
      body: new GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanDown: (_) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: new Container(
          color: Colors.white,
          child: new Stack(
            children: <Widget>[
              new Container(
                height: 250,
                margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30),
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage('images/logo.png'),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                alignment: Alignment.center,
              ),
              new Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  image: new DecorationImage(
                    image: new AssetImage('images/banner.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                margin: const EdgeInsets.only(top: 300),
                child: new ListView(
                  children: <Widget>[
                    new Container(
                      child: new Column(
                        children: <Widget>[
                          new Container(
                            width: size.width,
                            height: 45,
                            margin: const EdgeInsets.only(left: 20, top: 25, right: 20),
                            child: new TextField (
                              controller: textEmaill,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey.withOpacity(.2), width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey.withOpacity(.2), width: 1.0),
                                ),
                                contentPadding: const EdgeInsets.only(left: 1.0, bottom: 0.0, top: 7.0),
                                //border: InputBorder.none,
                                hintText: "Email",
                                hintStyle: TextStyle(color: Colors.grey, fontFamily: 'helvetica'),
                                labelStyle: TextStyle(color: Colors.black, ),
                                prefixIcon: Padding(padding: const EdgeInsets.fromLTRB(0.0, 0.0, 1.0, 1.0),
                                  child: Icon(Icons.email,),
                                ),

                                fillColor: Colors.grey[200],
                                filled: true,
                              ),

                              textInputAction: TextInputAction.done,
                              //autofocus: true,

                            ),
                          ),

                          new Container(
                            width: size.width,
                            height: 45,
                            margin: const EdgeInsets.only(left: 20, top: 10, right: 20),
                            child: new TextField (
                              controller: textPassword,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey.withOpacity(.2), width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey.withOpacity(.2), width: 1.0),
                                ),
                                contentPadding: const EdgeInsets.only(left: 1.0, bottom: 0.0, top: 7.0),
                                //border: InputBorder.none,
                                hintText: "Password",
                                hintStyle: TextStyle(color: Colors.grey, fontFamily: 'helvetica'),
                                labelStyle: TextStyle(color: Colors.black, ),
                                prefixIcon: Padding(padding: const EdgeInsets.fromLTRB(0.0, 0.0, 1.0, 1.0),
                                  child: Icon(Icons.vpn_key,),
                                ),

                                fillColor: Colors.grey[200],
                                filled: true,
                                suffixIcon: GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      if(visiblePassword){
                                        visiblePassword = false;
                                      }else{
                                        visiblePassword = true;
                                      }

                                    });
                                  },
                                  child: Icon(visiblePassword ? Icons.visibility : Icons.visibility_off),
                                ),
                              ),

                              textInputAction: TextInputAction.done,
                              obscureText: !visiblePassword,

                            ),
                          ),
                        ],
                      ),
                    ),

                    new InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: (){
                        Navigator.push(context, new MaterialPageRoute(builder: (context) => ForgotPass()));
                      },
                      child: new Container(
                        alignment: Alignment.centerRight,
                        margin: const EdgeInsets.only(top: 5.0, right: 20),
                        child: new Text(
                          "Lupa Password",
                          style: new TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),

                    new Container(
                      width: size.width,
                      height: 45,
                      margin: const EdgeInsets.only(left: 20, right: 20.0, top: 15),
                      child: new FlatButton(
                        onPressed: () async {
                          setState(() async {
                            if(textEmaill.text == ''){
                              // info.MessageInfo(context, 'Message', 'Please input email address');
                              info.messagesNoButton(context, "Info", "Masukkan email anda");
                            }else if(!textEmaill.text.contains('@') || !textEmaill.text.contains('.')) {
                              info.messagesNoButton(context, 'Info', 'Your email is not valid');
                            }else if(textPassword.text == '') {
                              info.messagesNoButton(context, 'Info', 'Please input your password');
                            }else {
                              _onLoading();
                              //Navigator.push(context,
                              //    new MaterialPageRoute(builder: (context) => new ValidasiLogin(identifier: identifier, email: textEmaill.text, password: textPassword.text,)));
                              //this.getData(textEmaill.text, textPassword.text);
                            }
                          });
                        },
                        splashColor: new HexColor("#F07B3F"),
                        highlightColor: new HexColor("#F07B3F"),
                        child: new Text('Masuk', style: new TextStyle( color: Colors.white, fontSize: 19)),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            side: new BorderSide(color: new HexColor("#F07B3F"))
                        ),
                        color: new HexColor("#F07B3F"),
                      ),
                    ),

                    new Container(
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 0.5,
                            width: 50,
                            margin: const EdgeInsets.only(
                                top: 40.0, left: 10.0, right: 10.0),
                            color: Colors.white,
                          ),
                          new InkWell(
                            onTap: () {},
                            child: new Container(
                                margin: const EdgeInsets.only(top: 40.0),
                                child: new Row(
                                  children: <Widget>[
                                    new Text(
                                      "Belum punya akun? ",
                                      style: new TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ],
                                )),
                          ),
                          Container(
                            height: 0.5,
                            width: 50,
                            margin: const EdgeInsets.only(
                                top: 40.0, left: 10.0, right: 10.0),
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                    new Container(
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => Register()));
                            },
                            child: new Container(
                                margin: const EdgeInsets.only(top: 5.0),
                                child: new Row(
                                  children: <Widget>[
                                    new Text(
                                      "Daftar",
                                      style: new TextStyle(
                                          fontSize: 17,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
