import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surveyqu/info.dart';
import 'package:surveyqu/loading.dart';
import 'package:surveyqu/model/profile.dart';
import 'package:surveyqu/network_utils/api.dart';
import 'package:surveyqu/profile/profile.dart';

class DescriptionPage extends StatelessWidget {
  final String judul, isi;

  const DescriptionPage({Key key, this.judul, this.isi}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: new ListView(
        children: [
          new Container(
            padding: EdgeInsets.all(10),
            child: new Text(judul, textAlign: TextAlign.justify, style: TextStyle(fontWeight: FontWeight.w600),),
          ),
          new Container(
            padding: EdgeInsets.all(10),
            child: new Text(isi, textAlign: TextAlign.justify,),
          )
        ],
      ),
    );
  }
}
