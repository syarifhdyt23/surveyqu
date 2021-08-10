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

class SliderDetail extends StatefulWidget {
  String id, urutanSoal, jenis, email;
  SliderDetail({this.id, this.urutanSoal, this.jenis, this.email});
  @override
  _SliderDetailState createState() => _SliderDetailState(id: id, urutanSoal: urutanSoal, jenis:jenis, email: email);
}

class _SliderDetailState extends State<SliderDetail> {
  Size size;
  String radioValue = '';
  String id, email;
  Info info = new Info();
  String urutanSoal, jenis;
  List<ResultQnews> listDetail;

  _SliderDetailState({this.id, this.urutanSoal, this.jenis, this.email});

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
        listDetail = dataJson.map<ResultQnews>((json) => ResultQnews.fromJson(json)).toList();
      });
    } else {
      info.messagesNoButton(context, 'info','Detail Error');
    }
    return listDetail;
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
        title: new Text(listDetail == null ? 'Loading' : listDetail[0].judul),
      ),
      body: listDetail == null ? new Loading() : new ListView(
        children: [
          new Container(
            padding: EdgeInsets.all(10),
            child: new Text(listDetail[0].deskripsi, textAlign: TextAlign.justify,),
          )
        ],
      ),
    );
  }
}