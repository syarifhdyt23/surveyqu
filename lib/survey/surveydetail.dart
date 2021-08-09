import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:surveyqu/hexacolor.dart';
import 'package:surveyqu/home/home.dart';
import 'package:surveyqu/info.dart';
import 'package:surveyqu/loading.dart';
import 'package:surveyqu/model/survey.dart';
import 'package:surveyqu/network_utils/api.dart';

class SurveyDetail extends StatefulWidget {
  String id, urutanSoal, message, jenis, email;
  SurveyDetail({this.id, this.urutanSoal, this.message, this.jenis, this.email});
  @override
  _SurveyDetailState createState() => _SurveyDetailState(id: id, urutanSoal: urutanSoal, message: message, jenis:jenis, email: email);
}

class _SurveyDetailState extends State<SurveyDetail> {
  Size size;
  String radioValue = '';
  String id, email;
  Info info = new Info();
  String type, soal, idSoal, urutanSoal, nextId, nextUrutan, message, prevId, prevUrutan, jenis;
  List<ResultQnews> listSoal;

  _SurveyDetailState({this.id, this.urutanSoal, this.message, this.jenis, this.email});

  Future<List<ResultQnews>> getQuestion() async {
    var data = {
      'id': id,
      'urutan' : urutanSoal,
      'jenis' : jenis,
      'email' : email
    };
    var res = await Network().postDataToken(data, '/detailQ');
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      var dataJson = body['result'];
        setState(() {
          listSoal =
              dataJson.map<ResultQnews>((json) => ResultQnews.fromJson(json)).toList();
        });
    } else {
      info.messagesNoButton(context, 'info','Detail Error');
    }
    return listSoal;
  }

  @override
  void initState() {
    super.initState();
    this.getQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(listSoal[0].judul),
      ),
      body: listSoal == null ? new Loading() : new ListView(
        children: [
          new Container(
            padding: EdgeInsets.all(10),
            child: new Text(listSoal[0].deskripsi, textAlign: TextAlign.justify,),
          )
        ],
      ),
    );
  }
}