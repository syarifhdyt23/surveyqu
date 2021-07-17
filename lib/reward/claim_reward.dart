import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:surveyqu/hexacolor.dart';
import 'package:surveyqu/info.dart';
import 'package:surveyqu/network_utils/api.dart';

class ClaimReward extends StatefulWidget {
  String saldo, email;
  ClaimReward({this.saldo, this.email});
  @override
  _ClaimRewardState createState() => _ClaimRewardState(saldo: saldo, email: email);
}

class _ClaimRewardState extends State<ClaimReward> {
  String saldo, email;
  Size size;
  Info info = new Info();
  TextEditingController textSaldo = new TextEditingController();
  final currencyFormat = new NumberFormat.currency(locale: 'id', symbol: "Rp", decimalDigits: 0);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static const _locale = 'en';
  String _formatNumber(String s) => NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency => NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;

  _ClaimRewardState({this.saldo, this.email});

  Future<void> TarikDana(String email, nominal) async {
    var data = {
      'email': email,
      'nominal': nominal,
    };

    var res = await Network().postDataToken(data, '/tarikHit');
    if (res.statusCode == 200) {
      // var body = jsonDecode(res.body);
      // print(json.encode(body['message']));
      info.messagesSuccess(context, true, 'Sukses','Saldo berhasil ditarik, segera diproses oleh admin');
    } else {
      info.messagesNoButton(context, 'info','Minimum Penarikan Rp50,000\natau\nSaldo tidak mencukupi');
      textSaldo.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return new Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1.0,
        title: new Text('Penarikan Dana'),
      ),
      bottomNavigationBar: new Container(
        height: 45,
        margin: const EdgeInsets.only(top: 20, bottom: 30, left: 15, right: 15),
        child: new FlatButton(
            onPressed: () {
              // textSaldo.text = _formatNumber(textSaldo.text.replaceAll('', ','));
              String saldo = textSaldo.text.replaceAll(',', '');
              // print(textSaldo.text);
              TarikDana(email, saldo);
            },
            color: new HexColor("#EA5455"),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(7.0),
            ),
            child: new Text(
              'Tarik Dana',
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
            children: [
              new Container(
                color: new HexColor('#256fa0'),
                padding: EdgeInsets.only(top: 10,left: 15, bottom: 10),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Container(
                      alignment: Alignment.centerLeft,
                      child: new Text(
                        'Saldo Anda',
                        style: new TextStyle(
                          fontFamily: "helvetica",
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    new Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(top: 5),
                      child: new Text(
                        saldo == '0' ? "Rp.$saldo" : currencyFormat.format(int.parse(saldo)),
                        style: new TextStyle(
                          fontFamily: "helvetica",
                          fontWeight: FontWeight.w600,
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              new Container(
                margin: const EdgeInsets.only(top: 20, left: 15, right: 15),
                child: new Text("Masukkan dana yang ingin ditarik :", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),),
              ),
              new Container(
                width: size.width,
                height: 45,
                margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
                child: new TextFormField(
                  controller: textSaldo,
                  // inputFormatters: [
                  //   WhitelistingTextInputFormatter.digitsOnly,
                  //   Fit the validating format.
                  //   fazer o formater para dinheiro
                  //   CurrencyInputFormatter()
                  // ],
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
                    // border: InputBorder.none,
                    // hintText: "Nomor Handphone (08xx)",
                    // hintStyle: TextStyle(
                    //  color: Colors.grey, fontFamily: 'helvetica'),
                    prefixIcon: Padding(padding: const EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
                      child: new Text("Rp", style: TextStyle(fontSize: 17),)
                    ),
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  onChanged: (string) {
                    string = '${_formatNumber(string.replaceAll(',', ''))}';
                    textSaldo.value = TextEditingValue(
                      text: string,
                      selection: TextSelection.collapsed(offset: string.length),
                    );
                  },
                ),
              ),
            ],
        )
      ),
    );
  }
}

class CurrencyInputFormatter extends TextInputFormatter {

  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

    if(newValue.selection.baseOffset == 0){
      print(true);
      return newValue;
    }

    double value = double.parse(newValue.text);

    final formatter = NumberFormat.simpleCurrency(locale: "in", decimalDigits: 0);

    String newText = formatter.format(value);

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}
