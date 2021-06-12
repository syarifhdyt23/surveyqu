import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surveyqu/info.dart';
import 'package:surveyqu/loading.dart';
import 'package:surveyqu/model/profile.dart';
import 'package:surveyqu/network_utils/api.dart';
import 'package:surveyqu/profile/profile.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  // http://surveyqu.com/sqws/sqmid/index.php/auth/kebijakan
  // param : -
  // header : token
  String token, result;
  Info info = new Info();
  List<Privacy> listPrivacy;

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var id = jsonDecode(localStorage.getString('id'));

    if (id != null) {
      setState(() {
        id = id;
        token = jsonDecode(localStorage.getString('token'));
      });
    }
  }

  Future<void> getContent() async {
    var res = await Network().postToken('/kebijakan');
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      var dataJson = body['result'];
      setState(() {
        listPrivacy = dataJson.map<Privacy>((json) => Privacy.fromJson(json)).toList();
      });
    }
    return listPrivacy;
  }

  @override
  void initState() {
    super.initState();
    this._loadUserData();
    this.getContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('Kebijakan Privasi'),
      ),
      body: listPrivacy == null ? new Loading() : new ListView(
        children: [
          new Container(
            padding: EdgeInsets.all(10),
            child: new Text(listPrivacy[0].isi, textAlign: TextAlign.justify,),
          )
        ],
      ),
    );
  }
}
