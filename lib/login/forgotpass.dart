import 'package:flutter/material.dart';
import 'package:surveyqu/domain.dart';
import 'package:surveyqu/hexacolor.dart';
import 'package:surveyqu/info.dart';
import 'package:surveyqu/network_utils/api.dart';

class ForgotPass extends StatefulWidget {
  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  Size size;
  Domain domain = new Domain();
  Info info = new Info();
  var dataJson;

  TextEditingController textEmail = new TextEditingController();

  void forgotpass(String email) async {
    var data = {
      'email': email,
    };

    var res = await Network().postDataAuth(data, '/forgotPass');
    if (res.statusCode == 200) {
      Navigator.of(context).pop();
      info.messagesAutoHide(context, 'info','Cek email untuk ubah password');
    } else if (res.statusCode == 204){
      info.messagesNoButton(context, 'info','Email tidak terdaftar');
    } else {
      info.messagesNoButton(context, 'info','Pendaftaran gagal');
    }
  }

  void _onLoading(email) {
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
      this.forgotpass(email);
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    size = MediaQuery.of(context).size;

    return new Scaffold(
      body: new GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanDown: (_) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: new Container(
          color: Colors.white,
          child: new Stack(
            children: <Widget>[
              new Container(
                height: 250,
                margin: const EdgeInsets.only(left: 30.0, right: 30.0),
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage('images/logo.png'),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                alignment: Alignment.center,
              ),
              new Container(
                height: 70,
                width: 50,
                padding: EdgeInsets.only(top: 50),
                child: new InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: new Icon(Icons.arrow_back),
                ),
              ),
              new Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  image: new DecorationImage(
                    image: new AssetImage('images/banner.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                margin: const EdgeInsets.only(top: 250),
                child: new ListView(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  children: <Widget>[
                    new Container(
                      child: new Container(
                          margin: const EdgeInsets.only(top: 30),
                          child: new Text(
                            "Masukkan email yang terdaftar pada surveyQu untuk reset password anda",
                            style: new TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                      ),
                    ),
                    new Container(
                      width: size.width,
                      height: 45,
                      margin: const EdgeInsets.only(top: 20),
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
                          hintText: "Email",
                          hintStyle: TextStyle(
                              color: Colors.grey, fontFamily: 'helvetica'),
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          fillColor: Colors.grey[200],
                          filled: true,
                          prefixIcon: Padding(padding: const EdgeInsets.fromLTRB(0.0, 0.0, 1.0, 1.0),
                            child: Icon(Icons.email,),
                          ),
                        ),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    new Container(
                      height: 45,
                      margin: const EdgeInsets.only(top: 20, bottom: 30),
                      child: new FlatButton(
                          onPressed: () {
                            if (textEmail.text == ''){
                              info.messagesNoButton(context, "Info", "Input email anda");
                            } else if (textEmail.text.contains('@') == false || textEmail.text.contains('.') == false ){
                              info.messagesNoButton(context, "Info", "Email anda tidak valid");
                            } else {
                              this._onLoading(textEmail.text);
                            }
                          },
                          color: new HexColor("#EA5455"),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(7.0),
                          ),
                          child: new Text(
                            'Kirim',
                            style: new TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                          )),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

