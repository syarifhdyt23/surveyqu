import 'package:awesome_dialog/awesome_dialog.dart';
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
import 'package:surveyqu/model/profile.dart';
import 'package:surveyqu/network_utils/api.dart';
import 'package:surveyqu/profile/changepass.dart';
import 'package:surveyqu/profile/changeprofile.dart';
import 'package:surveyqu/profile/privacypolicy.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  Info info = new Info();
  Size size;
  Domain domain = new Domain();
  bool _visible = false;
  String id, email, nama;
  List<Privacy> listPrivacy;

  @override
  void initState() {
    _loadUserData();
    super.initState();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var id = jsonDecode(localStorage.getString('id'));

    if (id != null) {
      setState(() {
        id = id;
        email = jsonDecode(localStorage.getString('email'));
        nama = jsonDecode(localStorage.getString('nama'));
      });
    }
  }

  Future<void> getContent(String link) async {
    var res = await Network().postToken(link);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      var dataJson = body['result'];
      setState(() {
        listPrivacy = dataJson.map<Privacy>((json) => Privacy.fromJson(json)).toList();
      });
    }
    return listPrivacy;
  }

  Future<void> openURL(BuildContext context, String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      info.MessageInfo(context, 'Message', "Please install this apps");
    }
  }

  void messagesLogout(BuildContext context, String title, String desc) async {
    new AwesomeDialog(
        context: context,
        dialogType: DialogType.QUESTION,
        headerAnimationLoop: false,
        animType: AnimType.TOPSLIDE,
        title: title,
        desc: desc,
        useRootNavigator: true,
        btnCancelOnPress: () {},
        btnOkOnPress: () {
          logout();
        })
      ..show();
  }

  void logout() async {
    var res = await Network().postDataId('/logout');
    var body = json.decode(res.body);
    if (body['status'] == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.clear();
      Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
          new MaterialPageRoute(builder: (context) => Login()),
              (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    size = MediaQuery.of(context).size;

    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(top: 280),
            child: new ListView(
                children: [
                  new Container(
                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 10),
                    child: new Text(
                      'Akun',
                      style: new TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,),
                    ),
                  ),
                  new Container(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        new Container(
                          color: Colors.white,
                          child: new InkWell(
                              onTap: () {
                                // this.messagesLogout(context, 'keluar', 'anda yakin ingin keluar?');
                                // Navigator.of(context, rootNavigator: true).push(new MaterialPageRoute(builder: (context,) => new ChangeProfile()));
                              },
                              child: new ListTile(
                                title: new Text(
                                  'Ubah Data Diri',
                                  style: new TextStyle(fontSize: 15,),
                                ),
                                leading: new Icon(CupertinoIcons.person,color: Colors.blue,),
                                trailing: new Icon(Icons.arrow_forward_ios,color: Colors.blue,),
                              )
                          ),
                        ),
                        new Divider(height: 0.1,),
                        new Container(
                          color: Colors.white,
                          child: new InkWell(
                              onTap: () {
                                // this.messagesLogout(context, 'keluar', 'anda yakin ingin keluar?');
                                Navigator.of(context, rootNavigator: true).push(new MaterialPageRoute(builder: (context,) => new ChangePass()));
                                // info.messagesSuccess(context, true, 'info','Ganti password sukses');
                              },
                              child: new ListTile(
                                title: new Text(
                                  'Ubah Kata Sandi',
                                  style: new TextStyle(fontSize: 15,),
                                ),
                                leading: new Icon(CupertinoIcons.lock,color: Colors.blue,),
                                trailing: new Icon(Icons.arrow_forward_ios,color: Colors.blue,),
                              )
                          ),
                        ),
                        new Divider(height: 0.1,),
                        new Container(
                          color: Colors.white,
                          child: new InkWell(
                              onTap: () {
                              },
                              child: new ListTile(
                                title: new Text(
                                  'Rekening Bank',
                                  style: new TextStyle(fontSize: 15,),
                                ),
                                leading: new Icon(CupertinoIcons.creditcard,color: Colors.blue,),
                                trailing: new Icon(Icons.arrow_forward_ios,color: Colors.blue,),
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 10),
                    child: new Text(
                      'Info Lainnya',
                      style: new TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,),
                    ),
                  ),
                  new Container(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        new Container(
                          color: Colors.white,
                          child: new InkWell(
                              onTap: () async {
                                await this.getContent('/qa');
                                this.openURL(context, listPrivacy[0].isi);
                              },
                              child: new ListTile(
                                title: new Text(
                                  'Pertanyaan Umum',
                                  style: new TextStyle(fontSize: 15,),
                                ),
                                leading: new Icon(CupertinoIcons.mail,color: Colors.blue,),
                                trailing: new Icon(Icons.arrow_forward_ios,color: Colors.blue,),
                              )
                          ),
                        ),
                        new Divider(height: 0.1,),
                        new Container(
                          color: Colors.white,
                          child: new InkWell(
                              onTap: () {
                                // this.messagesLogout(context, 'keluar', 'anda yakin ingin keluar?');
                                Navigator.of(context, rootNavigator: true).push(new MaterialPageRoute(builder: (context,) => new PrivacyPolicy(link: '/kebijakan', title: 'Kebijakan Privasi',)));
                              },
                              child: new ListTile(
                                title: new Text(
                                  'Kebijakan Privasi',
                                  style: new TextStyle(fontSize: 15,),
                                ),
                                leading: new Icon(CupertinoIcons.lock_shield,color: Colors.blue,),
                                trailing: new Icon(Icons.arrow_forward_ios,color: Colors.blue,),
                              )
                          ),
                        ),
                        new Divider(height: 0.1,),
                        new Container(
                          color: Colors.white,
                          child: new InkWell(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true).push(new MaterialPageRoute(builder: (context,) => new PrivacyPolicy(link: '/sk', title: 'Syarat dan Ketentuan',)));
                              },
                              child: new ListTile(
                                title: new Text(
                                  'Syarat dan Ketentuan',
                                  style: new TextStyle(fontSize: 15,),
                                ),
                                leading: new Icon(CupertinoIcons.square_list,color: Colors.blue,),
                                trailing: new Icon(Icons.arrow_forward_ios,color: Colors.blue,),
                              )
                          ),
                        ),
                        new Divider(height: 0.1,),
                        new Container(
                          color: Colors.white,
                          child: new InkWell(
                              onTap: () async {
                                await this.getContent('/hc');
                                this.openURL(context, listPrivacy[0].isi);
                              },
                              child: new ListTile(
                                title: new Text(
                                  'Hubungi Help Center',
                                  style: new TextStyle(fontSize: 15,),
                                ),
                                leading: new Icon(CupertinoIcons.chat_bubble_2,color: Colors.blue,),
                                trailing: new Icon(Icons.arrow_forward_ios,color: Colors.blue,),
                              )
                          ),
                        ),
                        new Divider(height: 0.1,),
                        new Container(
                          color: Colors.white,
                          child: new InkWell(
                              onTap: () {
                                this.messagesLogout(context, 'keluar', 'anda yakin ingin keluar?');
                              },
                              child: new ListTile(
                                title: new Text(
                                  'Keluar',
                                  style: new TextStyle(fontSize: 15,),
                                ),
                                leading: new Icon(Icons.logout,color: Colors.blue,),
                                trailing: new Icon(Icons.arrow_forward_ios,color: Colors.blue,),
                              )
                          ),
                        ),
                      ],
                    ),
                  )
              ],
            ),
          ),
          new Container(
              height: 300,
              decoration: BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage('images/bannerlandscape.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new Container(
                    padding: EdgeInsets.only(top: 50),
                    child: new Center(
                      child: new CircleAvatar(
                        radius: 50.0,
                        backgroundColor: Colors.blue,
                        child: new InkWell(
                          onTap: () {
                            // _ShowChoiceDialog(context);
                            // chooseImage();
                          },
                          child: new CircleAvatar(
                            radius: 63.0,
                            backgroundColor: Colors.white,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(53.0),
                                child: new Icon(
                                  Icons.person,
                                  size: 60,
                                  color: Colors.lightBlue,
                                )),
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
                  new Container(
                    padding: EdgeInsets.only(top: 30),
                    alignment: Alignment.center,
                    child: new Text(
                      '$nama',
                      style: new TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  new Container(
                    alignment: Alignment.center,
                    child: new Text(
                      '$email',
                      style: new TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  new Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          new Icon(Icons.verified, color: Colors.yellow[700], size: 20,),
                          new Container(
                            padding: EdgeInsets.only(left: 5),
                            child: new Text('Akun terverifikasi',
                              style: TextStyle(

                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      )
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
