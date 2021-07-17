import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:surveyqu/hexacolor.dart';
import 'package:surveyqu/info.dart';
import 'package:surveyqu/model/profile.dart';
import 'package:surveyqu/model/survey.dart';
import 'package:surveyqu/network_utils/api.dart';

class RekeningEdit extends StatefulWidget {
  String email, nama, norek, bank;
  RekeningEdit({this.email, this.norek, this.nama, this.bank});
  @override
  _RekeningEditState createState() => _RekeningEditState(email: email, nama: nama, norek: norek, selectedBank: bank);
}

class _RekeningEditState extends State<RekeningEdit> {
  Size size;
  TextEditingController textNorek = new TextEditingController();
  TextEditingController textUsername = new TextEditingController();
  List<ListBank> listBank;
  List bank = List();
  String email, nama, norek, selectedBank;
  Info info = new Info();

  _RekeningEditState({this.email, this.nama, this.norek, this.selectedBank});

  Future<void> getBank() async {
    var res = await Network().postToken('/loadBank');
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      var dataJson = body['result'];
      setState(() {
        listBank = dataJson.map<ListBank>((json) => ListBank.fromJson(json)).toList();
      });
      for (var i = 0; i < listBank.length; i++) {
        bank.add(listBank[i].bank);
      }
    }
    return listBank;
  }

  void AddRek(String email, String norek, String nama, String bank) async {
    var data = {
      'email': email,
      'newrek': norek,
      'nama' : nama,
      'bank' : bank
    };

    var res = await Network().postDataToken(data, '/changeRek');
    if (res.statusCode == 200) {
      // var body = jsonDecode(res.body);
      // print(json.encode(body['message']));
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      info.messagesAutoHide(context, 'info','Rekening berhasil diubah');
    } else {
      info.messagesNoButton(context, 'info','Rekening gagal diubah');
    }
  }

  void _onLoading(email, norek, nama, bank) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.all(5),
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new Container(
                padding: EdgeInsets.all(10),
                child: new CircularProgressIndicator(),
              ),
              new Container(
                padding: EdgeInsets.all(10),
                child: new Text("Loading"),
              ),
            ],
          ),
        );
      },
    );
    new Future.delayed(new Duration(seconds: 3), () {
      Navigator.pop(context); //pop dialog
      AddRek(email, norek, nama, bank);
    });
  }

  @override
  void initState() {
    super.initState();
    this.getBank();
    setState(() {
      textUsername.text = nama;
      textNorek.text = norek;
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: new Text('Tambah Rekening'),
      ),
      bottomNavigationBar: new Container(
        height: 45,
        margin: const EdgeInsets.only(top: 20, bottom: 30, left: 15, right: 15),
        child: new FlatButton(
            onPressed: () {
              if (selectedBank == null){
                info.messagesNoButton(context, "Info", "Nama bank belum dipilih");
              } else if (textNorek.text == '') {
                info.messagesNoButton(context, "Info", "Nomor rekening masih kosong");
              } else if (textUsername.text == ''){
                info.messagesNoButton(context, "Info", "Nama pemilik masih kosong");
              } else {
                setState(() {
                  // Navigator.push(context, new MaterialPageRoute(builder: (context) => Verification(email: textEmail.text,)));
                  this._onLoading(email, textNorek.text, textUsername.text, selectedBank);
                });
              }
            },
            color: new HexColor("#EA5455"),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(7.0),
            ),
            child: new Text(
              'Simpan',
              style: new TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            )),
      ),
      body: new GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanDown: (_) {
          FocusScope.of(context).unfocus();
        },
        child: new ListView(
          padding: const EdgeInsets.only(left: 15, right: 15),
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(top: 20),
              child: new Text('Nama Bank'),
            ),
            new Container(
                width: size.width,
                height: 45,
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.grey.withOpacity(.2), width: 2,),
                ),
                child: new DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: selectedBank,
                    //elevation: 5,
                    style: TextStyle(color: Colors.black),
                    items: bank.map((item) {
                      return new DropdownMenuItem(
                        child: new Text(item),
                        value: item.toString(),
                      );
                    }).toList(),
                    hint: Text(
                      "Pilih Bank",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        selectedBank = value;
                      });
                    },
                  ),
                )
            ),
            new Container(
              margin: const EdgeInsets.only(top: 20),
              child: new Text('No Rekening'),
            ),
            new Container(
              width: size.width,
              height: 45,
              margin: const EdgeInsets.only(top: 10),
              child: new TextField(
                controller: textNorek,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.grey.withOpacity(.2), width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.grey.withOpacity(.2), width: 1.0),
                  ),
                  contentPadding: const EdgeInsets.only(
                      left: 10.0, bottom: 0.0, top: 7.0),
                  //border: InputBorder.none,
                  // hintText: "Nomor Handphone (08xx)",
                  // hintStyle: TextStyle(
                  //     color: Colors.grey, fontFamily: 'helvetica'),
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                  // prefixIcon: Padding(padding: const EdgeInsets.fromLTRB(0.0, 0.0, 1.0, 1.0),
                  //   child: Icon(Icons.phone,),
                  // ),
                ),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
              ),
            ),
            new Container(
              margin: const EdgeInsets.only(top: 20),
              child: new Text('Nama Pemilik Rekening'),
            ),
            new Container(
              width: size.width,
              height: 45,
              margin: const EdgeInsets.only(top: 10),
              child: new TextField(
                controller: textUsername,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.grey.withOpacity(.2), width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.grey.withOpacity(.2), width: 1.0),
                  ),
                  contentPadding: const EdgeInsets.only(
                      left: 10.0, bottom: 0.0, top: 7.0),
                  //border: InputBorder.none,
                  // hintText: "Email",
                  // hintStyle: TextStyle(
                  //     color: Colors.grey, fontFamily: 'helvetica'),
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                  // prefixIcon: Padding(padding: const EdgeInsets.fromLTRB(0.0, 0.0, 1.0, 1.0),
                  //   child: Icon(Icons.email,),
                  // ),
                ),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
