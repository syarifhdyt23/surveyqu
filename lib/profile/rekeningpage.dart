import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:surveyqu/info.dart';
import 'package:surveyqu/loading.dart';
import 'package:surveyqu/model/profile.dart';
import 'package:surveyqu/network_utils/api.dart';
import 'package:surveyqu/profile/rekeningadd.dart';
import 'package:surveyqu/profile/rekeningedit.dart';

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
  String email, countRek;
  List<Rekening> listRekening;

  _RekeningPageState({this.email});

  Future<void> getRek() async {
    var body = {
      "email": email,
    };
    var res = await Network().postDataToken(body,'/loadRek');
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      if(body['result'] == 'null'){
        setState(() {
          countRek = '0';
        });
      } else {
        setState(() {
          countRek = '1';
        });
        var dataJson = body['result'] as List;
        setState(() {
          listRekening = dataJson.map<Rekening>((json) => Rekening.fromJson(json)).toList();
        });
      }
    } else {
      setState(() {
        countRek = '0';
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
      this.getRek();
    } else {
      info.messagesError(context, "Error", "Gagal menghapus item");
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
      bottomNavigationBar: countRek == '0' ? new Container(
        height: 45,
        margin: const EdgeInsets.only(top: 20, bottom: 30, left: 10, right: 10),
        child: new FlatButton(
            onPressed: () {
              Navigator.of(context).push(new MaterialPageRoute(builder: (context)=> new RekeningAdd(email: email,)));
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
      ) : null,
      body:
      countRek == null ? new Loading() :
      countRek == '0' ? new Container(
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
                  child: new Icon(Icons.credit_card, size: 70, color: Colors.grey[700],),
                ),
              ),
            ),

            new Container(
              margin: const EdgeInsets.only(top: 10),
              child: new Text('Rekening belum ditambahkan', style: new TextStyle(fontSize: 20),),
            ),

            new Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 3, left: 15, right: 15),
              child: new Text('Silahkan tambah rekening anda', style: new TextStyle(fontSize: 15, color: Colors.grey[500]),),
            ),
          ],
        ),
      ) :
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
      case 'Ubah':
        Navigator.of(context).push(new MaterialPageRoute(builder: (context)=> new RekeningEdit(email: email, bank: listRekening[0].bank, nama: listRekening[0].nama, norek: listRekening[0].norek,)));
      break;
    }
  }
}
