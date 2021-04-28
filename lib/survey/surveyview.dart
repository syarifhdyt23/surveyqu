import 'package:flutter/material.dart';
import 'package:surveyqu/hexacolor.dart';
import 'package:surveyqu/survey/surveydetail.dart';

class SurveyView extends StatefulWidget {
  @override
  _SurveyViewState createState() => _SurveyViewState();
}

class _SurveyViewState extends State<SurveyView> {
  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: new Text("Survey Detail"),
      ),
      body: new ListView(
        children: [
          new Container(
            decoration: BoxDecoration(
              color: new HexColor('#256fa0'),
              borderRadius: BorderRadius.circular(10)
            ),
            margin: EdgeInsets.only(top: 10,left: 10,right: 10, bottom: 10),
            child: new Container(
              margin: EdgeInsets.only(top: 10,left: 10,right: 10, bottom: 10),
              child: new Column(
                children: [
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Text("Judul Survey", style: TextStyle(color: Colors.white),),
                      new Text("Studi 1", style: TextStyle(color: Colors.white),),
                    ],
                  ),
                  new Padding(padding: EdgeInsets.all(5)),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Text("Jumlah Survey", style: TextStyle(color: Colors.white),),
                      new Text("3", style: TextStyle(color: Colors.white),),
                    ],
                  )
                ],
              ),
            )
          ),
          new Container(
              decoration: BoxDecoration(
                  color: new HexColor('#256fa0'),
                  borderRadius: BorderRadius.circular(10)
              ),
              margin: EdgeInsets.only(top: 10,left: 10,right: 10, bottom: 10),
              child: new Container(
                margin: EdgeInsets.only(top: 10,left: 10,right: 10, bottom: 10),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Text("Deskripsi Survey", style: TextStyle(color: Colors.white),),
                    new Padding(padding: EdgeInsets.all(5)),
                    new Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's "
                        "standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a "
                        "type specimen book", style: TextStyle(color: Colors.white,), textAlign: TextAlign.justify,),
                  ],
                ),
              )
          ),
          new Container(
            height: size.height - 310,
            child: new ListView.builder(
              shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, i){
                  return new InkWell(
                    onTap: (){
                      Navigator.of(context).push(new MaterialPageRoute(builder: (context) => SurveyDetail()));
                    },
                    child: new Container(
                        decoration: BoxDecoration(
                            color: new HexColor('#256fa0'),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        margin: EdgeInsets.only(top: 10,left: 10,right: 10, bottom: 10),
                        child: new ListTile(
                          title: new Text("Judul Survey", style: TextStyle(color: Colors.white),),
                          subtitle: new Text("Judul Survey", style: TextStyle(color: Colors.white),),
                          trailing: new Icon(Icons.arrow_forward_ios, color: Colors.white,),
                        )
                    ),
                  );
                }
                ),
          )
        ],
      ),
    );
  }
}
