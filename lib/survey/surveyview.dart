import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:surveyqu/hexacolor.dart';
import 'package:surveyqu/info.dart';
import 'package:surveyqu/loading.dart';
import 'package:surveyqu/model/survey.dart';
import 'package:surveyqu/network_utils/api.dart';
import 'package:surveyqu/survey/surveydetail.dart';

class SurveyView extends StatefulWidget {
  String judul, deskripsi, id, jenis;

  SurveyView({this.deskripsi, this.judul, this.id, this.jenis});

  @override
  _SurveyViewState createState() => _SurveyViewState(
      deskripsi: deskripsi, judul: judul, id: id, jenis: jenis);
}

class _SurveyViewState extends State<SurveyView> {
  String judul, deskripsi, id, jenis;
  Size size;
  Info info = new Info();
  List<HeaderSurvey> listSurvey;

  _SurveyViewState({this.deskripsi, this.judul, this.id, this.jenis});

  Future<List<HeaderSurvey>> getSurvey() async {
    var data = {
      'id': id,
      'jenis': jenis,
    };
    var res = await Network().postDataToken(data, '/detailS');
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      var dataJson = body['result'] as List;
      setState(() {
        listSurvey = dataJson
            .map<HeaderSurvey>((json) => HeaderSurvey.fromJson(json))
            .toList();
      });
    } else {
      info.messagesNoButton(context, 'info', 'Survey Error');
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
      appBar: PreferredSize(
        preferredSize: MediaQuery.of(context).size,
        child: new Container(
            height: 250,
            decoration: BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage('images/bannerlandscape.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: new Stack(
              children: [
                new Container(
                  padding: EdgeInsets.only(top: 30),
                  child: new IconButton(
                      icon: new Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back, color: Colors.white,),
                      onPressed: (){
                        Navigator.of(context).pop();
                      }),
                ),
                new Container(
                  padding: EdgeInsets.only(top: 60, left: 10, right: 10, bottom: 10),
                  child: new Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new Text(
                        "$judul",
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      new Padding(padding: EdgeInsets.all(5)),
                      new Text(
                        listSurvey == null
                            ? 'loading'
                            : listSurvey.length.toString() +" Survey",
                        style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      new Padding(padding: EdgeInsets.all(10)),
                      new Text(
                        "$deskripsi",
                        style: TextStyle(
                            color: Colors.white, fontSize: 15
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                )
              ],
            )
        ),
      ),
      body: new ListView(
        children: [
          listSurvey == null
              ? new Container(
                  margin: EdgeInsets.only(top: 30),
                  child: new Loading(),
                )
              : new Container(
                  height: size.height - 310,
                  child: new ListView.builder(
                      shrinkWrap: true,
                      itemCount: listSurvey == null ? 0 : listSurvey.length,
                      itemBuilder: (context, i) {
                        return new InkWell(
                          onTap: () {
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (context) => SurveyDetail(
                                      id: listSurvey[i].id,
                                      urutanSoal: '1',
                                      jenis: jenis,
                                    )));
                          },
                          child: new Container(
                              decoration: BoxDecoration(
                                  color: new HexColor('#256fa0'),
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(
                                  top: 10, left: 10, right: 10, bottom: 10),
                              child: new ListTile(
                                title: new Text(
                                  listSurvey[i].subJudul,
                                  style: TextStyle(color: Colors.white),
                                ),
                                subtitle: new Text(
                                  listSurvey[i].deskripsi,
                                  style: TextStyle(color: Colors.white),
                                ),
                                trailing: new Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                ),
                              )),
                        );
                      }),
                )
        ],
      ),
    );
  }
}
