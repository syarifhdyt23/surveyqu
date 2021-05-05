import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:surveyqu/hexacolor.dart';
import 'package:surveyqu/info.dart';
import 'package:surveyqu/loading.dart';
import 'package:surveyqu/network_utils/api.dart';
import 'package:surveyqu/survey/surveydetail.dart';

class SurveyView extends StatefulWidget {
  String judul, deskripsi, id;
  SurveyView({this.deskripsi, this.judul, this.id});
  @override
  _SurveyViewState createState() => _SurveyViewState(deskripsi: deskripsi, judul: judul, id: id);
}

class _SurveyViewState extends State<SurveyView> {
  String judul, deskripsi, id;
  Size size;
  Info info = new Info();
  List<Result> listSurvey;

  _SurveyViewState({this.deskripsi, this.judul, this.id});

  Future<List<Result>> getSurvey() async {
    var data = {
      'id': id,
    };
    var res = await Network().postDataToken(data, '/detailS');
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      var dataJson = body['result'] as List;
      setState(() {
        listSurvey = dataJson.map<Result>((json) => Result.fromJson(json)).toList();
      });
    } else {
      info.messagesNoButton(context, 'info','Survey Error');
    }
    return listSurvey;
  }

  @override
  void initState() {
    super.initState();
    this.getSurvey();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: new Text("Survey Detail"),
      ),
      body: new ListView(
        children: [
          new Container(
            decoration: BoxDecoration(
              color: new HexColor('#256fa0'),
              borderRadius: BorderRadius.circular(10)
            ),
            margin: EdgeInsets.only(top: 10,left: 10,right: 10, bottom: 10),
            child: new Container(
              margin: EdgeInsets.only(top: 10,left: 10,right: 10, bottom: 10),
              child: new Column(
                children: [
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Text("Judul Survey", style: TextStyle(color: Colors.white),),
                      new Text("$judul", style: TextStyle(color: Colors.white),),
                    ],
                  ),
                  new Padding(padding: EdgeInsets.all(5)),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Text("Jumlah Survey", style: TextStyle(color: Colors.white),),
                      new Text(listSurvey == null ? 'loading' : listSurvey.length.toString(), style: TextStyle(color: Colors.white),),
                    ],
                  )
                ],
              ),
            )
          ),
          new Container(
              decoration: BoxDecoration(
                  color: new HexColor('#256fa0'),
                  borderRadius: BorderRadius.circular(10)
              ),
              margin: EdgeInsets.only(top: 10,left: 10,right: 10, bottom: 10),
              child: new Container(
                margin: EdgeInsets.only(top: 10,left: 10,right: 10, bottom: 10),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Text("Deskripsi Survey", style: TextStyle(color: Colors.white),),
                    new Padding(padding: EdgeInsets.all(5)),
                    new Text("$deskripsi", style: TextStyle(color: Colors.white,), textAlign: TextAlign.justify,),
                  ],
                ),
              )
          ),
          listSurvey == null ? new Container(
            margin: EdgeInsets.only(top: 30),
            child: new Loading(),
          ) : new Container(
            height: size.height - 310,
            child:  new ListView.builder(
              shrinkWrap: true,
                itemCount: listSurvey == null ? 0 : listSurvey.length,
                itemBuilder: (context, i){
                  return new InkWell(
                    onTap: (){
                      Navigator.of(context).push(new MaterialPageRoute(builder: (context) => SurveyDetail(id: listSurvey[i].id, urutanSoal: '1',)));
                    },
                    child: new Container(
                        decoration: BoxDecoration(
                            color: new HexColor('#256fa0'),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        margin: EdgeInsets.only(top: 10,left: 10,right: 10, bottom: 10),
                        child: new ListTile(
                          title: new Text(listSurvey[i].subJudul, style: TextStyle(color: Colors.white),),
                          subtitle: new Text(listSurvey[i].deskripsi, style: TextStyle(color: Colors.white),),
                          trailing: new Icon(Icons.arrow_forward_ios, color: Colors.white,),
                        )
                    ),
                  );
                }
                ),
          )
        ],
      ),
    );
  }
}

class Result {
  String id;
  String subJudul;
  String deskripsi;

  Result({this.id, this.subJudul, this.deskripsi});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subJudul = json['sub_judul'];
    deskripsi = json['deskripsi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sub_judul'] = this.subJudul;
    data['deskripsi'] = this.deskripsi;
    return data;
  }
}
