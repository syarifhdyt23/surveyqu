import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:surveyqu/domain.dart';
import 'package:surveyqu/hexacolor.dart';
import 'dart:async';
import 'dart:convert';

import 'package:surveyqu/info.dart';
import 'package:surveyqu/login/login.dart';
import 'package:surveyqu/network_utils/api.dart';

class Profile extends StatefulWidget {
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  Info info = new Info();
  Size size;
  Domain domain = new Domain();
  bool _visible = false;
  String name;

  @override
  void initState(){
    _loadUserData();
    super.initState();
  }
  _loadUserData() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('id'));

    if(user != null) {
      setState(() {
        name = user;
      });
    }
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
              margin: const EdgeInsets.only(top: 250),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
            new Container(
              child: new Positioned(
                top: 75,
                left: .0,
                right: .0,
                child: Center(
                  child: new CircleAvatar(
                    radius: 60.0,
                    backgroundColor: Colors.blue,
                    child: new InkWell(
                      onTap: (){
                        // _ShowChoiceDialog(context);
                        // chooseImage();
                      },
                      child: new CircleAvatar(
                        radius: 53.0,
                        backgroundColor: Colors.blue,
                        child:
                        ClipRRect(
                          borderRadius: BorderRadius.circular(53.0),
                          child: new Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.white,
                          )
                        ),
                        // ClipRRect(
                        //   borderRadius: BorderRadius.circular(53.0),
                        //   child:
                        //   showImage(),
                        // ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            new Container(
              width: size.width,
              margin: const EdgeInsets.only(top: 200),
              child: new Column(
                children: [
                  new Container(
                    alignment: Alignment.center,
                    child: new Text(
                      'Faisal',
                      style: new TextStyle(
                        fontFamily: "helvetica",
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  new Container(
                    alignment: Alignment.center,
                    child: new Text(
                      'icalec_03@yahoo.com',
                      style: new TextStyle(
                        fontFamily: "helvetica",
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  new Container(
                    width: 250,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.all(Radius.circular(5.0))
                    ),
                    child: new Text(
                      'Akun Sudah Terverifikasi',
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
                top: 330, left: 15, right: 15
              ),
              child: new InkWell(
                onTap: (){
                  logout();
                },
                child: new Container(
                  child: new Text(
                    'Logout',
                    style: new TextStyle(
                        fontFamily: "helvetica",
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.blue
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void logout() async{
    var res = await Network().getData('/logout');
    var body = json.decode(res.body);
    if(body['status'] == 200){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      Navigator.of(context, rootNavigator: true).push(new MaterialPageRoute(builder: (context)=>Login()));
    }
  }
}
