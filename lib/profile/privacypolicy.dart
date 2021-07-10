import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surveyqu/info.dart';
import 'package:surveyqu/loading.dart';
import 'package:surveyqu/model/profile.dart';
import 'package:surveyqu/network_utils/api.dart';
import 'package:surveyqu/profile/profile.dart';

class PrivacyPolicy extends StatefulWidget {
  String link, title;
  PrivacyPolicy({this.link, this.title});
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState(link: link, title: title);
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  Info info = new Info();
  String link, title;
  List<Privacy> listPrivacy;
  _PrivacyPolicyState({this.link, this.title});

  Future<void> getContent() async {
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

  @override
  void initState() {
    super.initState();
    this.getContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(title),
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
