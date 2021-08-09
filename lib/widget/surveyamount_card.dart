import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:surveyqu/widget/description_page.dart';

import '../hexacolor.dart';

class SurveyAmount extends StatelessWidget {
  final String date, judul, flag, amount, isi;

  SurveyAmount({Key key, this.date, this.judul, this.flag, this.amount, this.isi}) : super(key: key);

  final currencyFormat = new NumberFormat.currency(locale: 'en', symbol: "Rp", decimalDigits: 0);
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.all(Radius.circular(7)),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.5),
        //     spreadRadius: 2,
        //     blurRadius: 4,
        //     offset: Offset(1, 2), // changes position of shadow
        //   ),
        // ],
      ),
      child: new ListTile(
        leading: new Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          padding: EdgeInsets.all(5),
          child: new Icon(flag == 'notif' ? Icons.arrow_circle_down_outlined : Icons.arrow_circle_up_outlined, size: 35, color: new HexColor('#256fa0')),
        ),
        title: new Text(judul,style: TextStyle(color: date == '0' ? Colors.white : new HexColor('#256fa0')),),
        subtitle: new Text(isi,style: TextStyle(color: date == '0' ? Colors.white : Colors.grey),),
        trailing: new Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Text(amount == null || amount == '0' || amount == ''? 'Rp.0' : currencyFormat.format(int.parse(amount)), style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),),
            new Padding(padding: EdgeInsets.only(top: 5)),
            new Text(date, style: TextStyle(color: Colors.grey),)
          ],
        ),
        // subtitle: new Text("Subtitle",style: TextStyle(color: Colors.white),),
      ),
    );
  }
}
