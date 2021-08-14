import 'dart:convert';
import 'dart:io';
import 'package:surveyqu/loading.dart';
import 'package:surveyqu/model/profile.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

class ChangeProfile extends StatefulWidget {
  String email;
  ChangeProfile({this.email});
  @override
  _ChangeProfileState createState() => _ChangeProfileState(email: email);
}

class _ChangeProfileState extends State<ChangeProfile> {
  Size size;
  String email, firstname, lastname, address, ktp, ktpVerif, hp, hpVerif;
  Domain domain = new Domain();
  Info info = new Info();
  bool enableHp;
  var dataJson;
  List<Province> listProv;
  List<Kabkot> listKabkot;
  List<User> listUser;
  List prov = List();
  List kabkot = List();
  String selectedProv, selectedProvId, selectedKabkot, selectedKabkotId;

  _ChangeProfileState({this.email});

  Future<void> getUser() async {
    var data = {
      'email': email,
    };
    var res = await Network().postDataToken(data, '/loadProfile');
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      var dataJson = body['result'];
      setState(() {
        listUser = dataJson.map<User>((json) => User.fromJson(json)).toList();
        textFname.text = listUser[0].firstname == null ? "" : listUser[0].firstname;
        textLname.text = listUser[0].lastname == null ? "" : listUser[0].lastname;
        textAddress.text = listUser[0].address == null ? "" : listUser[0].address;
        textHp.text = listUser[0].hp == null ? "" : listUser[0].hp;
        ktpVerif = listUser[0].ktpVerify == null ? "0" : listUser[0].ktpVerify;
        hpVerif = listUser[0].ishpVerify == null ? "0" : listUser[0].ishpVerify;
        selectedKabkotId = listUser[0].id_kab == null ? "" : listUser[0].id_kab;
        selectedProvId = listUser[0].id_prov == null ? "" : listUser[0].id_prov;
        selectedKabkot = listUser[0].namakab == null ? "" : listUser[0].namakab;
        selectedProv = listUser[0].namaprov == null ? "" : listUser[0].namaprov;
        imgProfile = listUser[0].ktp == null ? "1" : listUser[0].ktp;
        if(hpVerif == '1'){
          setState(() {
            enableHp = true;
          });
        } else {
          setState(() {
            enableHp = false;
          });
        }
      });
    }
    return listUser;
  }

  Future<void> getProv() async {
    var res = await Network().postToken('/provinsi');
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      var dataJson = body['content'];
      setState(() {
        listProv = dataJson.map<Province>((json) => Province.fromJson(json)).toList();
      });
      for (var i = 0; i < listProv.length; i++) {
        prov.add(listProv[i].nama);
      }
    }
    return listProv;
  }

  Future<void> getKabkot(String idprov) async {
    var data={
      'id_prov': idprov,
    };
    var res = await Network().postDataToken(data,'/kabkot');
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      var dataJson = body['content'];
      setState(() {
        listKabkot = dataJson.map<Kabkot>((json) => Kabkot.fromJson(json)).toList();
      });
      for (var i = 0; i < listKabkot.length; i++) {
        kabkot.add(listKabkot[i].nama);
      }
    }
    return listKabkot;
  }

  bool pict;
  String status = '';
  String base64Image, fileName, imgProfile;
  String errMessage = 'Error Uploading Image';
  File _image;
  final picker = ImagePicker();

  startUpload(BuildContext context, String firstname, String lastname, String address, String hp, String provId, String kabId) {
    if(base64Image != null){
      fileName = _image == null ? ktp.split('/').last : _image.path.split('/').last;
    } else {
      fileName = imgProfile.split('/').last;
    }
    upload(context, firstname, lastname, address, hp, fileName, provId, kabId);
  }

  upload(BuildContext context,String firstname, String lastname, String address, String hp, String fileName, String provId, String kabId) async{
    var data = {
      "email": email,
      "firstname": firstname,
      "lastname": lastname,
      "address" : address,
      "hp": hp,
      "fotoKTP": base64Image,
      "namaFile": fileName,
      "id_prov": provId,
      "id_kab": kabId
    };
    var res = await Network().postDataToken(data, '/changeProfile');
    if (res.statusCode == 200) {
      Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (context) => new MainHome()), (route) => false);
      info.messagesNoButton(context, "info", "Sukses update profil\nProses verifikasi 1X24 jam");
      // info.LoadingToast(context, 'Gambar profil sudah terupdate');
    } else {
      info.messagesNoButton(context, "info", "Update profil gagal");
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
    imgProfile == '1' ? new Icon(Icons.image_outlined, size: 100, color: Colors.grey,) :
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
      startUpload(context, firstname, lastname, address, hp, selectedProvId, selectedKabkotId);
    });
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getProv();
    this.getKabkot('');
    this.getUser();
    // if(hpVerif == '1'){
    //   setState(() {
    //     enableHp = true;
    //   });
    // } else {
    //   setState(() {
    //     enableHp = false;
    //   });
    // }
    // // firstname, lastname, address, ktp, ktpVerif, hp, hpVerif
    // setState(() {
    //   textFname.text = firstname == null ? "" : firstname;
    //   textLname.text = lastname == null ? "" : lastname;
    //   textAddress.text = address == null ? "" : address;
    //   textHp.text = hp == null ? "" : hp;
    //   imgProfile = ktp  == null || ktp == "" ? "1" : ktp;
    //   selectedProv = namaprov == null ? "" : namaprov;
    //   selectedKabkot = namakab == null ? "" : namakab;
    //   selectedProvId = id_prov == null ? "" : id_prov;
    //   selectedKabkotId = id_kab == null ? "" : id_kab;
    // });
  }

  void ShowProvince(BuildContext context) {
    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return new StatefulBuilder(builder: (context, state) {
            return new Container(
                height: MediaQuery.of(context).size.height * 0.70,
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(10.0),
                    topRight: const Radius.circular(10.0),
                  ),
                ),
                child: new Stack(
                  children: [
                    new Container(
                      padding: const EdgeInsets.only(top: 20.0, left: 15.0, bottom: 10.0),
                      child: new Text('Provinsi',
                        style: new TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                    new Divider(
                      height: 120,
                    ),
                    listProv == null ? new Container(alignment: Alignment.center, child: new CircularProgressIndicator()) :
                    new Container(
                      padding: const EdgeInsets.only(top: 60),
                      child: new Scrollbar(
                        child: new ListView.separated(
                          itemCount: listProv.length,
                          itemBuilder: (context, i) {
                            return new InkWell(
                              onTap: (){
                                setState(() {
                                  selectedProv = listProv[i].nama;
                                  selectedProvId = listProv[i].idProv;
                                  this.getKabkot(listProv[i].idProv);
                                  Navigator.of(context).pop();
                                });
                              },
                              child: new Container(
                                child: new ListTile(
                                  title: new Text(listProv[i].nama),
                                  trailing: new Icon(Icons.arrow_forward_ios),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, i) => new Divider(),
                        ),
                      ),
                    )
                  ],
                )
            );
          }
          );
        }
    );
  }

  void ShowCity(BuildContext context) {
    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return new StatefulBuilder(builder: (context, state) {
            return new Container(
                height: MediaQuery.of(context).size.height * 0.70,
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(10.0),
                    topRight: const Radius.circular(10.0),
                  ),
                ),
                child: new Stack(
                  children: [
                    new Container(
                      padding: const EdgeInsets.only(top: 20.0, left: 15.0, bottom: 10.0),
                      child: new Text('Kabupaten/ Kota',
                        style: new TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                    new Divider(
                      height: 120,
                    ),
                    listKabkot == null ? new Container(alignment: Alignment.center, child: new Text("Please select province"),) :
                    new Container(
                      padding: const EdgeInsets.only(top: 60),
                      child: new Scrollbar(
                        child: new ListView.separated(
                          itemCount: listKabkot == null ? 0 : listKabkot.length,
                          itemBuilder: (context, i) {
                            return new InkWell(
                              onTap: (){
                                setState(() {
                                  selectedKabkot = listKabkot[i].nama;
                                  selectedKabkotId = listKabkot[i].idKab;
                                  Navigator.of(context).pop();
                                });
                              },
                              child: new Container(
                                child: new ListTile(
                                  title: new Text(listKabkot[i].nama),
                                  trailing: new Icon(Icons.arrow_forward_ios),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, i) => new Divider(),
                        ),
                      ),
                    )
                  ],
                )
            );
          }
          );
        }
    );
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
              if (textFname.text == '') {
                info.messagesNoButton(context, "Info", "Nama depan harus diisi");
              } else if (textHp.text == ''){
                info.messagesNoButton(context, "Info", "Nomor Hp harus diisi");
              } else if (textHp.text.contains('08') == false){
                info.messagesNoButton(context, "Info", "Nomor Hp harus diawali dengan 08");
              } else if (textLname.text == ''){
                info.messagesNoButton(context, "Info", "Nama belakang harus diisi");
              } else if (selectedProvId == '' || selectedProvId == null){
                info.messagesNoButton(context, "Info", "Alamat provinsi harus diisi");
              } else if (selectedKabkotId == '' || selectedKabkotId == null){
                info.messagesNoButton(context, "Info", "Alamat Kabupaten/ Kota harus diisi");
              } else if (imgProfile == null){
                info.messagesNoButton(context, "Info", "Unggah foto KTP");
              } else {
                setState(() {
                  // Navigator.push(context, new MaterialPageRoute(builder: (context) => Verification(email: textEmail.text,)));
                  this._onLoading(textFname.text, textLname.text, textAddress.text, textHp.text);

                  // pict = false;
                  // _image == null ? info.MessageInfo(context, "Info", "Pilih gambar profil pada lingkar gambar") :
                  // startUpload(context);
                });
              }
            },
            color: new HexColor("#F07B3F"),
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
      body: listUser == null ? new Loading() : new GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanDown: (_) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
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
                                    left: 18.0, bottom: 0.0, top: 7.0),
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
                                    left: 18.0, bottom: 0.0, top: 7.0),
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
                child: new Text('Provinsi'),
              ),
              new Container(
                //width: size.width - 20,
                height: 45,
                margin: const EdgeInsets.only(top: 3),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.grey.withOpacity(.2), width: 1,),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: new FlatButton(
                  onPressed: (){
                    setState(() {
                      this.ShowProvince(context);
                    });
                  },
                  color: Colors.grey[200],
                  child: new Align(
                    alignment: Alignment.centerLeft,
                    child: new Text(selectedProv == null ? 'Pilih Provinsi' : selectedProv,
                      textAlign: TextAlign.left,
                      style: new TextStyle(color: selectedProv == null ? Colors.grey : Colors.black, fontWeight: FontWeight.w400, fontFamily: 'Roboto'),
                    ),
                  ),
                ),
              ),
              new Container(
                margin: const EdgeInsets.only(top: 10),
                child: new Text('Kabupaten/ Kota'),
              ),
              new Container(
                //width: size.width - 20,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.grey.withOpacity(.2), width: 1,),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                margin: const EdgeInsets.only(top: 5),
                child: new FlatButton(
                  onPressed: (){
                    setState(() {
                      if(selectedProv == "" || selectedProv == null){
                      info.MessageToast("Pilih provinsi terlebih dahulu");
                      } else {
                        this.ShowCity(context);
                      }
                    });
                  },
                  child: new Align(
                    alignment: Alignment.centerLeft,
                    child: new Text(selectedKabkot == null ? 'Pilih Kabupaten/ Kota' : selectedKabkot,
                      textAlign: TextAlign.left,
                      style: new TextStyle(color: selectedKabkot == null ? Colors.grey : Colors.black, fontWeight: FontWeight.w400, fontFamily: 'Roboto'),
                    ),
                  ),
                ),
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
                        left: 18.0, bottom: 0.0, top: 7.0),
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
                        left: 18.0, bottom: 0.0, top: 7.0),
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
                            info.messagesNoButton(context, "info", "Silahkan hubungi admin untuk perubahan nomor Hp");
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
              ),
            ],
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