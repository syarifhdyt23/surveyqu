import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:surveyqu/domain.dart';
import 'dart:async';
import 'dart:convert';
import 'package:surveyqu/info.dart';
import 'package:surveyqu/loading.dart';
import 'package:surveyqu/model/home.dart';
import 'package:surveyqu/survey/surveyview.dart';
import 'package:url_launcher/url_launcher.dart';
import '../hexacolor.dart';
import '../network_utils/api.dart';

class Home extends StatefulWidget {
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  Info info = new Info();
  Size size;
  Domain domain = new Domain();
  bool _visible = false;
  var token, id, sqpoint, nama;
  String message;
  List<Pengumuman> listNews;
  List<Advertising> listAds;
  List<Question> listQna;
  List<QSurvey> listSurv;
  Timer timer;

  Future<void> openURL(BuildContext context, String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      info.MessageInfo(context, 'Message', "Please install this apps");
    }
  }

  Future<List<Pengumuman>> getPengumuman() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      sqpoint = jsonDecode(localStorage.getString('sqpoint'));
      nama = jsonDecode(localStorage.getString('nama'));
    });
    var body = {
      "jenis": 'p'
    };
    var res = await Network().postDataToken(body, '/pengumuman');
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      var dataJson = body['result'] as List;
      setState(() {
        listNews = dataJson.map<Pengumuman>((json) => Pengumuman.fromJson(json)).toList();
      });
    } else {
      info.messagesNoButton(context, 'info','Gagal Masuk');
    }
    return listNews;
  }

  Future<List<Advertising>> getAds() async {
    var body = {
      "jenis": 'a'
    };
    var res = await Network().postDataToken(body, '/pengumuman');
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      var dataJson = body['result'] as List;
      setState(() {
        listAds = dataJson.map<Advertising>((json) => Advertising.fromJson(json)).toList();
      });
    } else {
      info.messagesNoButton(context, 'info','Gagal Masuk');
    }
    return listAds;
  }

  Future<List<Question>> getQuestion() async {
    var body = {
      "jenis": 'qc'
    };
    var res = await Network().postDataToken(body, '/question');
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      var dataJson = body['result'] as List;
      setState(() {
        listQna = dataJson.map<Question>((json) => Question.fromJson(json)).toList();
      });
    } else {
      info.messagesNoButton(context, 'info','Gagal Masuk');
    }
    return listQna;
  }

  Future<List<QSurvey>> getSurvey() async {
    var body = {
      "jenis": 'qt'
    };
    var res = await Network().postDataToken(body, '/question');
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      var dataJson = body['result'] as List;
      setState(() {
        listSurv = dataJson.map<QSurvey>((json) => QSurvey.fromJson(json)).toList();
      });
    } else {
      info.messagesNoButton(context, 'info','Gagal Masuk');
    }
    return listSurv;
  }

  Future<void> _onRefresh() {
    Completer<void> completer = new Completer<void>();
    timer = new Timer(new Duration(seconds: 2), () {
      this.getPengumuman();
      this.getQuestion();
      completer.complete();
    });
    return completer.future;
  }

  @override
  void initState() {
    super.initState();
    this.getPengumuman();
    this.getQuestion();
    this.getAds();
    this.getSurvey();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
          return <Widget>[
            appbarWidget(),
            imageWidget(),
            pointWidget()
          ];
        },
        body: new RefreshIndicator(
          onRefresh: _onRefresh,
          child: listNews == null ? new LoadingHome() : new SingleChildScrollView(
            child:  Column(
              children: <Widget>[
                new Container(
                    height: 160,
                    margin: EdgeInsets.only(top: 10),
                    child: new Swiper(
                      itemCount: listNews == null ? 0 : listNews.length,
                      viewportFraction: 0.8,
                      scale: 0.9,
                      autoplay: true,
                      pagination: new SwiperPagination(),
                      itemBuilder: (BuildContext context, int i) {
                        return new InkWell(
                          onTap: (){
                            this.openURL(context, listNews[i].url);
                          },
                          child: new Container(
                            alignment: Alignment.topCenter,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                image: DecorationImage(
                                  image: NetworkImage(listNews[i].gambar),
                                  fit: BoxFit.cover,
                                )
                            ),
                            child: new Container(
                              margin: EdgeInsets.only(top: 10),
                              child: new Text(listNews[i].isi, style: TextStyle(fontWeight: FontWeight.w600),),
                            ),
                          )
                        );
                      },
                    )
                ),
                listQna == null ? new Container() : new ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.only(top: 10,bottom: 10),
                  shrinkWrap: true,
                  itemCount: listQna == null ? 0 : listQna.length,
                  itemBuilder: (context, i){
                    return Container(
                        margin: EdgeInsets.only(bottom: 10, left: 35, right: 35, top: 20),
                        width: size.width,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: new HexColor(listQna[i].color),
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
                                      child: new Text(listQna[i].judul, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20,)),
                                    ),
                                    subtitle: new Container(
                                      margin: EdgeInsets.only(top: 20),
                                      child: new Text(listQna[i].deskripsi, style: TextStyle(color: Colors.white)),
                                    ),
                                    trailing: new Container(
                                      width: 100,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(listQna[i].gambar),
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
                                      Navigator.of(context, rootNavigator: true).push(new MaterialPageRoute(builder: (context) => SurveyView(judul: listQna[i].judul, deskripsi: listQna[i].deskripsi, id: listQna[i].id, jenis: 'qc',)));
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
                  }),
                listAds == null ? new Container() :
                new Container(
                    height: 160,
                    margin: EdgeInsets.only(top: 10),
                    child: new Swiper(
                      itemCount: listAds == null ? 0 : listAds.length,
                      viewportFraction: 0.8,
                      scale: 0.9,
                      autoplay: true,
                      pagination: new SwiperPagination(),
                      itemBuilder: (BuildContext context, int i) {
                        return new InkWell(
                            onTap: (){
                          this.openURL(context, listAds[i].url);
                        },
                        child: new Container(
                          alignment: Alignment.topCenter,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              image: DecorationImage(
                                image: NetworkImage(listAds[i].gambar),
                                fit: BoxFit.cover,
                              )
                          ),
                          child: new Container(
                            margin: EdgeInsets.only(top: 10),
                            child: new Text(listAds[i].isi, style: TextStyle(fontWeight: FontWeight.w600),),
                          ),
                        ));
                      },
                    )
                ),
                listSurv == null ? new Container() : new ListView.builder(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(top: 10,bottom: 10),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: listSurv == null ? 0 : listSurv.length,
                    itemBuilder: (context, i){
                      return Container(
                            margin: EdgeInsets.only(bottom: 10, left: 35, right: 35, top: 20),
                            width: size.width,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: new HexColor(listSurv[i].color),
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
                                        child: new Text(listSurv[i].judul, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20,)),
                                      ),
                                      subtitle: new Container(
                                        margin: EdgeInsets.only(top: 20),
                                        child: new Text(listSurv[i].deskripsi, style: TextStyle(color: Colors.white)),
                                      ),
                                      trailing: new Container(
                                        width: 100,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(listQna[i].gambar),
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
                                          Navigator.of(context, rootNavigator: true).push(new MaterialPageRoute(builder: (context) => SurveyView(judul: listSurv[i].judul, deskripsi: listSurv[i].deskripsi, id: listSurv[i].id, jenis: 'qt',)));
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
                    }),
              ]
            )
          )
        )
      )
    );
  }

  SliverAppBar imageWidget() {
    return SliverAppBar(
      backgroundColor: new HexColor('#2670A1'),
      expandedHeight: 100,
      elevation: 0,
      flexibleSpace: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
          background: Container(
            decoration: BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage('images/bannerlandscape.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: new Stack(
              children: [
                new Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(bottom: 10),
                  child: new Text(
                    "Hai $nama, Selamat Datang",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )
                )
              ],
            )
          ),
        );
      }),
    );
  }

  SliverAppBar appbarWidget() {
    return SliverAppBar(
      // backgroundColor: new HexColor('#256fa0'),
      pinned: true,
      expandedHeight: 80,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(left: 20,bottom: 15),
        title: new Container(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              new Text("SurveyQu",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  )),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  new InkWell(
                    onTap: (){

                    },
                    child:new Container(
                      margin: const EdgeInsets.only(right: 10.0,),
                      child: new Icon(
                        Icons.search,
                        color: Colors.white,
                        size: kToolbarHeight - 30,
                      ),
                    ),
                  ),
                  new InkWell(
                    onTap: (){

                    },
                    child: new Container(
                      margin: const EdgeInsets.only(right: 15.0,),
                      child: new Icon(
                        Icons.notifications,
                        color: Colors.white,
                        size: kToolbarHeight - 30,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ),
    );
  }

  SliverAppBar profileWidget() {
    return SliverAppBar(
      // pinned: false,
      backgroundColor: Colors.transparent,
      floating: true,
      expandedHeight: 100,
      elevation: 0,
      title: SizedBox(
          child: new Positioned(
            bottom: 10,
              child: new Text(
                "Hi Faisal, Selamat Datang",
                style: TextStyle(color: Colors.black),
              )
          )
      ),
    );
  }

  SliverAppBar pointWidget() {
    size = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.white,
      pinned: false,
      expandedHeight: 68,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
          titlePadding: EdgeInsets.all(0),
          title: new Container(
            height: 70,
            child: new Stack(
              children: [
                new Container(
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          new HexColor('#2e7eb3'),
                          new HexColor('#2670A1'),
                        ],
                      ),
                    // color: new HexColor('#2670A1'),
                  ),
                ),
                new Container(
                  height: size.height,
                  padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                  child: new Card(
                    elevation: 3,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Expanded(
                          flex: 1,
                          child: new Container(
                            child: new Row(
                              children: [
                                new Container(
                                    margin: const EdgeInsets.only(
                                      left: 10,
                                    ),
                                    child: new Icon(Icons.account_balance_wallet_outlined)),
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    new Container(
                                      margin: const EdgeInsets.only(left: 10, right: 10),
                                      child: new Text(
                                        'Reward',
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        style: new TextStyle(
                                          fontFamily: "helvetica,bold",
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        maxLines: 1,
                                      ),
                                    ),
                                    new Container(
                                      margin: const EdgeInsets.only(
                                        left: 10,
                                      ),
                                      child: new Text(
                                        'Rp, 0',
                                        style: new TextStyle(
                                            fontFamily: "helvetica, bold",
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        new Expanded(
                          flex: 1,
                          child: new Container(
                            child: new Row(
                              children: [
                                new Container(
                                    child: new Icon(Icons.payment_outlined)),
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    new Container(
                                      margin: const EdgeInsets.only(left: 10, right: 10),
                                      child: new Text(
                                        'Poin',
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        style: new TextStyle(
                                          fontFamily: "helvetica,bold",
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        maxLines: 1,
                                      ),
                                    ),
                                    new Container(
                                      margin: const EdgeInsets.only(
                                        left: 10,
                                      ),
                                      child: new Text(
                                        sqpoint == null ? '0 Poin' : sqpoint +' Poin',
                                        style: new TextStyle(
                                            fontFamily: "helvetica, bold",
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ),
      ),
    );
  }
}