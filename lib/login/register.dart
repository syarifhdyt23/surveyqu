import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surveyqu/domain.dart';
import 'package:surveyqu/hexacolor.dart';
import 'package:http/http.dart' as http;
import 'package:surveyqu/info.dart';
import 'package:surveyqu/login/verification.dart';
import 'package:surveyqu/network_utils/api.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Size size;
  Domain domain = new Domain();
  Info info = new Info();
  var dataJson;


  // http://surveyqu.com/sqws/sqmid/index.php/auth/register
  // {"name" : "test", "password" : "12345","hp" : "0812345789","email":"ahmadsyarifhidayat23@gmail.com","ref":"123456"}
  TextEditingController textName = new TextEditingController();
  TextEditingController textHp = new TextEditingController();
  TextEditingController textEmail = new TextEditingController();
  TextEditingController textPass = new TextEditingController();
  TextEditingController textRef = new TextEditingController();

  void register(String email, String password, String name, String referral, String hp) async {
    var data = {
      'name': name,
      'password': password,
      'hp': hp,
      'email': email,
      'ref': referral,
    };

    var res = await Network().postDataAuth(data, '/register');
    if (res.statusCode == 200) {
      // var body = jsonDecode(res.body);
      // print(json.encode(body['message']));
      Navigator.push(
        context, new MaterialPageRoute(builder: (context) => Verification(email: textEmail.text,)),
      );
    } else if (res.statusCode == 204){
      info.messagesNoButton(context, 'info','Email Sudah terdaftar');
    } else {
      info.messagesNoButton(context, 'info','Pendaftaran gagal');
    }
  }

  void _onLoading(email, password, name, referral, hp) {
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
      register(email, password, name, referral, hp);
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
              margin: const EdgeInsets.only(left: 30.0, right: 30.0),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage('images/logo.png'),
                  fit: BoxFit.scaleDown,
                ),
              ),
              alignment: Alignment.center,
            ),
            new Container(
              height: 70,
              width: 50,
              padding: EdgeInsets.only(top: 50),
              child: new InkWell(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: new Icon(Icons.arrow_back),
              ),
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
              margin: const EdgeInsets.only(top: 250),
              child: new ListView(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  children: <Widget>[
                    new Container(
                      width: size.width,
                      height: 45,
                      margin: const EdgeInsets.only(top: 20),
                      child: new TextField(
                        controller: textName,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.withOpacity(.2), width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.withOpacity(.2), width: 1.0),
                          ),
                          contentPadding: const EdgeInsets.only(
                              left: 10.0, bottom: 0.0, top: 7.0),
                          //border: InputBorder.none,
                          hintText: "Nama",
                          hintStyle: TextStyle(
                              color: Colors.grey, fontFamily: 'helvetica'),
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          fillColor: Colors.grey[200],
                          filled: true,
                          prefixIcon: Padding(padding: const EdgeInsets.fromLTRB(0.0, 0.0, 1.0, 1.0),
                            child: Icon(Icons.person,),
                          ),
                        ),
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                    new Container(
                      width: size.width,
                      height: 45,
                      margin: const EdgeInsets.only(top: 10),
                      child: new TextField(
                        controller: textHp,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.withOpacity(.2), width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.withOpacity(.2), width: 1.0),
                          ),
                          contentPadding: const EdgeInsets.only(
                              left: 10.0, bottom: 0.0, top: 7.0),
                          //border: InputBorder.none,
                          hintText: "Nomor Handphone (08xx)",
                          hintStyle: TextStyle(
                              color: Colors.grey, fontFamily: 'helvetica'),
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          fillColor: Colors.grey[200],
                          filled: true,
                          prefixIcon: Padding(padding: const EdgeInsets.fromLTRB(0.0, 0.0, 1.0, 1.0),
                            child: Icon(Icons.phone,),
                          ),
                        ),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    new Container(
                      width: size.width,
                      height: 45,
                      margin: const EdgeInsets.only(top: 10),
                      child: new TextField(
                        controller: textEmail,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.withOpacity(.2), width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.withOpacity(.2), width: 1.0),
                          ),
                          contentPadding: const EdgeInsets.only(
                              left: 10.0, bottom: 0.0, top: 7.0),
                          //border: InputBorder.none,
                          hintText: "Email",
                          hintStyle: TextStyle(
                              color: Colors.grey, fontFamily: 'helvetica'),
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          fillColor: Colors.grey[200],
                          filled: true,
                          prefixIcon: Padding(padding: const EdgeInsets.fromLTRB(0.0, 0.0, 1.0, 1.0),
                            child: Icon(Icons.email,),
                          ),
                        ),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    new Container(
                      width: size.width,
                      height: 45,
                      margin: const EdgeInsets.only(top: 10),
                      child: new TextField(
                        controller: textPass,
                        obscureText: true,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.withOpacity(.2), width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.withOpacity(.2), width: 1.0),
                          ),
                          contentPadding: const EdgeInsets.only(
                              left: 10.0, bottom: 0.0, top: 7.0),
                          //border: InputBorder.none,
                          hintText: "Password",
                          hintStyle: TextStyle(
                              color: Colors.grey, fontFamily: 'helvetica'),
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          fillColor: Colors.grey[200],
                          filled: true,
                          prefixIcon: Padding(padding: const EdgeInsets.fromLTRB(0.0, 0.0, 1.0, 1.0),
                            child: Icon(Icons.lock,),
                          ),
                        ),
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                    new Container(
                      width: size.width,
                      height: 45,
                      margin: const EdgeInsets.only(top: 10),
                      child: new TextField(
                        controller: textRef,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.withOpacity(.2), width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.withOpacity(.2), width: 1.0),
                          ),
                          contentPadding: const EdgeInsets.only(
                              left: 10.0, bottom: 0.0, top: 7.0),
                          //border: InputBorder.none,
                          hintText: "Kode Referral",
                          hintStyle: TextStyle(
                              color: Colors.grey, fontFamily: 'helvetica'),
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          fillColor: Colors.grey[200],
                          filled: true,
                          prefixIcon: Padding(padding: const EdgeInsets.fromLTRB(0.0, 0.0, 1.0, 1.0),
                            child: Icon(CupertinoIcons.ticket_fill),
                          ),
                        ),
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                    new Container(
                      height: 45,
                      margin: const EdgeInsets.only(top: 20, bottom: 30),
                      child: new FlatButton(
                          onPressed: () {
                            if (textName.text == '') {
                              info.messagesNoButton(context, "Info", "Input nama anda");
                            } else if (textHp.text == ''){
                              info.messagesNoButton(context, "Info", "Input nomor handphone anda");
                            } else if (textHp.text.contains('08') == false){
                              info.messagesNoButton(context, "Info", "Nomor handphone harus diawali dengan 08");
                            } else if (textEmail.text == ''){
                              info.messagesNoButton(context, "Info", "Input email anda");
                            } else if (textEmail.text.contains('@') == false || textEmail.text.contains('.') == false ){
                              info.messagesNoButton(context, "Info", "Email anda tidak valid");
                            } else if (textPass.text == ''){
                              info.messagesNoButton(context, "Info", "Input password anda");
                            } else if (textPass.text.length < 6){
                              info.messagesNoButton(context, "Info", "Password minimal 6 karakter");
                            } else {
                              setState(() {
                                // Navigator.push(context, new MaterialPageRoute(builder: (context) => Verification(email: textEmail.text,)));
                                this._onLoading(textEmail.text, textPass.text, textName.text, textRef.text, textHp.text);
                              });
                            }
                          },
                          color: new HexColor("#EA5455"),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(7.0),
                          ),
                          child: new Text(
                            'Daftar',
                            style: new TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          )),
                    ),
                  ],
                ),
              ),

            ],
        ),
        ),
      ),
    );
  }
}
