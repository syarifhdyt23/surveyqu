import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:surveyqu/hexacolor.dart';
import 'package:surveyqu/home/home.dart';
import 'package:surveyqu/info.dart';
import 'package:surveyqu/loading.dart';
import 'package:surveyqu/network_utils/api.dart';

class SurveyDetail extends StatefulWidget {
  String id;
  SurveyDetail({this.id});
  @override
  _SurveyDetailState createState() => _SurveyDetailState(id: id);
}

class _SurveyDetailState extends State<SurveyDetail> {
  Size size;
  String _selection = '';
  bool start, end;
  String id;
  Info info = new Info();
  int i;
  String type, soal;
  TextEditingController _textanswer = new TextEditingController();
  List<List<String>> choices = [// 1st qns has 3 choices
    ["AND", "CQA", "QWE", "QAL"], //3rd qns has 3 choices
  ];
  Map<String, bool> values = {
    'foo': true,
    'bar': false,
  };

  _SurveyDetailState({this.id});

  Future getQuestion() async {
    var data = {
      'id': id,
    };
    var res = await Network().postDataToken(data, '/detailQ');
    if (res.statusCode == 200) {
      final jsonData = json.decode(res.body);
      Question question = Question.fromJson(jsonData);
      setState(() {
        type = question.type;
        soal = question.pertanyaan;
        // sample.name => you can access field from class model
      });
    } else {
      info.messagesNoButton(context, 'info','Survey Error');
    }
  }

  @override
  void initState() {
    super.initState();
    getQuestion();
    start = true;
    end = false;
    i = 0;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return new Scaffold(
        body: new Container(
          width: size.width,
            decoration: BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage('images/bannerlandscape.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: new Stack(
              children: [
                new Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20),
                    ),
                  ),
                  margin: EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 90),
                  child: type == null ? new Loading() : type == '' ? new Container(child: new Text('no data'),) :
                  new Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: type == "check_opt" ? checkBoxWidget() :  type == "radio_opt" ? radioWidget() : answerWidget()
                    // i == 0 ? answerWidget() : i == 1 ? radioWidget() : i == 2 ? checkBoxWidget() : finish(),
                  ),
                ),
                new Positioned(
                  // alignment: Alignment.bottomCenter,
                  // color: new HexColor('#256fa0'),
                  height: 60,
                  width: size.width,
                  bottom: 20,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      start == true || end == true ? new Container() : new Container(
                        height: 40,
                        margin: const EdgeInsets.only(left: 20, right: 20.0, top: 5),
                        child: new FlatButton(
                          onPressed: () async {
                            setState(() {
                              if(i == 1){
                                start = true;
                                i--;
                              } else {
                                i--;
                              }
                            });
                            print(i);
                          },
                          splashColor: new HexColor("#F07B3F"),
                          highlightColor: new HexColor("#F07B3F"),
                          child: new Text('Prev', style: new TextStyle( color: Colors.white, fontSize: 19)),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                              side: new BorderSide(color: new HexColor("#F07B3F"))
                          ),
                          color: new HexColor("#F07B3F"),
                        ),
                      ),
                      new Container(
                        height: 40,
                        margin: const EdgeInsets.only(left: 20, right: 20.0, top: 5),
                        child: new FlatButton(
                          onPressed: () async {
                            setState(() {
                              if(end == false){
                                if(i < 2){
                                  start = false;
                                  i++;
                                } else {
                                  end = true;
                                  i++;
                                }
                              } else {
                                Navigator.of(context, rootNavigator: true).pop();
                              }

                            });
                            print(i);
                          },
                          splashColor: new HexColor("#F07B3F"),
                          highlightColor: new HexColor("#F07B3F"),
                          child: new Text(end == false ? 'Next' : 'Finish', style: new TextStyle( color: Colors.white, fontSize: 19)),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                              side: new BorderSide(color: new HexColor("#F07B3F"))
                          ),
                          color: new HexColor("#F07B3F"),
                        ),
                      ),
                    ],
                  ),
                ),
              ]
            )
        )
    );
  }

  Widget finish(){
    return new Container(
      alignment: Alignment.center,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Container(
            child: new CircleAvatar(
              radius: 58.0,
              backgroundColor: Colors.grey[500],
              child: new CircleAvatar(
                radius: 56.5,
                backgroundColor: Colors.white,
                child: new Icon(Icons.done_all, size: 70, color: Colors.grey[700],),
              ),
            ),
          ),

          new Container(
            margin: const EdgeInsets.only(top: 10),
            child: new Text('Survey done', style: new TextStyle(fontSize: 20),),
          ),

          new Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 3, left: 15, right: 15),
            child: new Text('Back to home', style: new TextStyle(fontSize: 15, color: Colors.grey[500]),),
          ),

          // new Container(
          //   alignment: Alignment.center,
          //   margin: const EdgeInsets.only(top: 3, left: 15, right: 15),
          //   child: new Text('Browse item product which want to you order', style: new TextStyle(fontSize: 15, color: Colors.grey[500]),),
          // ),
        ],
      ),
    );
  }

  Widget answerWidget(){
    return new ListView(
        children: <Widget>[
          new Text(
            soal,
            style: new TextStyle(
                fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          new Padding(
            padding: new EdgeInsets.all(8.0),
          ),
          new Text(
            'Jawab :',
            style: new TextStyle(
                fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          new Container(
            child: Stack(
              fit: StackFit.loose,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                     new Container(
                        child:  TextField(
                            maxLines: 15,
                            controller: _textanswer,
                            decoration: InputDecoration(
                              // suffixIcon:
                              border: InputBorder.none,
                              hintText: "enter your message",
                            ),
                        ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ]
    );
  }

  Widget checkBoxWidget(){
    return new ListView(
      children: <Widget>[
        new Text(
          soal,
          style: new TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        new Padding(
         padding: new EdgeInsets.all(8.0),
        ),
        new Column(
          children: values.keys.map((String key) {
            return new CheckboxListTile(
              title: Text(key),
              value: values[key],
              onChanged: (bool value) {
                setState(() {
                  values[key] = value;
                });
              },
            );
          }).toList(),
        )
      ]
    );
  }

  Widget radioWidget(){
    return new ListView(
        children: <Widget>[
          new Text(
            soal,
            style: new TextStyle(
                fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          new Padding(
            padding: new EdgeInsets.all(8.0),
          ),
          new Column(
            children: choices[0].map((item) { //change index of choices array as you need
              return RadioListTile(
                groupValue: _selection,
                title: Text(item),
                value: item,
                activeColor: Colors.blue,
                onChanged: (val) {
                  print(val);
                  setState(() {
                    _selection = val;
                  });
                },
              );
            }).toList(),
          ),
          new Padding(
            padding: new EdgeInsets.all(8.0),
          ),
        ]
    );
  }
}

class Question {
  int status;
  String id;
  String pertanyaan;
  String type;
  String opsi;
  String urutan;

  Question(
      {this.status,
        this.id,
        this.pertanyaan,
        this.type,
        this.opsi,
        this.urutan});

  Question.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    id = json['id'];
    pertanyaan = json['pertanyaan'];
    type = json['type'];
    opsi = json['opsi'];
    urutan = json['urutan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['id'] = this.id;
    data['pertanyaan'] = this.pertanyaan;
    data['type'] = this.type;
    data['opsi'] = this.opsi;
    data['urutan'] = this.urutan;
    return data;
  }
}