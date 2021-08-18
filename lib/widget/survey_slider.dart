import 'package:flutter/material.dart';
import 'package:surveyqu/hexacolor.dart';
import 'package:surveyqu/info.dart';
import 'package:surveyqu/survey/surveyview.dart';

class SurveySlider extends StatelessWidget {
  Info info = new Info();
  Size size;
  final String color,judul,deskripsi,gambar, id, jenis, quota;

  SurveySlider({Key key, this.color, this.judul, this.deskripsi, this.gambar, this.id, this.jenis, this.quota}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: (){
          if(quota == '0'){
            info.MessageInfo(context, 'info','Survey sudah memenuhi kuota');
          } else {
            Navigator.of(context, rootNavigator: true).push(new MaterialPageRoute(builder: (context) => SurveyView(judul: judul, deskripsi: deskripsi, id: id, jenis: jenis,)));
          }
        },
        child: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            image: DecorationImage(
              image: NetworkImage(gambar),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(1, 2), // changes position of shadow
              ),
            ],
          ),
          child: Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(judul, style: TextStyle(fontWeight: FontWeight.w600),),
          ),
        )
    );
  }
}
