import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surveyqu/domain.dart';
import 'package:surveyqu/model/profile.dart';
import 'package:surveyqu/survey/surveydetail.dart';
import 'package:surveyqu/survey/surveyview.dart';
import 'package:surveyqu/widget/advertisement_card.dart';
import 'package:surveyqu/home/notif.dart';
import 'package:surveyqu/widget/survey_card.dart';
import 'dart:async';
import 'dart:convert';
import 'package:surveyqu/info.dart';
import 'package:surveyqu/loading.dart';
import 'package:surveyqu/login/login.dart';
import 'package:surveyqu/model/home.dart';
import 'package:surveyqu/widget/survey_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../hexacolor.dart';
import '../network_utils/api.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  Info info = new Info();
  Size size;
  Domain domain = new Domain();
  bool _visible = false;
  var token, sqpoint, sqreward, nama, email;
  String message, notif;
  List<Pengumuman> listNews;
  List<Qnews> listQnews;
  List<Advertising> listAds;
  List<Question> listQna;
  List<QSurvey> listSurv;
  List<NotifHome> listNotif;
  List<User> listUser;
  Timer timer;
  final currencyFormat = new NumberFormat.currency(locale: 'en', symbol: "Rp", decimalDigits: 0);

  Future<void> openURL(BuildContext context, String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      info.MessageInfo(context, 'Message', "Please install this apps");
    }
  }

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token'));
    email = jsonDecode(localStorage.getString('email'));
  }

  Future<void> getUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    email = jsonDecode(localStorage.getString('email'));
    var data = {
      'email': email,
    };
    var res = await Network().postDataToken(data, '/loadProfile');
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      var dataJson = body['result'];
      setState(() {
        nama = dataJson[0]['firstname'] == null ? "" : dataJson[0]['firstname'];
      });
    }
    return listUser;
  }

  Future<void> getSqpoint() async {
    await _getToken();
    var body = {
      "email": email
    };
    var res = await Network().postDataToken(body, '/riwayatSaldo');
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      sqpoint = body['total'] == null ? '0' : body['total']['sqpoint'];
      sqreward = body['reward'] == null ? '0' : body['reward']['sqrewards'];
    }
    return sqpoint;
  }

  // Future<List<HomeContent>> getHome() async {
  //   this._getToken();
  //   var res = await Network().postToken('/contentHome');
  //   if (res.statusCode == 200) {
  //     var body = jsonDecode(res.body);
  //     var dataJson = body['result'] as List;
  //     setState(() {
  //       listHome = dataJson.map<HomeContent>((json) => HomeContent.fromJson(json)).toList();
  //     });
  //   } else {
  //     SharedPreferences localStorage = await SharedPreferences.getInstance();
  //     localStorage.clear();
  //     Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
  //         new MaterialPageRoute(builder: (context) => Login()),
  //             (route) => false);
  //   }
  //   return listHome;
  // }

  Future<List<Pengumuman>> getPengumuman() async {
    this._getToken();
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
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.clear();
      Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
          new MaterialPageRoute(builder: (context) => Login()),
              (route) => false);
    }
    return listNews;
  }

  Future<void> getNotif() async {
    await this._getToken();
    var body = {
      "email": email
    };
    http.Response res = await Network().postDataToken(body,'/notifBeranda');
    if(this.mounted) {
      if (res.statusCode == 200) {
        setState(() {
          var body = jsonDecode(res.body);
          notif = body['stat_notif'] == null ? '1' : body['stat_notif'];
        });
      } else {
        setState(() {
          notif = "1";
        });
      }
    }
  }

  // Future<List<Advertising>> getAds() async {
  //   var body = {
  //     "jenis": 'a'
  //   };
  //   var res = await Network().postDataToken(body, '/pengumuman');
  //   if (res.statusCode == 200) {
  //     var body = jsonDecode(res.body);
  //     var dataJson = body['result'] as List;
  //     setState(() {
  //       listAds = dataJson.map<Advertising>((json) => Advertising.fromJson(json)).toList();
  //     });
  //   }
  //   return listAds;
  // }

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
    }
    return listSurv;
  }

  Future<List<Qnews>> getQnews() async {
    var body = {
      "jenis": 'qn'
    };
    var res = await Network().postDataToken(body, '/question');
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      var dataJson = body['result'] as List;
      setState(() {
        listQnews = dataJson.map<Qnews>((json) => Qnews.fromJson(json)).toList();
      });
    }
    return listQnews;
  }

  Future<void> _onRefresh() {
    Completer<void> completer = new Completer<void>();
    timer = new Timer(new Duration(seconds: 2), () {
      this.getPengumuman();
      this.getSqpoint();
      this.getQuestion();
      this.getQnews();
      this.getSurvey();
      this.getNotif();
      completer.complete();
    });
    return completer.future;
  }

  @override
  void initState() {
    super.initState();
    this.getUser();
    this.getPengumuman();
    this.getSqpoint();
    this.getNotif();
    this.getQuestion();
    this.getQnews();
    this.getSurvey();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: new Text('surveyQu'),
        actions: [
          // new InkWell(
          //   onTap: (){
          //   },
          //   child:new Container(
          //     margin: const EdgeInsets.only(right: 10.0,),
          //     child: new Icon(
          //       Icons.search,
          //       color: Colors.white,
          //       size: kToolbarHeight - 30,
          //     ),
          //   ),
          // ),
          new InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: (){
              Navigator.of(context, rootNavigator: true).push(new MaterialPageRoute(builder: (context) => new NotifPage()));
            },
            child: new Container(
              margin: const EdgeInsets.only(right: 15.0,),
              child: notif == null || notif == '1' ?
              new Icon(Icons.notifications  ,)
                  :
              new Badge(
                elevation: 0,
                position: BadgePosition.topEnd(top: 15, end: 2),
                child: new Icon(
                  Icons.notifications,
                  color: Colors.white,
                  size: kToolbarHeight - 30,
                ),
              )
            ),
          ),
        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
          return <Widget>[
            // appbarWidget(),
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
                  height: 180,
                  margin: EdgeInsets.only(top: 10),
                  child: new Swiper(
                    itemCount: listNews == null ? 0 : listNews.length,
                    viewportFraction: 0.8,
                    scale: 0.9,
                    autoplay: true,
                    pagination: new SwiperPagination(),
                    itemBuilder: (BuildContext context, int i) {
                      return AdvertisementCard(
                        gambar: listNews[i].gambar,
                        isi: listNews[i].isi,
                        onTap: (){
                          openURL(context, listNews[i].url);
                        },
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
                    return SurveyCard(
                      gambar: listQna[i].gambar,
                      color: listQna[i].color,
                      id: listQna[i].id,
                      deskripsi: listQna[i].deskripsi,
                      judul: listQna[i].judul,
                      jenis: 'qc',
                    );
                  }),
                // listAds == null ? new Container() :
                // new Container(
                //     height: 180,
                //     margin: EdgeInsets.only(top: 10),
                //     child: new Swiper(
                //       itemCount: listAds == null ? 0 : listAds.length,
                //       viewportFraction: 0.8,
                //       scale: 0.9,
                //       autoplay: true,
                //       pagination: new SwiperPagination(),
                //       itemBuilder: (BuildContext context, int i) {
                //         return AdvertisementCard(
                //           gambar: listAds[i].gambar,
                //           isi: listAds[i].isi,
                //           onTap: (){
                //             openURL(context, listAds[i].url);
                //           },
                //         );
                //       },
                //     )
                // ),
                listSurv == null ? new Container() : new ListView.builder(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(top: 10,bottom: 10),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: listSurv == null ? 0 : listSurv.length,
                    itemBuilder: (context, i){
                      return SurveyCard(
                        gambar: listSurv[i].gambar,
                        color: listSurv[i].color,
                        id: listSurv[i].id,
                        deskripsi: listSurv[i].deskripsi,
                        judul: listSurv[i].judul,
                        jenis: 'qt',
                      );
                    }),
                InkWell(
                    child: Container(
                      height: 180,
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.only(left: 25,right: 25,top: 20,bottom: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                          image: AssetImage('images/qnews.jpeg'),
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
                      // child: Container(
                      //   margin: EdgeInsets.only(top: 10),
                      //   child: Text('Qnews', style: TextStyle(fontWeight: FontWeight.w600),),
                      // ),
                    )
                ),
                listQnews == null ? new Container() : new Container(
                    height: 180,
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: new Swiper(
                      itemCount: listQnews == null ? 0 : listQnews.length,
                      viewportFraction: 0.9,
                      scale: 0.9,
                      autoplay: true,
                      pagination: new SwiperPagination(),
                      itemBuilder: (BuildContext context, int i) {
                        return SurveySlider(
                          gambar: listQnews[i].gambar,
                          color: listQnews[i].color,
                          id: listQnews[i].id,
                          deskripsi: listQnews[i].deskripsi,
                          judul: listQnews[i].judul,
                          jenis: 'qn',
                        );
                      },
                    )
                ),
                // InkWell(
                //   onTap: (){
                //     Navigator.of(context, rootNavigator: true).push(new MaterialPageRoute(builder: (context) => SurveyView(id: '1',jenis: 'qn',judul: 'QNEWS',deskripsi: "Qnews berita",)));
                //   },
                //     child: Container(
                //       height: 180,
                //       alignment: Alignment.topCenter,
                //       margin: EdgeInsets.all(20),
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.all(Radius.circular(10)),
                //         image: DecorationImage(
                //           image: AssetImage('images/bannerlandscape.png'),
                //           fit: BoxFit.cover,
                //         ),
                //         boxShadow: [
                //           BoxShadow(
                //             color: Colors.grey.withOpacity(0.5),
                //             spreadRadius: 2,
                //             blurRadius: 4,
                //             offset: Offset(1, 2), // changes position of shadow
                //           ),
                //         ],
                //       ),
                //       child: Container(
                //         margin: EdgeInsets.only(top: 10),
                //         child: Text('dummy banner', style: TextStyle(fontWeight: FontWeight.w600),),
                //       ),
                //     )
                // ),
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
                    "Hai "+(nama == null ? '' : nama)+", Selamat Datang",
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
              new Text("surveyQu",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  )),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // new InkWell(
                  //   onTap: (){
                  //
                  //   },
                  //   child:new Container(
                  //     margin: const EdgeInsets.only(right: 10.0,),
                  //     child: new Icon(
                  //       Icons.search,
                  //       color: Colors.white,
                  //       size: kToolbarHeight - 30,
                  //     ),
                  //   ),
                  // ),
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
      expandedHeight: 100,
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
                                        sqreward == '0' || sqreward == null ? "Rp.0" : currencyFormat.format(int.parse(sqreward)),
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
                                        'Q-Score',
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
                                        sqpoint == null ? '0' : sqpoint,
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
                ),
              ],
            )
          ),
      ),
    );
  }
}