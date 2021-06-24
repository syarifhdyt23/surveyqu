import 'package:flutter/material.dart';
import 'package:surveyqu/hexacolor.dart';

class NotifPage extends StatefulWidget {
  @override
  _NotifPageState createState() => _NotifPageState();
}

class _NotifPageState extends State<NotifPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: new Text("Notifikasi"),
      ),
      body: new Container(
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            appBar: TabBar(
              // isScrollable: true,
              unselectedLabelColor: Colors.black.withOpacity(0.5),
              indicatorColor: new HexColor('#256fa0'),
              tabs: [
                new Container(
                  alignment: Alignment.center,
                  child: Text("Notifikasi", style: TextStyle(color: Colors.black),),
                ),
                new Container(
                  alignment: Alignment.center,
                  child: Text("Histori",style: TextStyle(color: Colors.black),),
                ),
              ],
            ),
            body: new TabBarView(
              // physics: NeverScrollableScrollPhysics(),
              children: [
                new ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, i){
                    return new Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 10),
                      decoration: BoxDecoration(
                        color: new HexColor('#256fa0'),
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
                        leading: new Icon(Icons.notification_important, size: 40, color: Colors.white,),
                        title: new Text("Title",style: TextStyle(color: Colors.white),),
                        subtitle: new Text("Subtitle",style: TextStyle(color: Colors.white),),
                      ),
                    );
                }),
                new ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, i){
                      return new Container(
                        margin: EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
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
                          leading: new Icon(Icons.notification_important, size: 40, color: new HexColor('#256fa0'),),
                          title: new Text("Title",style: TextStyle(color: new HexColor('#256fa0')),),
                          subtitle: new Text("Subtitle",style: TextStyle(color: new HexColor('#256fa0')),),
                        ),
                      );
                    }),
                ],
              ),
          ),
        ),
      ),
    );
  }
}
