import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:surveyqu/hexacolor.dart';
import 'package:surveyqu/home/home.dart';
import 'package:surveyqu/info.dart';
import 'package:surveyqu/loading.dart';
import 'package:surveyqu/model/survey.dart';
import 'package:surveyqu/network_utils/api.dart';

class SurveyDetail extends StatefulWidget {
  String id, urutanSoal, message, jenis, email;
  SurveyDetail({this.id, this.urutanSoal, this.message, this.jenis, this.email});
  @override
  _SurveyDetailState createState() => _SurveyDetailState(id: id, urutanSoal: urutanSoal, message: message, jenis:jenis, email: email);
}

class _SurveyDetailState extends State<SurveyDetail> {
  Size size;
  String radioValue = '';
  String id, email;
  Info info = new Info();
  // nextId, nextUrutan, message, prevId, prevUrutan,
  String type, soal, idSoal, urutanSoal, message, jenis;
  TextEditingController _textanswer = new TextEditingController();
  List<Result> listSoal;
  List<dynamic> opsi;
  // bool qDone = false;
  var opsiStatus = List<bool>();
  var opsiValue = List<String>();

  _SurveyDetailState({this.id, this.urutanSoal, this.message, this.jenis, this.email});

  Future<List<Result>> getQuestion(id, urutanSoal, jenis, email) async {
    var data = {
      'id': id,
      'urutan' : urutanSoal,
      'jenis' : jenis,
      'email' : email
    };
    var res = await Network().postDataToken(data, '/detailQ');
    if(this.mounted) {
      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        var dataJson = body['result'];
        if (dataJson[0]['id'] == '') {
          setState(() {
            message = 'done';
          });
        } else {
          setState(() {
            listSoal =
                dataJson.map<Result>((json) => Result.fromJson(json)).toList();
          });
          idSoal = listSoal[0].id;
          soal = listSoal[0].question;
          type = listSoal[0].type;
          urutanSoal = listSoal[0].urutan;
          opsi = listSoal[0].opsi;
          for (var i = 0; i < 5; i++) {
            opsiStatus.add(false);
          }
        }
      } else {
        info.messagesNoButton(context, 'info', 'Survey Error');
      }
      return listSoal;
    }
  }

  Future<void> nextQuestion(id, urutan, jawaban) async {
    var data = {
      'id': id,
      'urutan': urutan,
      'jawaban' : jawaban,
      'jenis' : jenis,
      'email' : email
    };
    var res = await Network().postDataToken(data, '/nextQ');
    if(this.mounted) {
      if (res.statusCode == 200) {
        final jsonData = json.decode(res.body);
        nextQ nextQuest = nextQ.fromJson(jsonData);
        setState(() {
          idSoal = nextQuest.id;
          urutanSoal = nextQuest.urutan;
          message = nextQuest.message;
          this.clearData();
          this.getQuestion(idSoal, urutanSoal, jenis, email);
          // Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context) => SurveyDetail(id: nextId, urutanSoal: nextUrutan, message: message, email: email, jenis: jenis,)));
        });
      } else {
        info.messagesNoButton(context, 'info', 'Survey Error');
      }
    }
  }

  Future<void> prevQuestion(id, urutan, jawaban) async {
    var data = {
      'id': id,
      'urutan': urutan,
      'jawaban' : jawaban,
      'jenis' : jenis,
      'email' : email
    };
    var res = await Network().postDataToken(data, '/prevQ');
    if(this.mounted) {
      if (res.statusCode == 200) {
        final jsonData = json.decode(res.body);
        prevQ prevQuest = prevQ.fromJson(jsonData);
        setState(() {
          // prevId = nextQuest.id;
          // prevUrutan = nextQuest.urutan;
          // message = nextQuest.message;
          // this.getQuestion(prevId, prevUrutan, jenis, email);

          idSoal = prevQuest.id;
          urutanSoal = prevQuest.urutan;
          message = prevQuest.message;
          this.clearData();
          this.getQuestion(idSoal, urutanSoal, jenis, email);

          // Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context) => SurveyDetail(id: prevId, urutanSoal: prevUrutan, message: message, email: email, jenis: jenis,)));
        });
      } else {
        info.messagesNoButton(context, 'info', 'Survey Error');
      }
    }
  }

  /// upload Image ///
  bool pict;
  String status = '';
  String base64Image, fileName, imgProfile, image;
  String errMessage = 'Error Uploading Image';
  File _image;
  var picker = ImagePicker();

  startUpload(BuildContext context) {
    fileName = _image == null ? image.split('/').last : _image.path.split('/').last;
  }

  upload(BuildContext context, id, urutan, jawaban) async{
    var data = {
      'id': id,
      'urutan': urutan,
      'jawaban' : jawaban,
      'jenis' : jenis,
      'email' : email
    };
    var res = await Network().postDataToken(data, '/nextQ');
    if(this.mounted) {
      if (res.statusCode == 200) {
        final jsonData = json.decode(res.body);
        nextQ nextQuest = nextQ.fromJson(jsonData);
        setState(() {
          // nextId = nextQuest.id;
          // nextUrutan = nextQuest.urutan;
          // message = nextQuest.message;
          // this.getQuestion(nextId, nextUrutan, jenis, email);
          idSoal = nextQuest.id;
          urutanSoal = nextQuest.urutan;
          message = nextQuest.message;
          this.clearData();
          this.getQuestion(idSoal, urutanSoal, jenis, email);

          // Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context) => SurveyDetail(id: prevId, urutanSoal: prevUrutan, message: message, email: email, jenis: jenis,)));
        });
      } else {
        info.messagesNoButton(context, 'info', 'Survey Error');
      }
    }
  }

  Future chooseImage2() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        base64Image = base64Encode(_image.readAsBytesSync());
        pict = true;
      } else {
        print('Gambar belum dipilih.');
      }
    });
  }

  Future snapImage() async{
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        base64Image = base64Encode(_image.readAsBytesSync());
        pict = true;
      } else {
        print('Gambar belum dipilih.');
      }
    });
  }

  Widget showImages2() {
    return _image == null
        ? imgProfile == null ? new Icon(Icons.image_outlined, size: 100, color: Colors.grey,) :
    new CachedNetworkImage(imageUrl: imgProfile ,fit: BoxFit.cover,)
        : Image.file(_image,
      fit: BoxFit.cover,);
  }
  /// upload image ///

  clearData(){
    setState(() {
      soal = null;
      type = null;
      radioValue = null;
      _image = null;
      base64Image = null;
      imgProfile = null;
      fileName = null;
      pict = false;
      picker = null;
      opsi.clear();
      opsiStatus.clear();
      opsiValue.clear();
      listSoal.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    this.getQuestion(id, urutanSoal, jenis, email);
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
                  child: message == 'done' ? finish() : type == null ? new Loading() : type == '' ? new Container(child: new Text('no data'),) :
                  new Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: type == "check_opt" ? checkBoxWidget() :  type == "radio_opt" ? radioWidget() : type == "textfield_s" ? answerWidget(): type == "upload_image" ? uploadWidget() : type == "check_opt_img" ? checkimgWidget() : radioimgWidget()
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
                      urutanSoal == "1" || message == 'done'? new Container() : new Container(
                        height: 40,
                        margin: const EdgeInsets.only(left: 20, right: 20.0, top: 5),
                        child: new FlatButton(
                          onPressed: () async {
                            this.prevQuestion(idSoal, urutanSoal, _textanswer.text);
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
                              if(message == 'done'){
                                Navigator.pop(context);
                              } else {
                                if (type == "check_opt"){
                                  if(opsiValue == null || opsiValue.length == 0){
                                    info.messagesNoButton(context, "info", "Pilih jawaban anda");
                                  } else {
                                    this.nextQuestion(idSoal, urutanSoal, opsiValue);
                                  }
                                } else if (type == "check_opt_img"){
                                  if(opsiValue == null || opsiValue.length == 0){
                                    info.messagesNoButton(context, "info", "Pilih jawaban anda");
                                  } else {
                                    this.nextQuestion(idSoal, urutanSoal, opsiValue);
                                  }
                                } else if (type == "radio_opt"){
                                  if(jenis == 'qt'){
                                    if(radioValue == '' || radioValue == null){
                                      info.messagesNoButton(context, "info", "Pilih salah satu jawaban anda");
                                    } else if(radioValue == 'Tidak'){
                                      info.messagesNoButton(context, "info", "Baca lagi dan pahami lebih baik pernyataan pertanyaan-nya yuks");
                                    } else {
                                      this.nextQuestion(idSoal, urutanSoal, radioValue);
                                    }
                                  } else {
                                    if(radioValue == '' || radioValue == null){
                                      info.messagesNoButton(context, "info", "Pilih salah satu jawaban anda");
                                    } else {
                                      this.nextQuestion(idSoal, urutanSoal, radioValue);
                                    }
                                  }
                                } else if (type == "textfield_s"){
                                  if(_textanswer.text == ''){
                                    info.messagesNoButton(context, "info", "Jawaban anda masih kosong");
                                  } else {
                                    this.nextQuestion(idSoal, urutanSoal, _textanswer.text);
                                  }
                                } else if (type == "upload_image"){
                                  if(base64Image == null){
                                    info.messagesNoButton(context, "info", "Jawaban anda masih kosong");
                                  } else {
                                    upload(context, idSoal, urutanSoal, base64Image);
                                  }
                                } else {
                                  if(radioValue == ''|| radioValue == null){
                                    info.messagesNoButton(context, "info", "Jawaban anda masih kosong");
                                  } else {
                                    this.nextQuestion(idSoal, urutanSoal, _textanswer.text);
                                  }
                                }
                              }
                            });
                          },
                          splashColor: new HexColor("#F07B3F"),
                          highlightColor: new HexColor("#F07B3F"),
                          child: new Text(message == 'done' ? 'Finish' : 'Next', style: new TextStyle( color: Colors.white, fontSize: 19)),
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
            child: new Text('Survey selesai', style: new TextStyle(fontSize: 20),),
          ),

          new Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 3, left: 15, right: 15),
            child: new Text('Kembali ke beranda', style: new TextStyle(fontSize: 15, color: Colors.grey[500]),),
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
          new Container(
            height: size.height,
            child: ListView.builder(
              itemCount: opsi.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(opsi[index]),
                  subtitle: Text(opsi[index]),
                  leading: Checkbox(
                      value: opsiStatus[index],
                      onChanged: (bool val) {
                        setState(() {
                          if(opsiStatus[index] == false){
                            opsiStatus[index] = !opsiStatus[index];
                            opsiValue.remove(opsi);
                            opsiValue.add(opsi[index]);
                          } else {
                            opsiStatus[index] = !opsiStatus[index];
                            opsiValue.remove(opsi[index]);
                          }
                          print(opsiValue);
                        });
                      }),
                );
              },
            ),
          ),
        ]
    );
  }

  Widget uploadWidget(){
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
            'Upload :',
            style: new TextStyle(
                fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          new Container(
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            height: 200,
            width: size.width,
            child: new InkWell(
              onTap: () {
                // _ShowChoiceDialog(context);
                selectUpload(context);
              },
              child: showImages2(),
            ),
          ),
        ]
    );
  }

  void selectUpload(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: new Text('Pilih media pengambilan gambar', style: TextStyle(fontSize: 17),),
            content: new Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: new FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                        chooseImage2();
                      },
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Icon(Icons.image, size: 20,),
                          new Padding(padding: EdgeInsets.only(left: 10)),
                          new Text('Dari Galeri', style: TextStyle(fontSize: 15),),
                        ],
                      ),
                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.only(top: 5),
                    child: new FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                        snapImage();
                      },
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Icon(Icons.camera, size: 20,),
                          new Padding(padding: EdgeInsets.only(left: 10)),
                          new Text('Dari Kamera', style: TextStyle(fontSize: 15),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget checkimgWidget(){
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
        new Container(
          height: size.height,
          child: ListView.builder(
            itemCount: opsi.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Container(
                  alignment: Alignment.centerLeft,
                  height: size.height/7,
                  child: Image.network(opsi[index]),
                ),
                leading: Checkbox(
                    value: opsiStatus[index],
                    onChanged: (bool val) {
                      setState(() {
                        if(opsiStatus[index] == false){
                          opsiStatus[index] = !opsiStatus[index];
                          opsiValue.remove(opsi);
                          opsiValue.add(opsi[index]);
                        } else {
                          opsiStatus[index] = !opsiStatus[index];
                          opsiValue.remove(opsi[index]);
                        }
                        print(opsiValue);
                      });
                    }),
              );
            },
          ),
        ),
        // new Column(
        //   children: listSoal[0].opsi.map((String key) {
        //     return new CheckboxListTile(
        //       title: Text(key),
        //       value: values[key],
        //       onChanged: (bool value) {
        //         setState(() {
        //           values[key] = true;
        //         });
        //       },
        //     );
        //   }).toList(),
        // )
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
            children: opsi.map((item) { //change index of choices array as you need
              return RadioListTile(
                groupValue: radioValue,
                title: Text(item),
                value: item,
                activeColor: Colors.blue,
                onChanged: (val) {
                  setState(() {
                    radioValue = val;
                    print(radioValue);
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

  Widget radioimgWidget(){
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
            children: opsi.map((item) { //change index of choices array as you need
              return RadioListTile(
                groupValue: radioValue,
                title: Container(
                  alignment: Alignment.centerLeft,
                  height: size.height/7,
                  child: Image.network(item),
                ),
                value: item,
                activeColor: Colors.blue,
                onChanged: (val) {
                  setState(() {
                    radioValue = val;
                    print(radioValue);
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