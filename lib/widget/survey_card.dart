import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:surveyqu/hexacolor.dart';
import 'package:surveyqu/info.dart';
import 'package:surveyqu/survey/surveydetail.dart';
import 'package:surveyqu/survey/surveyview.dart';

class SurveyCardProgress extends StatelessWidget {
  Info info = new Info();
  Size size;
  final String color,judul,deskripsi,gambar, id, jenis, quota, totalquota, email, urutan;

  SurveyCardProgress({Key key, this.color, this.judul, this.deskripsi, this.gambar, this.id, this.jenis, this.quota, this.totalquota, this.urutan, this.email}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var percentage = int.parse(quota) / int.parse(totalquota) * 100;
    var _percentage = percentage / 100;
    return Container(
        margin: EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 20),
        // width: size.width,
        height: 300,
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
                flex:3,
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
                  contentPadding: EdgeInsets.only(top: 15, left: 15,right: 15),
                  title: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          new CircularPercentIndicator(
                            radius: 50.0,
                            animation: true,
                            animationDuration: 1000,
                            lineWidth: 8.0,
                            percent: _percentage,
                            // startAngle: double.parse(quota),
                            circularStrokeCap: CircularStrokeCap.round,
                            backgroundColor: Colors.yellow,
                            progressColor: Colors.red,
                          ),
                          new Container(
                            height: 50,
                            padding: EdgeInsets.only(left: 10, top: 5),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                new Text(
                                  "$quota / $totalquota",
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15),
                                ),
                                new Text(
                                  'Polling Terjawab',
                                  style: TextStyle(color: Colors.black, fontSize: 15),
                                ),
                              ],
                            )
                          )
                        ],
                      ),
                      new InkWell(
                        onTap: (){
                          if(quota == '0'){
                            info.MessageInfo(context, 'info','Survey sudah memenuhi kuota');
                          } else {
                            if(jenis == 'qpl' || jenis == 'sc'){
                              Navigator.of(context, rootNavigator: true).push(new MaterialPageRoute(builder: (context) => SurveyDetail(id: id, jenis: jenis, urutanSoal: urutan, email: email,)));
                            } else {
                              Navigator.of(context, rootNavigator: true).push(new MaterialPageRoute(builder: (context) => SurveyView(judul: judul, deskripsi: deskripsi, id: id, jenis: jenis,)));
                            }
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
                    ],
                  ),
                  subtitle: new Column(
                    children: [
                      new Divider(),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    ],
                  )
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
  final String color,judul,deskripsi,gambar, id, jenis, quota, urutan, email;

  SurveyCardLeft({Key key, this.color, this.judul, this.deskripsi, this.gambar, this.id, this.jenis, this.quota, this.urutan, this.email}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 20),
        // width: size.width,
        height: 220,
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
                        if(jenis == 'qpl' || jenis == 'sc'){
                          Navigator.of(context, rootNavigator: true).push(new MaterialPageRoute(builder: (context) => SurveyDetail(id: id, jenis: jenis, urutanSoal: urutan, email: email,)));
                        } else {
                          Navigator.of(context, rootNavigator: true).push(new MaterialPageRoute(builder: (context) => SurveyView(judul: judul, deskripsi: deskripsi, id: id, jenis: jenis,)));
                        }
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
