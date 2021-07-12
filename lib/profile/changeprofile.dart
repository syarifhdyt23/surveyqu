import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:surveyqu/domain.dart';
import 'package:surveyqu/hexacolor.dart';
import 'package:surveyqu/info.dart';
import 'package:surveyqu/network_utils/api.dart';

class ChangeProfile extends StatefulWidget {
  String email;
  ChangeProfile({this.email});
  @override
  _ChangeProfileState createState() => _ChangeProfileState(email: email);
}

class _ChangeProfileState extends State<ChangeProfile> {
  Size size;
  String email;
  Domain domain = new Domain();
  Info info = new Info();
  var dataJson;

  _ChangeProfileState({this.email});

  bool pict;
  String status = '';
  String base64Image, fileName, imgProfile;
  String errMessage = 'Error Uploading Image';
  File _image;
  final picker = ImagePicker();

  startUpload(BuildContext context) {
    fileName = _image.path.split('/').last;
    upload(context, fileName);
  }

  upload(BuildContext context, String fileName) {
    final String url = "http://"+domain.getDomain()+"/profile/upload_image.php";
    http.post(Uri.parse(url), body: {
      "email": email,
      "image": base64Image,
      "path": fileName,
    }).then((result) {
      info.LoadingToast(context, 'Uploading Image...');
      if (result.statusCode == 200){
        // this.updateimg(fileName);
        info.LoadingToast(context, 'Gambar profil sudah terupdate');
        // this.getImage();
        // _image = null;
      } else {
        info.LoadingToast(context, errMessage);
      }

    }).catchError((error) {
      info.LoadingToast(context, error);
    });
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
        ? imgProfile == null ? new Container(alignment: Alignment.center,child: new CupertinoActivityIndicator()) :
    imgProfile == '1' ? new Icon(
      Icons.person,
      size: 60,
      color: Colors.lightBlue,
    ) :
    new NetworkImage(imgProfile)
        : Image.file(_image,
      height: 110, width: 110,
      fit: BoxFit.cover,);
  }

  // http://surveyqu.com/sqws/sqmid/index.php/auth/register
  // {"name" : "test", "password" : "12345","hp" : "0812345789","email":"ahmadsyarifhidayat23@gmail.com","ref":"123456"}
  TextEditingController textName = new TextEditingController();
  TextEditingController textHp = new TextEditingController();
  TextEditingController textEmail = new TextEditingController();
  TextEditingController textPass = new TextEditingController();
  TextEditingController textRef = new TextEditingController();

  void register(String email, String password, String name, String referral, String hp) async {
    var data = {
      'name': name,
      'password': password,
      'hp': hp,
      'email': email,
      'ref': referral,
    };

    var res = await Network().postDataAuth(data, '/register');
    if (res.statusCode == 200) {
      // var body = jsonDecode(res.body);
      // print(json.encode(body['message']));
      // Navigator.push(
      //   context, new MaterialPageRoute(builder: (context) => Verification(email: textEmail.text,)),
      // );
    } else if (res.statusCode == 204){
      info.messagesNoButton(context, 'info','Email Sudah terdaftar');
    } else {
      info.messagesNoButton(context, 'info','Pendaftaran gagal');
    }
  }

