import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:surveyqu/hexacolor.dart';
import 'package:surveyqu/model/survey.dart';
import 'package:surveyqu/network_utils/api.dart';

class SurveyResult extends StatefulWidget {
  final String id, email, judul;

  const SurveyResult({Key key, this.id, this.email, this.judul}) : super(key: key);

  @override
  _SurveyResultState createState() => _SurveyResultState(id: id, email: email, judul: judul);
}

class _SurveyResultState extends State<SurveyResult> {
  String id, email, judul;

  _SurveyResultState({this.id, this.email, this.judul});

  List<SurveyRes> lisResult;

  Future<List<SurveyRes>> getResult() async {
    var body = {
      "id": id,
      "email": email
    };
    var res = await Network().postDataToken(body, '/resultPoll');
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      var dataJson = body['result'] as List;
      setState(() {
        lisResult = dataJson.map<SurveyRes>((json) => SurveyRes.fromJson(json)).toList();
      });
    }
    return lisResult;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getResult();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        height: MediaQuery.of(context).size.height * 0.50,
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(7),
            topRight: const Radius.circular(7),
          ),
        ),
        child: new Stack(
          children: <Widget>[
            new Container(
              child: new Column(
                children: [
                  new Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: new HexColor('#256fa0'),
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(7),
                        topRight: const Radius.circular(7),
                      ),
                    ),
                    child: new Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          new Align(
                            alignment: Alignment.topCenter,
                            child: new Text(judul, style: new TextStyle(color: Colors.white, fontSize: 20),),
                          ),
                          new Container(
                            width: 50,
                            child: new FlatButton(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onPressed: () {
                                // this.openURL(context, url);
                                Navigator.of(context).pop();
                              },
                              child: new Icon(Icons.close, color: Colors.white, size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // new Container(
                  //   margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                  //   height: 215,
                  //   width: 500,
                  //   decoration: BoxDecoration(
                  //     //boxShadow: kElevationToShadow[2],
                  //     borderRadius: new BorderRadius.circular(7.0),
                  //     image: new DecorationImage(
                  //       image: new NetworkImage(image),
                  //       fit: BoxFit.cover,
                  //     ),
                  //   ),
                  // ),

                  Expanded(
                    child: Column(
                      children: [
                        new Container(
                          // height: 200,
                          padding: EdgeInsets.only(right: 10, left: 10),
                          margin: EdgeInsets.only(top: 10),
                          alignment: Alignment.centerLeft,
                          child: new Text(
                            'Jawaban A',
                            textAlign: TextAlign.justify,
                            style: new TextStyle(
                              fontFamily: 'helvetica',
                              fontSize: 17,
                            ),
                          ),
                        ),
                        new LinearPercentIndicator(
                          padding: EdgeInsets.only(right: 10, left: 10, top: 10),
                          // radius: 50.0,
                          animation: true,
                          animationDuration: 1000,
                          // lineWidth: 8.0,
                          percent: 1.0,
                          // startAngle: double.parse(quota),
                          // circularStrokeCap: CircularStrokeCap.round,
                          backgroundColor: Colors.yellow,
                          progressColor: Colors.red,
                        ),
                        new Container(
                          // height: 200,
                          padding: EdgeInsets.only(right: 10, left: 10),
                          margin: EdgeInsets.only(top: 10),
                          alignment: Alignment.centerLeft,
                          child: new Text(
                            'Jawaban B',
                            textAlign: TextAlign.justify,
                            style: new TextStyle(
                              fontFamily: 'helvetica',
                              fontSize: 17,
                            ),
                          ),
                        ),
                        new LinearPercentIndicator(
                          padding: EdgeInsets.only(right: 10, left: 10, top: 10),
                          // radius: 50.0,
                          animation: true,
                          animationDuration: 1000,
                          // lineWidth: 8.0,
                          percent: 0.6,
                          // startAngle: double.parse(quota),
                          // circularStrokeCap: CircularStrokeCap.round,
                          backgroundColor: Colors.yellow,
                          progressColor: Colors.red,
                        ),
                        new Container(
                          // height: 200,
                          padding: EdgeInsets.only(right: 10, left: 10),
                          margin: EdgeInsets.only(top: 10),
                          alignment: Alignment.centerLeft,
                          child: new Text(
                            'Jawaban C',
                            textAlign: TextAlign.justify,
                            style: new TextStyle(
                              fontFamily: 'helvetica',
                              fontSize: 17,
                            ),
                          ),
                        ),
                        new LinearPercentIndicator(
                          padding: EdgeInsets.only(right: 10, left: 10, top: 10),
                          // radius: 50.0,
                          animation: true,
                          animationDuration: 1000,
                          // lineWidth: 8.0,
                          percent: 0.8,
                          // startAngle: double.parse(quota),
                          // circularStrokeCap: CircularStrokeCap.round,
                          backgroundColor: Colors.yellow,
                          progressColor: Colors.red,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
}
