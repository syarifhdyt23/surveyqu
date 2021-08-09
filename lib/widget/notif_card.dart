import 'package:flutter/material.dart';
import 'package:surveyqu/widget/description_page.dart';

import '../hexacolor.dart';

class NotifCard extends StatelessWidget {
  final String stsNotif, judul, flag;

  const NotifCard({Key key, this.stsNotif, this.judul, this.flag}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 10),
      decoration: BoxDecoration(
        color: stsNotif == '0' ? new HexColor('#256fa0') : Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(7)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(1, 2), // changes position of shadow
          ),
        ],
      ),
      child: new ListTile(
        leading: new Container(
          decoration: BoxDecoration(
            color: stsNotif == '0' ? Colors.white : new HexColor('#256fa0'),
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          padding: EdgeInsets.all(5),
          child: new Icon(flag == 'notif' ? Icons.notifications : Icons.list, size: 25, color: stsNotif == '0' ? new HexColor('#256fa0') : Colors.white,),
        ),
        title: new Text(judul,style: TextStyle(color: stsNotif == '0' ? Colors.white : new HexColor('#256fa0')),),
        // subtitle: new Text("Subtitle",style: TextStyle(color: Colors.white),),
      ),
    );
  }
}
