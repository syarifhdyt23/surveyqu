import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  String judul, deskripsi, id, jenis, email;
  Size size;
  Info info = new Info();
  List<HeaderSurvey> listSurvey;

  _SurveyViewState({this.deskripsi, this.judul, this.id, this.jenis});

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var id = jsonDecode(localStorage.getString('id'));

    if (id != null) {
      setState(() {
        id = id;
        email = jsonDecode(localStorage.getString('email'));
      });
    }
  }

  Future<List<HeaderSurvey>> getSurvey() async {
    await _loadUserData();
    var data = {
      'id': id,
      'jenis': jenis,
      'email': email
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
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(1, 2), // changes position of shadow
                ),
              ],
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
      body: listSurvey == null
          ? new Container(
        margin: EdgeInsets.only(top: 30),
        child: new Loading(),
      )
          : new ListView.builder(
          shrinkWrap: true,
          itemCount: listSurvey == null ? 0 : listSurvey.length,
          itemBuilder: (context, i) {
            return new InkWell(
              onTap: () {
                if(listSurvey[i].status == '0'){
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => SurveyDetail(
                        id: listSurvey[i].id,
                        urutanSoal: '1',
                        jenis: jenis,
                        email: email,
                      ))
                  );
                }
              },
              child: new Container(
                  decoration: BoxDecoration(
                    color: listSurvey[i].status == '0' ? new HexColor('#256fa0') : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(1, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  margin: EdgeInsets.only(
                      top: 10, left: 10, right: 10, bottom: 10),
                  child: new ListTile(
                    title: new Text(
                      listSurvey[i].subJudul,
                      style: TextStyle(color: listSurvey[i].status == '0' ? Colors.white : new HexColor('#256fa0')),
                    ),
                    subtitle: new Text(
                      listSurvey[i].deskripsi,
                      style: TextStyle(color: listSurvey[i].status == '0' ? Colors.white : new HexColor('#256fa0')),
                    ),
                    trailing: new Container(
                      width: 100,
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          new Container(
                            padding: EdgeInsets.only(right: 10),
                            child: new Text(
                              listSurvey[i].rewards,
                              style: TextStyle(color: listSurvey[i].status == '0' ? Colors.white : new HexColor('#256fa0')),
                            ),
                          ),
                          new Icon(
                            listSurvey[i].status == '0' ? Icons.arrow_forward_ios : Icons.done_all,
                            color: listSurvey[i].status == '0' ? Colors.white : new HexColor('#256fa0'),
                          ),
                        ],
                      ),
                    ),
                  )),
            );
          }),
    );
  }
}
