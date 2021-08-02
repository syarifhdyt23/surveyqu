import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surveyqu/domain.dart';
import 'dart:async';
import 'dart:convert';
import 'package:surveyqu/info.dart';
import 'package:surveyqu/loading.dart';
import 'package:surveyqu/login/login.dart';
import 'package:surveyqu/model/profile.dart';
import 'package:surveyqu/network_utils/api.dart';
import 'package:surveyqu/profile/changepass.dart';
import 'package:surveyqu/profile/changeprofile.dart';
import 'package:surveyqu/profile/privacypolicy.dart';
import 'package:surveyqu/profile/rekeningpage.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  Info info = new Info();
  Size size;
  Domain domain = new Domain();
  bool _visible = false;
  String id, email, nama;
  List<Privacy> listPrivacy;
  List<User> listUser;
  bool pict;
  String status = '';
  String base64Image, fileName, imgProfile, ktpVerify, hpVerify, id_prov, namaprov, id_kab, namakab;
  String errMessage = 'Error Uploading Image';
  File _image;
  final picker = ImagePicker();

  startUpload(BuildContext context) {
    fileName = _image.path.split('/').last;
    upload(context, fileName);
  }

  upload(BuildContext context, String fileName) async{
    var data = {
      "email": email,
      "foto": base64Image,
      "namaFile": fileName,
    };
    var res = await Network().postDataToken(data, '/changeFoto');
    if (res.statusCode == 200) {
      this.getUser();
      info.messagesNoButton(context, "info", "Sukses ganti foto profil");
      // info.LoadingToast(context, 'Gambar profil sudah terupdate');
    } else {
      info.messagesNoButton(context, "info", "tidak sukses ganti foto");
    }
    // final String url = "http://"+domain.getDomain()+"/changeProfile";
    // http.post(Uri.parse(url), body: {
    //   "email": email,
    //   "foto": base64Image,
    //   "namaFile": fileName,
    // }).then((result) {
    //   info.LoadingToast(context, 'Uploading Image...');
    //   if (result.statusCode == 200){
    //     // this.updateimg(fileName);
    //     info.LoadingToast(context, 'Gambar profil sudah terupdate');
    //     // this.getImage();
    //     // _image = null;
    //   } else {
    //     info.LoadingToast(context, errMessage);
    //   }
    //
    // }).catchError((error) {
    //   info.LoadingToast(context, error.toString());
    // });
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
      pict = false;
      startUpload(context);
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
      pict = false;
      startUpload(context);
    });
  }

  Widget showImages2() {
    return _image == null
        ? imgProfile == null ? new Container(alignment: Alignment.center,child: new CupertinoActivityIndicator()) :
    imgProfile == '' ? new Icon(Icons.person, size: 90,) :
    new CachedNetworkImage(imageUrl: imgProfile , height: 110, width: 110, fit: BoxFit.cover,)
        : Image.file(_image,
      height: 110, width: 110,
      fit: BoxFit.cover,);
  }

  // Future<void> updateimg(String fileName) async {
  //   http.get(Uri.parse("http://"+ domain.getDomain() +"/update.php?action=setImageProfile&memberid="+memberId+"&image="+fileName),
  //       headers: {"Accept": "application.json"});
  // }

  @override
  void initState() {
    super.initState();
    this._loadUserData();
    this.getUser();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var id = jsonDecode(localStorage.getString('id'));

    if (id != null) {
      setState(() {
        id = id;
        email = jsonDecode(localStorage.getString('email'));
        nama = jsonDecode(localStorage.getString('firstname'));
      });
    }
  }

  Future<void> getUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    email = jsonDecode(localStorage.getString('email'));
    var data = {
      'email': email,
    };
    var res = await Network().postDataToken(data, '/loadProfile');
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      var dataJson = body['result'];
      setState(() {
        if(dataJson == 'null'){
          imgProfile = '';
          ktpVerify = '0';
          hpVerify = '0';
        } else {
          listUser = dataJson.map<User>((json) => User.fromJson(json)).toList();
          nama = listUser[0].firstname == null ? "" : listUser[0].firstname;
          imgProfile = listUser[0].foto == null ? "" : listUser[0].foto;
          ktpVerify = listUser[0].ktpVerify == null ? "0" : listUser[0].ktpVerify;
          hpVerify = listUser[0].ishpVerify == null ? "0" : listUser[0].ishpVerify;
          id_kab = listUser[0].id_kab == null ? "" : listUser[0].id_kab;
          id_prov = listUser[0].id_prov == null ? "" : listUser[0].id_prov;
          namakab = listUser[0].namakab == null ? "" : listUser[0].namakab;
          namaprov = listUser[0].namaprov == null ? "" : listUser[0].namaprov;
        }
      });
    }
    return listUser;
  }

  Future<void> getContent(String link) async {
    var res = await Network().postToken(link);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      var dataJson = body['result'];
      setState(() {
        listPrivacy = dataJson.map<Privacy>((json) => Privacy.fromJson(json)).toList();
      });
    }
    return listPrivacy;
  }

  Future<void> openURL(BuildContext context, String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      info.MessageInfo(context, 'Message', "Please install this apps");
    }
  }

  Future<void> openWa(BuildContext context, String isi, String no) async {
    String url() {
      if (Platform.isAndroid) {
        // add the [https]
        return "https://wa.me/$no/?text=${Uri.parse(isi)}"; // new line
      } else {
        // add the [https]
        return "https://api.whatsapp.com/send?phone=$no=${Uri.parse(isi)}"; // new line
      }
    }
    if (await canLaunch(url())) {
      await launch(url(),
          universalLinksOnly: true, forceSafariVC: Platform.isIOS == false ? true : false , forceWebView: false);
    } else {
      info.messagesNoButton(context, 'Message', "Please install this apps");
    }

  }

  void messagesLogout(BuildContext context, String title, String desc) async {
    new AwesomeDialog(
        context: context,
        dialogType: DialogType.QUESTION,
        headerAnimationLoop: false,
        animType: AnimType.TOPSLIDE,
        title: title,
        desc: desc,
        useRootNavigator: true,
        btnCancelOnPress: () {},
        btnOkOnPress: () {
          logout();
        })
      ..show();
  }

  void logout() async {
    var res = await Network().postDataId('/logout');
    var body = json.decode(res.body);
    if (body['status'] == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.clear();
      Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
          new MaterialPageRoute(builder: (context) => Login()),
              (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    size = MediaQuery.of(context).size;

    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(top: 280),
            child: new ListView(
                children: [
                  new Container(
                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 10),
                    child: new Text(
                      'Akun',
                      style: new TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,),
                    ),
                  ),
                  new Container(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        new Container(
                          color: Colors.white,
                          child: new InkWell(
                              onTap: () {
                                // this.messagesLogout(context, 'keluar', 'anda yakin ingin keluar?');
                                Navigator.of(context, rootNavigator: true).push(new MaterialPageRoute(builder: (context,) =>
                                new ChangeProfile(email: email,address: listUser[0].address, firstname: listUser[0].firstname, hp: listUser[0].hp,
                                  lastname: listUser[0].lastname, hpVerif: listUser[0].ishpVerify, ktpVerif: listUser[0].ktpVerify, ktp: listUser[0].ktp,
                                id_kab: listUser[0].id_kab, id_prov: listUser[0].id_prov, namakab: listUser[0].namakab, namaprov: listUser[0].namaprov,)));
                              },
                              child: new ListTile(
                                title: new Text(
                                  'Ubah Data Diri',
                                  style: new TextStyle(fontSize: 15,),
                                ),
                                leading: new Icon(CupertinoIcons.person,color: Colors.blue,),
                                trailing: new Icon(Icons.arrow_forward_ios,color: Colors.blue,),
                              )
                          ),
                        ),
                        new Divider(height: 0.1,),
                        new Container(
                          color: Colors.white,
                          child: new InkWell(
                              onTap: () {
                                // this.messagesLogout(context, 'keluar', 'anda yakin ingin keluar?');
                                Navigator.of(context, rootNavigator: true).push(new MaterialPageRoute(builder: (context,) => new ChangePass()));
                                // info.messagesSuccess(context, true, 'info','Ganti password sukses');
                              },
                              child: new ListTile(
                                title: new Text(
                                  'Ubah Kata Sandi',
                                  style: new TextStyle(fontSize: 15,),
                                ),
                                leading: new Icon(CupertinoIcons.lock,color: Colors.blue,),
                                trailing: new Icon(Icons.arrow_forward_ios,color: Colors.blue,),
                              )
                          ),
                        ),
                        new Divider(height: 0.1,),
                        new Container(
                          color: Colors.white,
                          child: new InkWell(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true).push(new MaterialPageRoute(builder: (context,) => new RekeningPage(email: email,)));
                              },
                              child: new ListTile(
                                title: new Text(
                                  'Rekening Bank',
                                  style: new TextStyle(fontSize: 15,),
                                ),
                                leading: new Icon(CupertinoIcons.creditcard,color: Colors.blue,),
                                trailing: new Icon(Icons.arrow_forward_ios,color: Colors.blue,),
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 10),
                    child: new Text(
                      'Info Lainnya',
                      style: new TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,),
                    ),
                  ),
                  new Container(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        new Container(
                          color: Colors.white,
                          child: new InkWell(
                              onTap: () async {
                                await this.getContent('/qa');
                                this.openURL(context, listPrivacy[0].isi);
                              },
                              child: new ListTile(
                                title: new Text(
                                  'Pertanyaan Umum',
                                  style: new TextStyle(fontSize: 15,),
                                ),
                                leading: new Icon(CupertinoIcons.mail,color: Colors.blue,),
                                trailing: new Icon(Icons.arrow_forward_ios,color: Colors.blue,),
                              )
                          ),
                        ),
                        new Divider(height: 0.1,),
                        new Container(
                          color: Colors.white,
                          child: new InkWell(
                              onTap: () {
                                // this.messagesLogout(context, 'keluar', 'anda yakin ingin keluar?');
                                Navigator.of(context, rootNavigator: true).push(new MaterialPageRoute(builder: (context,) => new PrivacyPolicy(link: '/kebijakan', title: 'Kebijakan Privasi',)));
                              },
                              child: new ListTile(
                                title: new Text(
                                  'Kebijakan Privasi',
                                  style: new TextStyle(fontSize: 15,),
                                ),
                                leading: new Icon(CupertinoIcons.lock_shield,color: Colors.blue,),
                                trailing: new Icon(Icons.arrow_forward_ios,color: Colors.blue,),
                              )
                          ),
                        ),
                        new Divider(height: 0.1,),
                        new Container(
                          color: Colors.white,
                          child: new InkWell(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true).push(new MaterialPageRoute(builder: (context,) => new PrivacyPolicy(link: '/sk', title: 'Syarat dan Ketentuan',)));
                              },
                              child: new ListTile(
                                title: new Text(
                                  'Syarat dan Ketentuan',
                                  style: new TextStyle(fontSize: 15,),
                                ),
                                leading: new Icon(CupertinoIcons.square_list,color: Colors.blue,),
                                trailing: new Icon(Icons.arrow_forward_ios,color: Colors.blue,),
                              )
                          ),
                        ),
                        new Divider(height: 0.1,),
                        new Container(
                          color: Colors.white,
                          child: new InkWell(
                              onTap: () async {
                                await this.getContent('/hc');
                                this.openWa(context, listPrivacy[0].isi, listPrivacy[0].no);
                              },
                              child: new ListTile(
                                title: new Text(
                                  'Hubungi Help Center',
                                  style: new TextStyle(fontSize: 15,),
                                ),
                                leading: new Icon(CupertinoIcons.chat_bubble_2,color: Colors.blue,),
                                trailing: new Icon(Icons.arrow_forward_ios,color: Colors.blue,),
                              )
                          ),
                        ),
                        new Divider(height: 0.1,),
                        new Container(
                          color: Colors.white,
                          child: new InkWell(
                              onTap: () {
                                this.messagesLogout(context, 'keluar', 'anda yakin ingin keluar?');
                              },
                              child: new ListTile(
                                title: new Text(
                                  'Keluar',
                                  style: new TextStyle(fontSize: 15,),
                                ),
                                leading: new Icon(Icons.logout,color: Colors.blue,),
                                trailing: new Icon(Icons.arrow_forward_ios,color: Colors.blue,),
                              )
                          ),
                        ),
                      ],
                    ),
                  )
              ],
            ),
          ),
          new Container(
              height: 300,
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
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new Container(
                    padding: EdgeInsets.only(top: 20),
                    child: new Stack(
                    children: [
                      new Center(
                        child: new CircleAvatar(
                          radius: 58.0,
                          backgroundColor: Colors.blue,
                          child: new InkWell(
                            onTap: () {
                              // _ShowChoiceDialog(context);
                            },
                            child: new CircleAvatar(
                              radius: 63.0,
                              backgroundColor: Colors.white,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(53.0),
                                  child: showImages2()
                              ),
                            ),
                          ),
                        ),
                      ),
                      new Container(
                        padding: EdgeInsets.only(top: 90, left: 60),
                        child: new Center(
                          child: new CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 15,
                            child: new FlatButton(
                              padding: EdgeInsets.all(5),
                              onPressed: (){
                                selectUpload(context);
                              },
                              child: new Icon(
                                Icons.camera_alt_outlined, color: Colors.blue, size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // pict != true ? new Container() : new Container(
                      //   padding: EdgeInsets.only(top: 70, left: 60),
                      //     child: new Center(
                      //       child: new CircleAvatar(
                      //         backgroundColor: Colors.white,
                      //         radius: 20,
                      //         child: new FlatButton(
                      //           padding: EdgeInsets.all(5),
                      //           onPressed: (){
                      //             pict = false;
                      //             _image == null ? info.MessageInfo(context, "Info", "Pilih gambar profil pada lingkar gambar") :
                      //             startUpload(context);
                      //           },
                      //           child: new Icon(
                      //             Icons.save, color: Colors.blue, size: 25,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                    ],
                    )
                  ),
                  new Container(
                    padding: EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    child: new Text(
                      '$nama',
                      style: new TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  new Container(
                    alignment: Alignment.center,
                    child: new Text(
                      '$email',
                      style: new TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  ktpVerify == null ? new Loading() : ktpVerify == '0' || hpVerify == '0' ?
                  new InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: (){
                      info.messagesNoButton(context, "Info", "Silahkan ubah data diri atau \nhubungi help center untuk verifikasi");
                    },
                    child: new Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            new Icon(Icons.cancel, color: Colors.yellow[700], size: 20,),
                            new Container(
                              padding: EdgeInsets.only(left: 5),
                              child: new Text('Akun belum di verifikasi',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        )
                    ),
                  ) :
                  new Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          new Icon(Icons.verified, color: Colors.yellow[700], size: 20,),
                          new Container(
                            padding: EdgeInsets.only(left: 5),
                            child: new Text('Akun terverifikasi',
                              style: TextStyle(

                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      )
                  ),
                ],
              )),
        ],
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
