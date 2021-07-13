import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:surveyqu/domain.dart';
import 'package:surveyqu/hexacolor.dart';
import 'package:surveyqu/home/mainhome.dart';
import 'package:surveyqu/info.dart';
import 'package:surveyqu/network_utils/api.dart';

class ChangeProfile extends StatefulWidget {
  String email, firstname, lastname, address, ktp, ktpVerif, hp, hpVerif;
  ChangeProfile({this.email, this.address,this.firstname,this.hp,this.hpVerif,this.ktp,this.ktpVerif,this.lastname});
  @override
  _ChangeProfileState createState() => _ChangeProfileState(email: email, address: address, firstname: firstname, hp: hp, hpVerif: hpVerif, ktp:ktp, ktpVerif: ktpVerif, lastname: lastname);
}

class _ChangeProfileState extends State<ChangeProfile> {
  Size size;
  String email, firstname, lastname, address, ktp, ktpVerif, hp, hpVerif;
  Domain domain = new Domain();
  Info info = new Info();
  bool enableHp;
  var dataJson;

  _ChangeProfileState({this.email, this.address,this.firstname,this.hp,this.hpVerif,this.ktp,this.ktpVerif,this.lastname});

  bool pict;
  String status = '';
  String base64Image, fileName, imgProfile;
  String errMessage = 'Error Uploading Image';
  File _image;
  final picker = ImagePicker();

  startUpload(BuildContext context, String firstname, String lastname, String address, String hp) {
    fileName = _image == null ? ktp.split('/').last : _image.path.split('/').last;
    upload(context, firstname, lastname, address, hp, fileName);
  }

  upload(BuildContext context,String firstname, String lastname, String address, String hp, String fileName) async{
    var data = {
      "email": email,
      "firstname": firstname,
      "lastname": lastname,
      "address" : address,
      "hp": hp,
      "fotoKTP": base64Image,
      "namaFile": fileName,
    };
    var res = await Network().postDataToken(data, '/changeProfile');
    if (res.statusCode == 200) {
      Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (context) => new MainHome()), (route) => false);
      info.messagesAutoHide(context, "info", "sukses update profil");
      // info.LoadingToast(context, 'Gambar profil sudah terupdate');
    } else {
      info.messagesAutoHide(context, "info", "Update profil gagal");
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
        ? imgProfile == null ? new Container(alignment: Alignment.center,child: new CupertinoActivityIndicator()) :
    imgProfile == '1' ? new CachedNetworkImage(imageUrl:"http://www.surveyqu.com/sq/assets/gantella/images/users.jpg" ,fit: BoxFit.cover,) :
    new CachedNetworkImage(imageUrl: imgProfile ,fit: BoxFit.cover,)
        : Image.file(_image,
      fit: BoxFit.cover,);
  }

  // http://surveyqu.com/sqws/sqmid/index.php/auth/register
  // {"name" : "test", "password" : "12345","hp" : "0812345789","email":"ahmadsyarifhidayat23@gmail.com","ref":"123456"}
  TextEditingController textFname = new TextEditingController();
  TextEditingController textLname = new TextEditingController();
  TextEditingController textAddress = new TextEditingController();
  TextEditingController textHp = new TextEditingController();

  void _onLoading(firstname, lastname, address, hp) {
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
      startUpload(context, firstname, lastname, address, hp);
    });
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(hpVerif == '1'){
      setState(() {
        enableHp = true;
      });
    } else {
      setState(() {
        enableHp = false;
      });
    }
    // firstname, lastname, address, ktp, ktpVerif, hp, hpVerif
    setState(() {
      textFname.text = firstname;
      textLname.text = lastname;
      textAddress.text = address;
      textHp.text = hp;
      imgProfile = ktp;
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
              // if (textName.text == '') {
              //   info.messagesNoButton(context, "Info", "Input nama anda");
              // } else if (textHp.text == ''){
              //   info.messagesNoButton(context, "Info", "Input nomor handphone anda");
              // } else if (textHp.text.contains('08') == false){
              //   info.messagesNoButton(context, "Info", "Nomor handphone harus diawali dengan 08");
              // } else if (textEmail.text == ''){
              //   info.messagesNoButton(context, "Info", "Input email anda");
              // } else if (textEmail.text.contains('@') == false || textEmail.text.contains('.') == false ){
              //   info.messagesNoButton(context, "Info", "Email anda tidak valid");
              // } else if (textPass.text == ''){
              //   info.messagesNoButton(context, "Info", "Input password anda");
              // } else if (textPass.text.length < 6){
              //   info.messagesNoButton(context, "Info", "Password minimal 6 karakter");
              // } else {
                setState(() {
                  // Navigator.push(context, new MaterialPageRoute(builder: (context) => Verification(email: textEmail.text,)));
                  this._onLoading(textFname.text, textLname.text, textAddress.text, textHp.text);

                  // pict = false;
                  // _image == null ? info.MessageInfo(context, "Info", "Pilih gambar profil pada lingkar gambar") :
                  // startUpload(context);
                });
              // }
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
                              controller: textFname,
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
                              controller: textLname,
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
                  controller: textAddress,
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
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    new Text('No Hp'),
                    hpVerif == '1' ? new Row(
                      children: [
                        new Icon(Icons.verified, color: Colors.green,),
                        new Padding(padding: EdgeInsets.only(left: 5)),
                        new Text('Terverifikasi'),
                      ],
                    ): new Container(),
                  ],
                )
              ),
              new Container(
                width: size.width,
                height: 45,
                margin: const EdgeInsets.only(top: 5),
                child: new TextField(
                  readOnly: enableHp,
                  controller: textHp,
                  keyboardType: TextInputType.number,
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
                    suffixIcon: hpVerif != '1' ? null : new InkWell(
                      onTap: (){
                        setState(() {
                          if(hpVerif == '1'){
                            info.messagesAutoHide(context, "info", "Silahkan hubungi admin untuk perubahan nomor Hp");
                          }
                        });
                      },
                      child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 1.0, 15.0),
                      child: new Text('Ubah', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    // prefixIcon: Padding(padding: const EdgeInsets.fromLTRB(0.0, 0.0, 1.0, 1.0),
                    //   child: Icon(Icons.lock,),
                    // ),
                  ),
                  textInputAction: TextInputAction.done,
                ),
              ),
              new Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Text('Foto KTP'),
                      ktpVerif == '1' ? new Row(
                        children: [
                          new Icon(Icons.verified, color: Colors.green,),
                          new Padding(padding: EdgeInsets.only(left: 5)),
                          new Text('Terverifikasi'),
                        ],
                      ): new Container(),
                    ],
                  )
              ),
              new Center(
                child: ktpVerif == '1' ? new Container() : new Container(
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