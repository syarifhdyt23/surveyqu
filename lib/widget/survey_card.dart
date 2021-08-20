import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:surveyqu/hexacolor.dart';
import 'package:surveyqu/info.dart';
import 'package:surveyqu/survey/surveyview.dart';

class SurveyCardProgress extends StatelessWidget {
  Info info = new Info();
  Size size;
  final String color,judul,deskripsi,gambar, id, jenis, quota, totalquota;

  SurveyCardProgress({Key key, this.color, this.judul, this.deskripsi, this.gambar, this.id, this.jenis, this.quota, this.totalquota}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 20),
        // width: size.width,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: new HexColor(color),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(1, 2), // changes position of shadow
            ),
          ],
        ),
        child: new Column(
          children: [
            new Expanded(
                flex:4,
                child: new Container(
                  alignment: Alignment.center,
                  child: new ListTile(
                    isThreeLine: true,
                    title: new Container(
                      child: new Text(judul, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20,)),
                    ),
                    subtitle: new Container(
                      margin: EdgeInsets.only(top: 20),
                      child: new Text(deskripsi, style: TextStyle(color: Colors.white)),
                    ),
                    trailing: new Container(
                      width: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(gambar),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ),
                )
            ),
            new Expanded(
              flex:3,
              child: new Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                ),
                child: new ListTile(
                  title: new CircularPercentIndicator(
                    radius: 50.0,
                    animation: true,
                    animationDuration: 1200,
                    lineWidth: 8.0,
                    percent: 1.0,
                    startAngle: double.parse(quota),
                    footer: new Text(
                      "40 hours",
                      style:
                      new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    circularStrokeCap: CircularStrokeCap.butt,
                    backgroundColor: Colors.yellow,
                    progressColor: Colors.red,
                  ),
                  subtitle: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Text('Reward per tugas'),
                      new Row(
                        children: [
                          new Icon(Icons.control_point_duplicate_sharp),
                          new Padding(padding: EdgeInsets.only(left: 10)),
                          new Text('100 poin'),
                        ],
                      )
                    ],
                  ),
                  trailing: new InkWell(
                    onTap: (){
                      if(quota == '0'){
                        info.MessageInfo(context, 'info','Survey sudah memenuhi kuota');
                      } else {
                        Navigator.of(context, rootNavigator: true).push(new MaterialPageRoute(builder: (context) => SurveyView(judul: judul, deskripsi: deskripsi, id: id, jenis: jenis,)));
                      }
                    },
                    child: new Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: new HexColor("#F07B3F"),
                      ),
                      child: new Text('Mulai', style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ),
              ),),
          ],
        )
    );
  }
}

class SurveyCardLeft extends StatelessWidget {
  Info info = new Info();
  Size size;
  final String color,judul,deskripsi,gambar, id, jenis, quota;

  SurveyCardLeft({Key key, this.color, this.judul, this.deskripsi, this.gambar, this.id, this.jenis, this.quota}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 20),
        // width: size.width,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: new HexColor(color),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(1, 2), // changes position of shadow
            ),
          ],
        ),
        child: new Column(
          children: [
            new Expanded(
                flex:5,
                child: new Container(
                  alignment: Alignment.center,
                  child: new ListTile(
                    isThreeLine: true,
                    title: new Container(
                      child: new Text(judul, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20,)),
                    ),
                    subtitle: new Container(
                      margin: EdgeInsets.only(top: 20),
                      child: new Text(deskripsi, style: TextStyle(color: Colors.white)),
                    ),
                    trailing: new Container(
                      width: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(gambar),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ),
                )
            ),
            new Expanded(
              flex:3,
              child: new Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                ),
                child: new ListTile(
                  title: new Text('Reward per tugas'),
                  subtitle: new Row(
                    children: [
                      new Icon(Icons.control_point_duplicate_sharp),
                      new Padding(padding: EdgeInsets.only(left: 10)),
                      new Text('100 poin'),
                    ],
                  ),
                  trailing: new InkWell(
                    onTap: (){
                      if(quota == '0'){
                        info.MessageInfo(context, 'info','Survey sudah memenuhi kuota');
                      } else {
                        Navigator.of(context, rootNavigator: true).push(new MaterialPageRoute(builder: (context) => SurveyView(judul: judul, deskripsi: deskripsi, id: id, jenis: jenis,)));
                      }
                    },
                    child: new Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: new HexColor("#F07B3F"),
                      ),
                      child: new Text('Mulai', style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ),
              ),),
          ],
        )
    );
  }
}
