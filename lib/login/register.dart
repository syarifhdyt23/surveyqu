import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surveyqu/hexacolor.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Size size;

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
              padding: EdgeInsets.only(top: 20),
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
              child: new GestureDetector(
                behavior: HitTestBehavior.opaque,
                onPanDown: (_) {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: new ListView(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  children: <Widget>[
                    new Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 20),
                      child: new Text('Register', style: new TextStyle(fontFamily: 'helvetica', fontWeight: FontWeight.w600, fontSize: 20, color: Colors.white
                      ),),
                    ),
                    new Container(
                      width: size.width,
                      height: 45,
                      margin: const EdgeInsets.only(top: 10),
                      child: new TextField(
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
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    new Container(
                      width: size.width,
                      height: 45,
                      margin: const EdgeInsets.only(top: 10),
                      child: new TextField(
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
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    new Container(
                      width: size.width,
                      height: 45,
                      margin: const EdgeInsets.only(top: 10),
                      child: new TextField(
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
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    new Container(
                      width: size.width,
                      height: 45,
                      margin: const EdgeInsets.only(top: 10),
                      child: new TextField(
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
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    new Container(
                      height: 45,
                      margin: const EdgeInsets.only(top: 20, bottom: 30),
                      child: new FlatButton(
                          onPressed: () {},
                          color: new HexColor("#EA5455"),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(7.0),
                              side: new BorderSide(
                                  color: new HexColor("#F07B3F"))),
                          child: new Text(
                            'Register',
                            style: new TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
