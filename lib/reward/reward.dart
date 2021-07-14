import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:surveyqu/domain.dart';
import 'package:surveyqu/hexacolor.dart';
import 'package:surveyqu/model/reward.dart';
import 'package:surveyqu/widget/notif_card.dart';
import 'dart:async';
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:surveyqu/info.dart';
import 'package:surveyqu/loading.dart';
import 'package:surveyqu/model/notif.dart';
import 'package:surveyqu/network_utils/api.dart';
import 'package:surveyqu/widget/surveyamount_card.dart';

class Reward extends StatefulWidget {
  _Reward createState() => _Reward();
}

class _Reward extends State<Reward> {
  Size size;
  String email, nama, contHist, contNotif;
  List<HistoryReward> listNotifDetail;
  List<HistoryTarik> listHistorySurvey;
  // List<Total> saldoSurvey;
  String total;
  final currencyFormat = new NumberFormat.currency(locale: 'en', symbol: "Rp", decimalDigits: 0);

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    email = jsonDecode(localStorage.getString('email'));
    nama = jsonDecode(localStorage.getString('nama'));
  }

  Future<List<HistoryReward>> getNotif() async {
    await _getToken();
    var body = {
      "email": email
    };
    var res = await Network().postDataToken(body, '/riwayatSaldo');
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      if(body['content'] == "0"){
        setState(() {
          contNotif = '0';
        });
      } else {
        setState(() {
          contNotif = '1';
        });
        var dataJson = body['content'] as List;
        // var saldoJson = body['total'] as List;
        setState(() {
          total = body['total'][0] == null ? '0' : body['total'][0]['nominal'];
          // saldoSurvey = saldoJson.map<Total>((json) => Total.fromJson(json)).toList();
          listNotifDetail = dataJson.map<HistoryReward>((json) => HistoryReward.fromJson(json)).toList();
        });
      }
    }
    return listNotifDetail;
  }

  Future<List<HistoryTarik>> getHistory() async {
    await _getToken();
    var body = {
      "email": email
    };
    var res = await Network().postDataToken(body, '/riwayatPenarikan');
    if (res.statusCode == 200) {
      if(body['content'] == "0"){
        setState(() {
          contHist = '0';
        });
      } else {
        setState(() {
          contHist = '1';
        });
        var body = jsonDecode(res.body);
        var dataJson = body['content'] as List;
        setState(() {
          listHistorySurvey = dataJson.map<HistoryTarik>((json) => HistoryTarik.fromJson(json)).toList();
          listHistorySurvey.sort((a,b) => a.stsNotif.compareTo(b.stsNotif));
        });
      }
    }
    return listHistorySurvey;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotif();
    getHistory();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    size = MediaQuery.of(context).size;

    return new Scaffold(
      body: new Container(
        color: Colors.white,
        child: new Stack(
          children: <Widget>[
            new Container(
              height: 200,
                width: size.width,
                padding: const EdgeInsets.only(top: 80, left: 15, right: 15),
                decoration: BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage('images/bannerlandscape.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        new Container(
                          alignment: Alignment.centerLeft,
                          child: new Text(
                            'Saldo Anda',
                            style: new TextStyle(
                              fontFamily: "helvetica",
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        new Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(top: 5),
                          child: new Text(
                            total == '0' ? "Rp.$total" : currencyFormat.format(total),
                            style: new TextStyle(
                              fontFamily: "helvetica",
                              fontWeight: FontWeight.w600,
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    new Container(
                      // width: 120,
                      height: 50,
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 5,bottom: 5, left: 10,right: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5.0))
                      ),
                      child: new Text(
                        'Tarik Dana',
                        style: new TextStyle(
                          fontFamily: "helvetica",
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                )
            ),
            // new Container(
            //   margin: const EdgeInsets.only(
            //       top: 200, left: 15, right: 15
            //   ),
            //   decoration: new BoxDecoration(
            //     image: new DecorationImage(
            //       image: new AssetImage('images/logo.png'),
            //     ),
            //   ),
            // ),
            new Container(
              padding: EdgeInsets.only(top: 200),
              child: DefaultTabController(
                length: 2,
                child: Scaffold(
                  backgroundColor: Colors.white,
                  resizeToAvoidBottomInset: false,
                  appBar: TabBar(
                    // isScrollable: true,
                    unselectedLabelColor: Colors.black.withOpacity(0.5),
                    indicatorColor: new HexColor('#256fa0'),
                    tabs: [
                      new Container(
                        alignment: Alignment.center,
                        child: Text("Pemasukan", style: TextStyle(color: Colors.black),),
                      ),
                      new Container(
                        alignment: Alignment.center,
                        child: Text("Penarikan",style: TextStyle(color: Colors.black),),
                      ),
                    ],
                  ),
                  body: new TabBarView(
                    // physics: NeverScrollableScrollPhysics(),
                    children: [
                      contNotif == null ? new LoadingCard() :
                      contNotif == '0' ?
                      new Container(
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
                                  child: new Icon(Icons.notifications_none, size: 70, color: Colors.grey[700],),
                                ),
                              ),
                            ),

                            new Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: new Text('Notifikasi kosong', style: new TextStyle(fontSize: 20),),
                            ),

                            new Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 3, left: 15, right: 15),
                              child: new Text('Tidak ada Notifikasi', style: new TextStyle(fontSize: 15, color: Colors.grey[500]),),
                            ),
                          ],
                        ),
                      ) :
                      new Container(
                        margin: EdgeInsets.only(top: 10),
                        child: new ListView.separated(
                            separatorBuilder: (context, index) => Divider(
                              color: Colors.grey[400], thickness: 1,
                            ),
                            itemCount: listNotifDetail == null ? 0 : listNotifDetail.length,
                            itemBuilder: (context, i){
                              return new InkWell(
                                onTap: (){
                                  // getNotifHit(listNotifDetail[i].id);
                                  // showDetail(context, listNotifDetail[i].judul, listNotifDetail[i].isi);
                                },
                                child: SurveyAmount(stsNotif: listNotifDetail[i].stsNotif, judul: listNotifDetail[i].judul, flag: 'notif',),
                              );
                            }),
                      ),
                      contHist == null ? new LoadingCard() :
                      contHist == "0" ?
                      new Container(
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
                                  child: new Icon(Icons.notifications_none, size: 70, color: Colors.grey[700],),
                                ),
                              ),
                            ),

                            new Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: new Text('Histori kosong', style: new TextStyle(fontSize: 20),),
                            ),

                            new Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 3, left: 15, right: 15),
                              child: new Text('Tidak ada Histori', style: new TextStyle(fontSize: 15, color: Colors.grey[500]),),
                            ),
                          ],
                        ),
                      ) :
                      new Container(
                        margin: EdgeInsets.only(top: 10),
                        child: new ListView.separated(
                            separatorBuilder: (context, index) => Divider(
                              color: Colors.grey[400], thickness: 1,
                            ),
                            itemCount: listHistorySurvey == null ? 0 : listHistorySurvey.length,
                            itemBuilder: (context, i){
                              return new InkWell(
                                onTap: (){
                                  // getHistoryHit(listHistorySurvey[i].id);
                                  // showDetail(context, listHistorySurvey[i].judul, listHistorySurvey[i].isi);
                                },
                                child: SurveyAmount(stsNotif: listHistorySurvey[i].stsNotif, judul: listHistorySurvey[i].judul),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
