import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:surveyqu/hexacolor.dart';
import 'package:surveyqu/info.dart';
import 'package:surveyqu/model/survey.dart';
import 'package:surveyqu/network_utils/api.dart';
import 'package:surveyqu/survey/surveydetail.dart';
import 'package:surveyqu/survey/surveyview.dart';
import 'package:surveyqu/widget/survey_result.dart';

class SurveyCard extends StatefulWidget {
  String color,judul,deskripsi,gambar, id, jenis, quota, totalquota, email, urutan, rewards, status_result;

  SurveyCard({this.color, this.judul, this.deskripsi, this.gambar, this.id, this.jenis, this.quota, this.totalquota, this.email, this.urutan, this.rewards, this.status_result});

  @override
  _SurveyCardState createState() => _SurveyCardState(color: color, judul: judul, deskripsi: deskripsi, gambar: gambar, id: id, jenis: jenis, quota: quota, totalquota: totalquota, email: email, urutan: urutan, rewards: rewards, status_result: status_result);
}

class _SurveyCardState extends State<SurveyCard> {
  Info info = new Info();
  Size size;
  var percentage, _percentage;
  String color,judul,deskripsi,gambar, id, jenis, quota, totalquota, email, urutan, rewards, status_result;

  _SurveyCardState({this.color, this.judul, this.deskripsi, this.gambar, this.id, this.jenis, this.quota, this.totalquota, this.urutan, this.email, this.rewards, this.status_result});

  List<SurveyRes> listResult;

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
        listResult = dataJson.map<SurveyRes>((json) => SurveyRes.fromJson(json)).toList();
        ShowResult(context, listResult[0].question, listResult[0].opsi, listResult[0].total, listResult[0].j1, listResult[0].j2, listResult[0].j3, listResult[0].j4);
      });
    }
    return listResult;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(totalquota != '0'){
      percentage = int.parse(quota) / int.parse(totalquota) * 100;
      _percentage = percentage / 100;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 20),
        width: 350,
        height: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: color == '' ? Colors.grey : new HexColor(color),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(1, 2), // changes position of shadow
            ),
          ],
        ),
        child: new Column(
          children: [
            new Expanded(
                flex:3,
                child: new Container(
                  alignment: Alignment.center,
                  child: ListTile(
                    title: new Text(judul, style: TextStyle(color: Colors.white)),
                    subtitle: new Text(deskripsi, style: TextStyle(color: Colors.white)),
                    trailing: gambar == '' ? new Container(width: 100,) :
                    new Container(
                          width: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(gambar),
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                    ),
                  ),
                  // alignment: Alignment.center,
                  // child: new ListTile(
                  //   isThreeLine: true,
                  //   title: judul == '' ? null : new Container(
                  //     child: new Text(judul, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20,)),
                  //   ),
                  //   subtitle: deskripsi == '' ? null : new Container(
                  //     margin: EdgeInsets.only(top: 20),
                  //     child: new Text( deskripsi, style: TextStyle(color: Colors.white)),
                  //   ),
                  //   trailing: gambar == '' ? new Container() : new Container(
                  //     width: 100,
                  //     decoration: BoxDecoration(
                  //       image: DecorationImage(
                  //         image: NetworkImage(gambar),
                  //         fit: BoxFit.scaleDown,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                )
            ),
            new Expanded(
              flex:2,
              child: new Container(
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                ),
                child:
                new ListTile(
                    contentPadding: EdgeInsets.only(left: 15,right: 15),
                    title: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        totalquota == '0' ?
                        new Container(
                          alignment: Alignment.centerLeft,
                          child: new Text('Mulai isi survey'),
                        ) : new Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            new CircularPercentIndicator(
                              radius: 50.0,
                              animation: true,
                              animationDuration: 1000,
                              lineWidth: 8.0,
                              percent: _percentage,
                              // startAngle: double.parse(quota),
                              circularStrokeCap: CircularStrokeCap.round,
                              backgroundColor: Colors.yellow,
                              progressColor: Colors.red,
                            ),
                            new Container(
                                height: 50,
                                padding: EdgeInsets.only(left: 10, top: 5),
                                child: new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    new Text(
                                      "$quota / $totalquota",
                                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15),
                                    ),
                                    new Text(
                                      'Polling Terjawab',
                                      style: TextStyle(color: Colors.black, fontSize: 15),
                                    ),
                                  ],
                                )
                            )
                          ],
                        ),
                        new InkWell(
                          onTap: (){
                            if(quota == '0'){
                              info.MessageInfo(context, 'info','Survey sudah memenuhi kuota');
                            } else {
                              if(jenis == 'qpl' || jenis == 'qsc'){
                                if(status_result == '1'){
                                  this.getResult();
                                  // Navigator.of(context, rootNavigator: true).push(
                                  //     new MaterialPageRoute(builder: (context) =>
                                  //         SurveyResult(id: id,email: email,judul: judul,)));
                                } else {
                                  Navigator.of(context, rootNavigator: true).push(new MaterialPageRoute(
                                      builder: (context) =>
                                          SurveyDetail(
                                            id: id, jenis: jenis, urutanSoal: urutan, email: email,)));
                                }
                              } else {
                                Navigator.of(context, rootNavigator: true).push(new MaterialPageRoute(builder: (context) => SurveyView(judul: judul, deskripsi: deskripsi, id: id, jenis: jenis,)));
                              }
                            }
                          },
                          child: new Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: new HexColor("#F07B3F"),
                            ),
                            child: new Text('Mulai', style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      ],
                    ),
                    subtitle: rewards == '0' ? new Container() : new Column(
                      children: [
                        new Divider(),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            new Text('Reward per tugas'),
                            new Row(
                              children: [
                                new Icon(Icons.control_point_duplicate_sharp),
                                new Padding(padding: EdgeInsets.only(left: 10)),
                                new Text(rewards+ ' poin'),
                              ],
                            )
                          ],
                        ),
                      ],
                    )
                ),
              ),),
          ],
        )
    );
  }
}


