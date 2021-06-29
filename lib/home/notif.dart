import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surveyqu/hexacolor.dart';
import 'package:surveyqu/home/description_page.dart';
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
  String email, nama, content;
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
      if(body['content'] == null){
        content = '1';
      } else {
        var dataJson = body['content'] as List;
        setState(() {
          listNotifDetail = dataJson.map<NotifDetail>((json) => NotifDetail.fromJson(json)).toList();
        });
      }
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

  List<NotifHit> listNotifHit;
  List<HistoryHit> listHistoryHit;

  Future<void> getHistoryHit(String id) async {
    var body = {
      "email": email,
      "id" : id
    };
    var res = await Network().postDataToken(body, '/historyHit');
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      var dataJson = body['content'] as List;
      setState(() {
        listHistoryHit = dataJson.map<HistoryHit>((json) => HistoryHit.fromJson(json)).toList();
        // Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new DescriptionPage(judul: listHistoryHit[0].judul, isi: listHistoryHit[0].isi,)));
      });
      showDetail(context, listHistoryHit[0].judul, listHistoryHit[0].isi);
      getHistory();
    }
    // return listHistoryHit;
  }

  Future<void> getNotifHit(String id) async {
    var body = {
      "email": email,
      "id" : id
    };
    var res = await Network().postDataToken(body, '/notifHit');
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      var dataJson = body['content'] as List;
      setState(() {
        listNotifHit = dataJson.map<NotifHit>((json) => NotifHit.fromJson(json)).toList();
        // Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new DescriptionPage(judul: listNotifHit[0].judul, isi: listNotifHit[0].isi,)));
      });
      showDetail(context, listNotifHit[0].judul, listNotifHit[0].isi);
      getNotif();
    }
    // return listNotifHit;
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
                  child: Text("Aktivitas",style: TextStyle(color: Colors.black),),
                ),
              ],
            ),
            body: new TabBarView(
              // physics: NeverScrollableScrollPhysics(),
              children: [
                content == null ? new LoadingCard() :
                content == '1' ?
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
                        return new InkWell(
                          onTap: (){
                            getNotifHit(listNotifDetail[i].id);
                          },
                          child: NotifCard(stsNotif: listNotifDetail[i].stsNotif, judul: listNotifDetail[i].judul),
                        );
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
                        return new InkWell(
                          onTap: (){
                            getHistoryHit(listHistorySurvey[i].id);
                          },
                          child: NotifCard(stsNotif: listHistorySurvey[i].stsNotif, judul: listHistorySurvey[i].judul),
                        );
                      }),
                ),
                ],
              ),
          ),
        ),
      ),
    );
  }

  void showDetail(BuildContext context, String judul, String isi) {
    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return new StatefulBuilder(builder: (context, state) {
            return new Container(
                height: MediaQuery.of(context).size.height * 0.80,
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(5.0),
                    topRight: const Radius.circular(5.0),
                  ),
                ),
                child: new Container(
                  child: new ListView(
                    children: [
                      new Container(
                        padding: EdgeInsets.all(10),
                        child: new Text(judul, textAlign: TextAlign.justify, style: TextStyle(fontWeight: FontWeight.w600),),
                      ),
                      new Container(
                        padding: EdgeInsets.all(10),
                        child: new Text(isi, textAlign: TextAlign.justify,),
                      )
                    ],
                  ),
                )
            );
          }
          );
        }
    );
  }
}
