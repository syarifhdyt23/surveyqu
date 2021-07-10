import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:surveyqu/info.dart';
import 'package:surveyqu/model/profile.dart';
import 'package:surveyqu/network_utils/api.dart';
import 'package:surveyqu/profile/rekeningadd.dart';

import '../hexacolor.dart';

class RekeningPage extends StatefulWidget {
  String email;
  RekeningPage({this.email});
  @override
  _RekeningPageState createState() => _RekeningPageState(email: email);
}

class _RekeningPageState extends State<RekeningPage> {
  Info info = new Info();
  Size size;
  String email;
  List<Rekening> listRekening;

  _RekeningPageState({this.email});

  Future<void> getRek() async {
    var body = {
      "email": email,
    };
    var res = await Network().postDataToken(body,'/loadRek');
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      var dataJson = body['result'];
      setState(() {
        listRekening = dataJson.map<Rekening>((json) => Rekening.fromJson(json)).toList();
      });
    }
    return listRekening;
  }

  Future<void> deleteRek() async {
    var body = {
      "email": email,
    };
    var res = await Network().postDataToken(body, '/delRek');
    if (res.statusCode == 200) {
      // this.getNotif();
    }
  }

  @override
  void initState() {
    super.initState();
    this.getRek();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: new Text('Rekening Bank'),
      ),
      bottomNavigationBar: new Container(
        height: 45,
        margin: const EdgeInsets.only(top: 20, bottom: 30, left: 10, right: 10),
        child: new FlatButton(
            onPressed: () {
              Navigator.of(context).push(new MaterialPageRoute(builder: (context)=> new RekeningAdd()));
            },
            color: new HexColor("#EA5455"),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(7.0),
            ),
            child: new Text(
              'Tambah Rekening',
              style: new TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            )),
      ),
      body:
      // listPrivacy == null ? new Loading() :
      new ListView(
        shrinkWrap: true,
        children: [
          new Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(width: 2,color: Colors.black26),
            ),
            child: new Container(
              child: new ListTile(
                contentPadding: EdgeInsets.only(left: 15,right: 0,bottom: 0, top: 0),
                title: new Container(
                  child: new Text(listRekening[0].norek, style: TextStyle(fontWeight: FontWeight.w600),),
                ),
                subtitle: new Container(
                  child: new Text(listRekening[0].nama),
                ),
                trailing: new SizedBox(
                  width: 100,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Container(
                        width: 50,
                        height: 50,
                        child: new Image.network(listRekening[0].gambar),
                      ),
                      new PopupMenuButton<String>(
                        // padding: EdgeInsets.only(right: 10),
                        onSelected: handleClick,
                        itemBuilder: (BuildContext context) {
                          return <String>[
                            'Ubah',
                            'Hapus',
                            'Cancel',
                          ].map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                      })
                    ],
                  )
                ),
              )
            ),
          )
        ],
      ),
    );
  }
  void handleClick(String value) {
    switch (value) {
      case 'Hapus':
        this.deleteRek();
      break;
    }
  }
}
