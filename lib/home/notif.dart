import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surveyqu/hexacolor.dart';
import 'package:surveyqu/home/notif_card.dart';
import 'package:surveyqu/loading.dart';
import 'package:surveyqu/model/notif.dart';
import 'package:surveyqu/network_utils/api.dart';

class NotifPage extends StatefulWidget {
  @override
  _NotifPageState createState() => _NotifPageState();
}

class _NotifPageState extends State<NotifPage> {
  Size size;
  String email, nama;
  List<NotifDetail> listNotifDetail;
  List<HistorySurvey> listHistorySurvey;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    email = jsonDecode(localStorage.getString('email'));
    nama = jsonDecode(localStorage.getString('nama'));
  }

  Future<List<NotifDetail>> getNotif() async {
    await _getToken();
    var body = {
      "email": email
    };
    var res = await Network().postDataToken(body, '/notifDetail');
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      var dataJson = body['content'] as List;
      setState(() {
        listNotifDetail = dataJson.map<NotifDetail>((json) => NotifDetail.fromJson(json)).toList();
      });
    }
    return listNotifDetail;
  }

  Future<List<HistorySurvey>> getHistory() async {
    await _getToken();
    var body = {
      "email": email
    };
    var res = await Network().postDataToken(body, '/historySurvey');
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      var dataJson = body['content'] as List;
      setState(() {
        listHistorySurvey = dataJson.map<HistorySurvey>((json) => HistorySurvey.fromJson(json)).toList();
      });
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
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: new Text("Notifikasi"),
      ),
      body: new Container(
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
                  child: Text("Notifikasi", style: TextStyle(color: Colors.black),),
                ),
                new Container(
                  alignment: Alignment.center,
                  child: Text("Histori",style: TextStyle(color: Colors.black),),
                ),
              ],
            ),
            body: new TabBarView(
              // physics: NeverScrollableScrollPhysics(),
              children: [
                listNotifDetail == null ? new LoadingCard() :
                listNotifDetail.length == 0 ?
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
                  child: new ListView.builder(
                      itemCount: listNotifDetail == null ? 0 : listNotifDetail.length,
                      itemBuilder: (context, i){
                        return NotifCard(stsNotif: listNotifDetail[i].stsNotif, isi: listNotifDetail[i].isi,);
                      }),
                ),
                listHistorySurvey == null ? new LoadingCard() :
                listHistorySurvey.length == 0 ?
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
                  child: new ListView.builder(
                      itemCount: listHistorySurvey == null ? 0 : listHistorySurvey.length,
                      itemBuilder: (context, i){
                        return NotifCard(stsNotif: listHistorySurvey[i].stsNotif, isi: listHistorySurvey[i].isi,);
                      }),
                ),
                ],
              ),
          ),
        ),
      ),
    );
  }
}