  void _onLoading(email, password, name, referral, hp) {
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
      register(email, password, name, referral, hp);
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    size = MediaQuery.of(context).size;

    return new Scaffold(
      appBar: AppBar(
        title: new Text("Ubah data diri"),
      ),
      bottomNavigationBar: new Container(
        height: 45,
        margin: const EdgeInsets.only(top: 20, bottom: 30, left: 15, right: 15),
        child: new FlatButton(
            onPressed: () {
              if (textName.text == '') {
                info.messagesNoButton(context, "Info", "Input nama anda");
              } else if (textHp.text == ''){
                info.messagesNoButton(context, "Info", "Input nomor handphone anda");
              } else if (textHp.text.contains('08') == false){
                info.messagesNoButton(context, "Info", "Nomor handphone harus diawali dengan 08");
              } else if (textEmail.text == ''){
                info.messagesNoButton(context, "Info", "Input email anda");
              } else if (textEmail.text.contains('@') == false || textEmail.text.contains('.') == false ){
                info.messagesNoButton(context, "Info", "Email anda tidak valid");
              } else if (textPass.text == ''){
                info.messagesNoButton(context, "Info", "Input password anda");
              } else if (textPass.text.length < 6){
                info.messagesNoButton(context, "Info", "Password minimal 6 karakter");
              } else {
                setState(() {
                  // Navigator.push(context, new MaterialPageRoute(builder: (context) => Verification(email: textEmail.text,)));
                  this._onLoading(textEmail.text, textPass.text, textName.text, textRef.text, textHp.text);

                  // pict = false;
                  // _image == null ? info.MessageInfo(context, "Info", "Pilih gambar profil pada lingkar gambar") :
                  // startUpload(context);
                });
              }
            },
            color: new HexColor("#EA5455"),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(7.0),
            ),
            child: new Text(
              'Daftar',
              style: new TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            )),
      ),
      body: new GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanDown: (_) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: new Container(
          color: Colors.white,
          child: new ListView(
            padding: const EdgeInsets.only(left: 15, right: 15),
            children: <Widget>[
              new Row(
                children: [
                  new Expanded(
                    flex: 1,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          new Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: new Text('Nama Depan'),
                          ),
                          new Container(
                            width: size.width,
                            height: 45,
                            margin: const EdgeInsets.only(top: 5, right: 10),
                            child: new TextField(
                              controller: textName,
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
                                // hintText: "Nama",
                                // hintStyle: TextStyle(
                                //     color: Colors.grey, fontFamily: 'helvetica'),
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                fillColor: Colors.grey[200],
                                filled: true,
                                // prefixIcon: Padding(padding: const EdgeInsets.fromLTRB(0.0, 0.0, 1.0, 1.0),
                                //   child: Icon(Icons.person,),
                                // ),
                              ),
                              textInputAction: TextInputAction.done,
                            ),
                          ),
                        ],
                    ),
                  ),
                  new Expanded(
                    flex: 1,
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          new Container(
                            margin: const EdgeInsets.only(top: 10, left: 10),
                            child: new Text('Nama Belakang'),
                          ),
                          new Container(
                            width: size.width,
                            height: 45,
                            margin: const EdgeInsets.only(top: 5, left: 10),
                            child: new TextField(
                              controller: textHp,
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
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ],
                      ),
                  ),
                ],
              ),
              new Container(
                margin: const EdgeInsets.only(top: 10),
                child: new Text('Alamat'),
              ),
              new Container(
                width: size.width,
                height: 45,
                margin: const EdgeInsets.only(top: 5),
                child: new TextField(
                  controller: textEmail,
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
              new Container(
                margin: const EdgeInsets.only(top: 10),
                child: new Text('No Hp'),
              ),
              new Container(
                width: size.width,
                height: 45,
                margin: const EdgeInsets.only(top: 5),
                child: new TextField(
                  controller: textPass,
                  obscureText: true,
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
                    // hintText: "Password",
                    // hintStyle: TextStyle(
                    //     color: Colors.grey, fontFamily: 'helvetica'),
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    fillColor: Colors.grey[200],
                    filled: true,
                    // prefixIcon: Padding(padding: const EdgeInsets.fromLTRB(0.0, 0.0, 1.0, 1.0),
                    //   child: Icon(Icons.lock,),
                    // ),
                  ),
                  textInputAction: TextInputAction.done,
                ),
              ),
              new Container(
                margin: const EdgeInsets.only(top: 10),
                child: new Text('Foto KTP'),
              ),
              new Center(
                child: new Container(
                  margin: const EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  height: 200,
                  child: new InkWell(
                    onTap: () {
                      // _ShowChoiceDialog(context);
                      selectUpload(context);
                    },
                    child: showImages2(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
}