void ShowResult(BuildContext context, String question, String opsi,
    String total, String j1, String j2, String j3, String j4) {

  var countJ1 = int.parse(j1) / int.parse(total) * 100;
  var countJ2 = int.parse(j2) / int.parse(total) * 100;
  var countJ3 = int.parse(j3) / int.parse(total) * 100;
  var countJ4 = int.parse(j4) / int.parse(total) * 100;
  var resJ1 = countJ1 / 100;
  var resJ2 = countJ2 / 100;
  var resJ3 = countJ3 / 100;
  var resJ4 = countJ4 / 100;
  showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return new Container(
            height: MediaQuery.of(context).size.height * 0.40,
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
                                child: new Text(question, style: new TextStyle(color: Colors.white, fontSize: 20),),
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
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  new Text(
                                    'Jawaban A',
                                    textAlign: TextAlign.justify,
                                    style: new TextStyle(
                                      fontFamily: 'helvetica',
                                      fontSize: 17,
                                    ),
                                  ),
                                  new Text(
                                    j1+"/"+total,
                                    textAlign: TextAlign.justify,
                                    style: new TextStyle(
                                      fontFamily: 'helvetica',
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              )
                            ),
                            new LinearPercentIndicator(
                              padding: EdgeInsets.only(right: 10, left: 10, top: 10),
                              // radius: 50.0,
                              animation: true,
                              animationDuration: 1000,
                              // lineWidth: 8.0,
                              percent: resJ1,
                              // startAngle: double.parse(quota),
                              // circularStrokeCap: CircularStrokeCap.round,
                              backgroundColor: Colors.yellow,
                              progressColor: Colors.red,
                            ),
                            new Container(
                              // height: 200,
                              padding: EdgeInsets.only(right: 10, left: 10),
                              margin: EdgeInsets.only(top: 20),
                              alignment: Alignment.centerLeft,
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  new Text(
                                    'Jawaban B',
                                    textAlign: TextAlign.justify,
                                    style: new TextStyle(
                                      fontFamily: 'helvetica',
                                      fontSize: 17,
                                    ),
                                  ),
                                  new Text(
                                    j2+"/"+total,
                                    textAlign: TextAlign.justify,
                                    style: new TextStyle(
                                      fontFamily: 'helvetica',
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              )
                            ),
                            new LinearPercentIndicator(
                              padding: EdgeInsets.only(right: 10, left: 10, top: 10),
                              // radius: 50.0,
                              animation: true,
                              animationDuration: 1000,
                              // lineWidth: 8.0,
                              percent: resJ2,
                              // startAngle: double.parse(quota),
                              // circularStrokeCap: CircularStrokeCap.round,
                              backgroundColor: Colors.yellow,
                              progressColor: Colors.red,
                            ),
                            new Container(
                              // height: 200,
                              padding: EdgeInsets.only(right: 10, left: 10),
                              margin: EdgeInsets.only(top: 20),
                              alignment: Alignment.centerLeft,
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  new Text(
                                    'Jawaban C',
                                    textAlign: TextAlign.justify,
                                    style: new TextStyle(
                                      fontFamily: 'helvetica',
                                      fontSize: 17,
                                    ),
                                  ),
                                  new Text(
                                    j3+"/"+total,
                                    textAlign: TextAlign.justify,
                                    style: new TextStyle(
                                      fontFamily: 'helvetica',
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              )
                            ),
                            new LinearPercentIndicator(
                              padding: EdgeInsets.only(right: 10, left: 10, top: 10),
                              // radius: 50.0,
                              animation: true,
                              animationDuration: 1000,
                              // lineWidth: 8.0,
                              percent: resJ3,
                              // startAngle: double.parse(quota),
                              // circularStrokeCap: CircularStrokeCap.round,
                              backgroundColor: Colors.yellow,
                              progressColor: Colors.red,
                            ),
                            new Container(
                              // height: 200,
                              padding: EdgeInsets.only(right: 10, left: 10),
                              margin: EdgeInsets.only(top: 20),
                              alignment: Alignment.centerLeft,
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  new Text(
                                    'Jawaban D',
                                    textAlign: TextAlign.justify,
                                    style: new TextStyle(
                                      fontFamily: 'helvetica',
                                      fontSize: 17,
                                    ),
                                  ),
                                  new Text(
                                    j4+"/"+total,
                                    textAlign: TextAlign.justify,
                                    style: new TextStyle(
                                      fontFamily: 'helvetica',
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              )
                            ),
                            new LinearPercentIndicator(
                              padding: EdgeInsets.only(right: 10, left: 10, top: 10),
                              // radius: 50.0,
                              animation: true,
                              animationDuration: 1000,
                              // lineWidth: 8.0,
                              percent: resJ4,
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
      });
}
//
// class SurveyCardReward extends StatefulWidget {
//   final String color,judul,deskripsi,gambar, id, jenis, quota, totalquota, email, urutan, rewards, status_result;
//
//   const SurveyCardReward({Key key, this.color, this.judul, this.deskripsi, this.gambar, this.id, this.jenis, this.quota, this.totalquota, this.email, this.urutan, this.rewards, this.status_result}) : super(key: key);
//
//   @override
//   _SurveyCardRewardState createState() => _SurveyCardRewardsState(color: color);
// }
//
// class _SurveyCardRewardState extends State<SurveyCardReward> {
//   Info info = new Info();
//   Size size;
//   String color,judul,deskripsi,gambar, id, jenis, quota, totalquota, email, urutan, rewards, status_result;
//
//   _SurveyCardRewardState({this.color, this.judul, this.deskripsi, this.gambar, this.id, this.jenis, this.quota, this.totalquota, this.urutan, this.email, this.rewards, this.status_result});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
//
//
// class SurveyCardReward extends StatelessWidget {
//   Info info = new Info();
//   Size size;
//   final String color,judul,deskripsi,gambar, id, jenis, quota, urutan, email, rewards, status_result;
//
//   SurveyCardReward({Key key, this.color, this.judul, this.deskripsi, this.gambar, this.id, this.jenis, this.quota, this.urutan, this.email, this.rewards, this.status_result}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         margin: EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 20),
//         // width: size.width,
//         height: 220,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(10)),
//           color: new HexColor(color),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.5),
//               spreadRadius: 2,
//               blurRadius: 4,
//               offset: Offset(1, 2), // changes position of shadow
//             ),
//           ],
//         ),
//         child: new Column(
//           children: [
//             new Expanded(
//                 flex:5,
//                 child: new Container(
//                   alignment: Alignment.center,
//                   child: new ListTile(
//                     isThreeLine: true,
//                     title: new Container(
//                       child: new Text(judul, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20,)),
//                     ),
//                     subtitle: new Container(
//                       margin: EdgeInsets.only(top: 20),
//                       child: new Text(deskripsi, style: TextStyle(color: Colors.white)),
//                     ),
//                     trailing: new Container(
//                       width: 100,
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                           image: NetworkImage(gambar),
//                           fit: BoxFit.scaleDown,
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//             ),
//             new Expanded(
//               flex:3,
//               child: new Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
//                 ),
//                 child: new ListTile(
//                   title: new Text('Reward per tugas'),
//                   subtitle: new Row(
//                     children: [
//                       new Icon(Icons.control_point_duplicate_sharp),
//                       new Padding(padding: EdgeInsets.only(left: 10)),
//                       new Text(rewards + ' poin'),
//                     ],
//                   ),
//                   trailing: new InkWell(
//                     onTap: (){
//                       if(quota == '0'){
//                         info.MessageInfo(context, 'info','Survey sudah memenuhi kuota');
//                       } else {
//                         if(jenis == 'qpl' || jenis == 'qsc'){
//                           if(status_result == '1'){
//                           // info.ShowResult(context, judul, "", 'test', '');
//                             Navigator.of(context, rootNavigator: true).push(
//                                 new MaterialPageRoute(builder: (context) =>
//                                     SurveyResult(id: id,email: email,judul: judul,)));
//                           } else {
//                             Navigator.of(context, rootNavigator: true).push(new MaterialPageRoute(
//                                 builder: (context) =>
//                                     SurveyDetail(
//                                       id: id, jenis: jenis, urutanSoal: urutan, email: email,)));
//                           }
//                         } else {
//                           Navigator.of(context, rootNavigator: true).push(new MaterialPageRoute(builder: (context) => SurveyView(judul: judul, deskripsi: deskripsi, id: id, jenis: jenis,)));
//                         }
//                       }
//                     },
//                     child: new Container(
//                       alignment: Alignment.center,
//                       height: 40,
//                       width: 80,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                         color: new HexColor("#F07B3F"),
//                       ),
//                       child: new Text('Mulai', style: TextStyle(color: Colors.white),),
//                     ),
//                   ),
//                 ),
//               ),),
//           ],
//         )
//     );
//   }
// }
//
// class SurveyCardBasic extends StatelessWidget {
//   Info info = new Info();
//   Size size;
//   final String color,judul,deskripsi,gambar, id, jenis, quota, urutan, email, rewards, status_result;
//
//   SurveyCardBasic({Key key, this.color, this.judul, this.deskripsi, this.gambar, this.id, this.jenis, this.quota, this.urutan, this.email, this.rewards, this.status_result}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         margin: EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 20),
//         // width: size.width,
//         height: 220,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(10)),
//           color: new HexColor(color),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.5),
//               spreadRadius: 2,
//               blurRadius: 4,
//               offset: Offset(1, 2), // changes position of shadow
//             ),
//           ],
//         ),
//         child: new Column(
//           children: [
//             new Expanded(
//                 flex:5,
//                 child: new Container(
//                   alignment: Alignment.center,
//                   child: new ListTile(
//                     isThreeLine: true,
//                     title: new Container(
//                       child: new Text(judul, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20,)),
//                     ),
//                     subtitle: new Container(
//                       margin: EdgeInsets.only(top: 20),
//                       child: new Text(deskripsi, style: TextStyle(color: Colors.white)),
//                     ),
//                     trailing: new Container(
//                       width: 100,
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                           image: NetworkImage(gambar),
//                           fit: BoxFit.scaleDown,
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//             ),
//             new Expanded(
//               flex:3,
//               child: new Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
//                 ),
//                 child: new ListTile(
//                   contentPadding: EdgeInsets.only(top: 15, left: 15,right: 15),
//                   title: new Text('Isi survey sekarang'),
//                   // subtitle: rewards == '0' ? new Container() :new Row(
//                   //   children: [
//                   //     new Icon(Icons.control_point_duplicate_sharp),
//                   //     new Padding(padding: EdgeInsets.only(left: 10)),
//                   //     new Text(rewards + ' poin'),
//                   //   ],
//                   // ),
//                   trailing: new InkWell(
//                     onTap: (){
//                       if(quota == '0'){
//                         info.MessageInfo(context, 'info','Survey sudah memenuhi kuota');
//                       } else {
//                         if(jenis == 'qpl' || jenis == 'qsc'){
//                           if(status_result == '1'){
//                           // info.ShowResult(context, judul, "", 'test', '');
//                             Navigator.of(context, rootNavigator: true).push(
//                                 new MaterialPageRoute(builder: (context) =>
//                                     SurveyResult(id: id,email: email,judul: judul,)));
//                           } else {
//                             Navigator.of(context, rootNavigator: true).push(new MaterialPageRoute(
//                                 builder: (context) =>
//                                     SurveyDetail(
//                                       id: id, jenis: jenis, urutanSoal: urutan, email: email,)));
//                           }
//                         } else {
//                           Navigator.of(context, rootNavigator: true).push(new MaterialPageRoute(builder: (context) => SurveyView(judul: judul, deskripsi: deskripsi, id: id, jenis: jenis,)));
//                         }
//                       }
//                     },
//                     child: new Container(
//                       alignment: Alignment.center,
//                       height: 40,
//                       width: 80,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                         color: new HexColor("#F07B3F"),
//                       ),
//                       child: new Text('Mulai', style: TextStyle(color: Colors.white),),
//                     ),
//                   ),
//                 ),
//               ),),
//           ],
//         )
//     );
//   }
// }
//
// class SurveyCardBoth extends StatelessWidget {
//   Info info = new Info();
//   Size size;
//   final String color,judul,deskripsi,gambar, id, jenis, quota, totalquota, email, urutan, rewards, status_result;
//
//   SurveyCardBoth({Key key, this.color, this.judul, this.deskripsi, this.gambar, this.id, this.jenis, this.quota, this.totalquota, this.urutan, this.email, this.rewards, this.status_result}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     var percentage = int.parse(quota) / int.parse(totalquota) * 100;
//     var _percentage = percentage / 100;
//     return Container(
//         margin: EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 20),
//         // width: size.width,
//         height: 220,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(10)),
//           color: new HexColor(color),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.5),
//               spreadRadius: 2,
//               blurRadius: 4,
//               offset: Offset(1, 2), // changes position of shadow
//             ),
//           ],
//         ),
//         child: new Column(
//           children: [
//             new Expanded(
//                 flex:3,
//                 child: new Container(
//                   alignment: Alignment.center,
//                   child: new ListTile(
//                     isThreeLine: true,
//                     title: new Container(
//                       child: new Text(judul, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20,)),
//                     ),
//                     subtitle: new Container(
//                       margin: EdgeInsets.only(top: 20),
//                       child: new Text(deskripsi, style: TextStyle(color: Colors.white)),
//                     ),
//                     trailing: new Container(
//                       width: 100,
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                           image: NetworkImage(gambar),
//                           fit: BoxFit.scaleDown,
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//             ),
//             new Expanded(
//               flex:2,
//               child: new Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
//                 ),
//                 child: new ListTile(
//                     contentPadding: EdgeInsets.only(top: 5, left: 15,right: 15),
//                     title: new Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         new Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             new CircularPercentIndicator(
//                               radius: 50.0,
//                               animation: true,
//                               animationDuration: 1000,
//                               lineWidth: 8.0,
//                               percent: _percentage,
//                               // startAngle: double.parse(quota),
//                               circularStrokeCap: CircularStrokeCap.round,
//                               backgroundColor: Colors.yellow,
//                               progressColor: Colors.red,
//                             ),
//                             new Container(
//                                 height: 50,
//                                 padding: EdgeInsets.only(left: 10, top: 5),
//                                 child: new Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     new Text(
//                                       "$quota / $totalquota",
//                                       style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15),
//                                     ),
//                                     new Text(
//                                       'Polling Terjawab',
//                                       style: TextStyle(color: Colors.black, fontSize: 15),
//                                     ),
//                                   ],
//                                 )
//                             )
//                           ],
//                         ),
//                         new InkWell(
//                           onTap: (){
//                             if(quota == '0'){
//                               info.MessageInfo(context, 'info','Survey sudah memenuhi kuota');
//                             } else {
//                               if(jenis == 'qpl' || jenis == 'qsc'){
//                                 if(status_result == '1'){
//                                 // info.ShowResult(context, judul, "", 'test', '');
//                                   Navigator.of(context, rootNavigator: true).push(
//                                       new MaterialPageRoute(builder: (context) =>
//                                           SurveyResult(id: id,email: email,judul: judul,)));
//                                 } else {
//                                   Navigator.of(context, rootNavigator: true).push(new MaterialPageRoute(
//                                       builder: (context) =>
//                                           SurveyDetail(
//                                             id: id, jenis: jenis, urutanSoal: urutan, email: email,)));
//                                 }
//                               } else {
//                                 Navigator.of(context, rootNavigator: true).push(new MaterialPageRoute(builder: (context) => SurveyView(judul: judul, deskripsi: deskripsi, id: id, jenis: jenis,)));
//                               }
//                             }
//                           },
//                           child: new Container(
//                             alignment: Alignment.center,
//                             height: 40,
//                             width: 80,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.all(Radius.circular(10)),
//                               color: new HexColor("#F07B3F"),
//                             ),
//                             child: new Text('Mulai', style: TextStyle(color: Colors.white),),
//                           ),
//                         ),
//                       ],
//                     ),
//                     subtitle: new Column(
//                       children: [
//                         new Divider(),
//                         new Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             new Text('Reward per tugas'),
//                             new Row(
//                               children: [
//                                 new Icon(Icons.control_point_duplicate_sharp),
//                                 new Padding(padding: EdgeInsets.only(left: 10)),
//                                 new Text(rewards+ ' poin'),
//                               ],
//                             )
//                           ],
//                         ),
//                       ],
//                     )
//                 ),
//               ),),
//           ],
//         )
//     );
//   }
// }


