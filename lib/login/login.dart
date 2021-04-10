import 'dart:convert';
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
  final _formKey = GlobalKey<FormState>();
  var email;
  var password;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
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
      key: _scaffoldKey,
      body: new Container(
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
                          padding: EdgeInsets.only(top: 20),
                          child: new Text(
                            'MASUK',
                            style: new TextStyle(
                                fontFamily: 'helvetica',
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Container(
                            margin: EdgeInsets.only(left: 20, right: 20.0, top: 10),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.all(
                                Radius.circular(7),
                              ),
                            ),
                            child: new TextFormField(
                              style: TextStyle(color: Colors.black),
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.grey,
                                ),
                                hintText: "Email",
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.withOpacity(.2),
                                      width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.withOpacity(.2),
                                      width: 1.0),
                                ),
                                contentPadding: const EdgeInsets.only(
                                    left: 1.0, bottom: 0.0, top: 7.0),
                                //border: InputBorder.none,
                                hintStyle: TextStyle(
                                    color: Color(0xFF9b9b9b),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                              validator: (emailValue) {
                                if (emailValue.isEmpty) {
                                  return 'Please enter email';
                                }
                                email = emailValue;
                                return null;
                              },
                            ),
                          ),
                          new Container(
                            margin: EdgeInsets.only(left: 20, right: 20.0, top: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(7),
                                ),
                              ),
                              child: new TextFormField(
                                style: TextStyle(color: Color(0xFF000000)),
                                cursorColor: Color(0xFF9b9b9b),
                                keyboardType: TextInputType.text,
                                obscureText: !visiblePassword,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.vpn_key,
                                    color: Colors.grey,
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (visiblePassword) {
                                          visiblePassword = false;
                                        } else {
                                          visiblePassword = true;
                                        }
                                      });
                                    },
                                    child: Icon(visiblePassword
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                  ),
                                  hintText: "Password",
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(.2),
                                        width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(.2),
                                        width: 1.0),
                                  ),
                                  contentPadding: const EdgeInsets.only(
                                      left: 1.0, bottom: 0.0, top: 7.0),
                                  hintStyle: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                                validator: (passwordValue) {
                                  if (passwordValue.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  password = passwordValue;
                                  return null;
                                },
                              )
                          ),
                          new Container(
                            width: size.width,
                            height: 45,
                            margin: const EdgeInsets.only(left: 20, right: 20.0, top: 15),
                            child: FlatButton(
                              child: new Padding(
                                padding: EdgeInsets.only(
                                    top: 8, bottom: 8, left: 10, right: 10),
                                child: Text(
                                  _isLoading ? 'Loading...' : 'Masuk',
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    color: new HexColor('#3282B8'),
                                    fontSize: 15.0,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              color: new HexColor('#BBE1FA'),
                              disabledColor: Colors.grey,
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(7.0)),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _login();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
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
      ),
    );
  }

  void _login() async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'username': email,
      'password': password,
      'ref': '',
    };

    var res = await Network().authData(data, '/login');
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['token']));
      localStorage.setString('id', json.encode(body['id']));
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => MainHome()),
      );
    } else {
      info.MessageToast('Login Failed');
    }

    setState(() {
      _isLoading = false;
    });
  }
}
