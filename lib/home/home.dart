import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surveyqu/domain.dart';
import 'package:surveyqu/model/profile.dart';
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

  // List listNews;
  List<Pengumuman> listNews;
  List<Tutorial> listTutorial;
  List<Qscreen> listQscreen;
  List<Qsurvey> listQsurvey;
  List<Qgames> listQgames;
  List<Qnews> listQnews;
  List<Qpolling> listQpolling;
  List<NotifHome> listNotif;
  List<User> listUser;
  Timer timer;
  final currencyFormat = new NumberFormat.currency(locale: 'en', symbol: "Rp", decimalDigits: 0);

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

  // 1. pengumuman (Tanpa header )
  // 2. Tutuorial (Tanpa header )
  // 3. Q-screeen (Tanpa Header)
  // 4. Q-survey (Header)
  // 5. Q-polling (Header & Result)
  // 6. Q-games (Header)
  // 7. Q-news(Header & Detail)

  Future<void> getHome() async {
    this._getToken();
    var body = {
      "email": email
    };
    var res = await Network().postDataToken(body,'/contentHome');
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      var pengumuman = body['pengumuman'] as List;
      var tutorial = body['tutorial'] as List;
      var qsreen = body['qscreen'] as List;
      var qsurvey = body['qsurvey'] as List;
      var qgames = body['qgames'] as List;
      var qnews = body['qnews'] as List;
      var qpolling = body['qpolling'] as List;
      setState(() {
        listNews = pengumuman.map<Pengumuman>((json) => Pengumuman.fromJson(json)).toList();
        listTutorial = tutorial.map<Tutorial>((json) => Tutorial.fromJson(json)).toList();
        listQscreen = qsreen.map<Qscreen>((json) => Qscreen.fromJson(json)).toList();
        listQsurvey = qsurvey.map<Qsurvey>((json) => Qsurvey.fromJson(json)).toList();
        listQgames = qgames.map<Qgames>((json) => Qgames.fromJson(json)).toList();
        listQnews = qnews.map<Qnews>((json) => Qnews.fromJson(json)).toList();
        listQpolling = qpolling.map<Qpolling>((json) => Qpolling.fromJson(json)).toList();
      });
    } else {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.clear();
      Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
          new MaterialPageRoute(builder: (context) => Login()),
              (route) => false);
    }
  }

  // Future<List<Pengumuman>> getPengumuman() async {
  //   this._getToken();
  //   var body = {
  //     "jenis": 'p'
  //   };
  //   var res = await Network().postDataToken(body, '/pengumuman');
  //   if (res.statusCode == 200) {
  //     var body = jsonDecode(res.body);
  //     var dataJson = body['result'] as List;
  //     setState(() {
  //       listNews = dataJson.map<Pengumuman>((json) => Pengumuman.fromJson(json)).toList();
  //     });
  //   } else {
  //     SharedPreferences localStorage = await SharedPreferences.getInstance();
  //     localStorage.clear();
  //     Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
  //         new MaterialPageRoute(builder: (context) => Login()),
  //             (route) => false);
  //   }
  //   return listNews;
  // }

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

  // Future<List<Question>> getQuestion() async {
  //   var body = {
  //     "jenis": 'qc'
  //   };
  //   var res = await Network().postDataToken(body, '/question');
  //   if (res.statusCode == 200) {
  //     var body = jsonDecode(res.body);
  //     var dataJson = body['result'] as List;
  //     setState(() {
  //       listQna = dataJson.map<Question>((json) => Question.fromJson(json)).toList();
  //     });
  //   }
  //   return listQna;
  // }

  // Future<List<QSurvey>> getSurvey() async {
  //   var body = {
  //     "jenis": 'qt'
  //   };
  //   var res = await Network().postDataToken(body, '/question');
  //   if (res.statusCode == 200) {
  //     var body = jsonDecode(res.body);
  //     var dataJson = body['result'] as List;
  //     setState(() {
  //       listSurv = dataJson.map<QSurvey>((json) => QSurvey.fromJson(json)).toList();
  //     });
  //   }
  //   return listSurv;
  // }
  //
  // Future<List<Qnews>> getQnews() async {
  //   var body = {
  //     "jenis": 'qn'
  //   };
  //   var res = await Network().postDataToken(body, '/question');
  //   if (res.statusCode == 200) {
  //     var body = jsonDecode(res.body);
  //     var dataJson = body['result'] as List;
  //     setState(() {
  //       listQnews = dataJson.map<Qnews>((json) => Qnews.fromJson(json)).toList();
  //     });
  //   }
  //   return listQnews;
  // }

  Future<void> _onRefresh() {
    Completer<void> completer = new Completer<void>();
    timer = new Timer(new Duration(seconds: 2), () {
      this.getHome();
      // this.getPengumuman();
      this.getSqpoint();
      // this.getQuestion();
      // this.getQnews();
      // this.getSurvey();
      this.getNotif();
      completer.complete();
    });
    return completer.future;
  }

  @override
  void initState() {
    super.initState();
    this.getUser();
    this.getHome();
    // this.getPengumuman();
    this.getSqpoint();
    this.getNotif();
    // this.getQuestion();
    // this.getQnews();
    // this.getSurvey();
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
          child: listNews == null || listNews[0].status == '0'? new LoadingHome() : new SingleChildScrollView(
            child:  Column(
              children: <Widget>[
                new Container(
                  height: 180,
                  margin: EdgeInsets.only(top: 10),
                  child: new Swiper(
                    itemCount: listNews == null ? 0 : listNews.length,
                    viewportFraction: 0.8,
                    scale: 0.9,
                    autoplay: listNews[0].autoscroll == '1' ? true : false,
                    pagination: listNews.length == 1 ? null : new SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      builder: new DotSwiperPaginationBuilder(
                          color: Colors.grey, activeColor: new HexColor('#256fa0')),
                    ),
                    itemBuilder: (BuildContext context, int i) {
                      return AdvertisementCard(
                        gambar: listNews[i].gambar,
                        isi: listNews[i].isi,
                        onTap: (){
                          info.ShowDescriptionItem(context, listNews[i].judul, listNews[i].gambar, listNews[i].isi, listNews[i].url);
                        },
                      );
                    },
                  )
                ),
                listTutorial == null || listTutorial[0].status == '0' ? new Container() : new Container(
                    height: 300,
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: new Swiper(
                        itemCount: listTutorial == null ? 0 : listTutorial.length,
                        viewportFraction: 0.9,
                        scale: 0.9,
                        autoplay: listTutorial[0].autoscroll == '1' ? true : false,
                        pagination: listTutorial.length == 1 ? null : new SwiperPagination(
                          alignment: Alignment.bottomCenter,
                          builder: new DotSwiperPaginationBuilder(
                              color: Colors.grey, activeColor: new HexColor('#256fa0')),
                        ),
                        itemBuilder: (BuildContext context, int i) {

                          return SurveyCard(
                            gambar: listTutorial[i].gambar,
                            color: listTutorial[i].color,
                            id: listTutorial[i].id,
                            deskripsi: listTutorial[i].deskripsi,
                            judul: listTutorial[i].judul,
                            jenis: listTutorial[i].jenis,
                            quota: listTutorial[i].quota,
                            rewards: listTutorial[i].rewards,
                            totalquota: listTutorial[i].totalquota,
                            status_result: '0',
                            email: email,
                          );
                        }
                    )
                ),
                listQscreen == null || listQscreen[0].status == '0'? new Container() : new Container(
                    height: 300,
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: new Swiper(
                        itemCount: listQscreen == null ? 0 : listQscreen.length,
                        viewportFraction: 0.9,
                        scale: 0.9,
                        autoplay: listQscreen[0].autoscroll == '1' ? true : false,
                        pagination: listQscreen.length == 1 ? null : new SwiperPagination(
                          alignment: Alignment.bottomCenter,
                          builder: new DotSwiperPaginationBuilder(
                              color: Colors.grey, activeColor: new HexColor('#256fa0')),
                        ),
                        itemBuilder: (BuildContext context, int i) {

                          return SurveyCard(
                            gambar: listQscreen[i].gambar,
                            color: listQscreen[i].color,
                            id: listQscreen[i].id,
                            deskripsi: listQscreen[i].deskripsi,
                            judul: listQscreen[i].judul,
                            jenis: listQscreen[i].jenis,
                            quota: listQscreen[i].quota,
                            rewards: listQscreen[i].rewards,
                            totalquota: listQscreen[i].totalquota,
                            status_result: '0',
                            email: email,
                          );
                      }
                    )
                ),
                listQsurvey == null || listQsurvey[0].status == '0'? new Container() : new Container(
                    margin: EdgeInsets.only(left: 30, top: 10),
                    width: size.width,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        new Text(listQsurvey[0].header, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
                        new Text(listQsurvey[0].headerS, style: TextStyle(fontSize: 15),),
                      ],
                    )
                ),
                listQsurvey == null || listQsurvey[0].status == '0'? new Container() : new Container(
                    height: 300,
                    // width: 150,
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: new Swiper(
                      // shrinkWrap: true,
                      // scrollDirection: Axis.horizontal,
                        itemCount: listQsurvey == null ? 0 : listQsurvey.length,
                        viewportFraction: 0.9,
                        scale: 0.9,
                        autoplay: listQsurvey[0].autoscroll == '1' ? true : false,
                        pagination: listQsurvey.length == 1 ? null : new SwiperPagination(
                          alignment: Alignment.bottomCenter,
                          builder: new DotSwiperPaginationBuilder(
                              color: Colors.grey, activeColor: new HexColor('#256fa0')),
                        ),
                        itemBuilder: (BuildContext context, int i) {
                          return SurveyCard(
                            gambar: listQsurvey[i].gambar,
                            color: listQsurvey[i].color,
                            id: listQsurvey[i].id,
                            deskripsi: listQsurvey[i].deskripsi,
                            judul: listQsurvey[i].judul,
                            jenis: listQsurvey[i].jenis,
                            quota: listQsurvey[i].quota,
                            rewards: listQsurvey[i].rewards,
                            totalquota: listQsurvey[i].totalquota,
                            status_result: '0',
                            email: email
                          );
                        }
                  )
                ),
                listQpolling == null || listQpolling[0].status == '0' ? new Container() : new Container(
                    margin: EdgeInsets.only(left: 30, top: 10),
                    width: size.width,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        new Text(listQpolling[0].header, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
                        new Text(listQpolling[0].headerS, style: TextStyle(fontSize: 15),),
                      ],
                    )
                ),
                listQpolling == null || listQpolling[0].status == '0' ? new Container() : new Container(
                    height: 300,
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: new Swiper(
                        itemCount: listQpolling == null ? 0 : listQpolling.length,
                        viewportFraction: 0.9,
                        scale: 0.9,
                        autoplay: listQpolling[0].autoscroll == '1' ? true : false,
                        pagination: listQgames.length == 1 ? null :new SwiperPagination(
                          alignment: Alignment.bottomCenter,
                          builder: new DotSwiperPaginationBuilder(
                              color: Colors.grey, activeColor: new HexColor('#256fa0')),
                        ),
                        itemBuilder: (BuildContext context, int i) {
                          return SurveyCard(
                            gambar: listQpolling[i].gambar,
                            color: listQpolling[i].color,
                            id: listQpolling[i].id,
                            deskripsi: listQpolling[i].deskripsi,
                            judul: listQpolling[i].judul,
                            jenis: listQpolling[i].jenis,
                            quota: listQpolling[i].quota,
                            rewards: listQpolling[i].rewards,
                            totalquota: listQpolling[i].totalquota,
                            status_result: listQpolling[i].status_result,
                            email: email,
                          );
                        }
                    )
                ),
                listQgames == null || listQgames[0].status == '0'? new Container() : new Container(
                  margin: EdgeInsets.only(left: 30, top: 10),
                  width: size.width,
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Text(listQgames[0].header, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
                      new Text(listQgames[0].headerS, style: TextStyle(fontSize: 15),),
                    ],
                  )
                ),
                listQgames == null || listQgames[0].status == '0'? new Container() : new Container(
                    height: 180,
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: new Swiper(
                      itemCount: listQgames == null ? 0 : listQgames.length,
                      viewportFraction: 0.9,
                      scale: 0.9,
                      autoplay: listQgames[0].autoscroll == '1' ? true : false,
                      pagination: listQgames.length == 1 ? null : new SwiperPagination(
                        alignment: Alignment.bottomCenter,
                        builder: new DotSwiperPaginationBuilder(
                            color: Colors.grey, activeColor: new HexColor('#256fa0')),
                      ),
                      itemBuilder: (BuildContext context, int i) {
                        return SurveySlider(
                          gambar: listQgames[i].gambar,
                          color: listQgames[i].color,
                          id: listQgames[i].id,
                          deskripsi: listQgames[i].deskripsi,
                          judul: listQgames[i].judul,
                          jenis: listQgames[i].jenis,
                          // quota: listQgames[i].quota,
                        );
                      },
                    )
                ),
                listQnews == null || listQnews[0].status == '0'? new Container() : new Container(
                    margin: EdgeInsets.only(left: 30, top: 10),
                    width: size.width,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        new Text(listQnews[0].header, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
                        new Text(listQnews[0].headerS, style: TextStyle(fontSize: 15),),
                      ],
                    )
                ),
                listQnews == null || listQnews[0].status == '0'? new Container() : new Container(
                    height: 180,
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: new Swiper(
                      itemCount: listQnews == null ? 0 : listQnews.length,
                      viewportFraction: 0.9,
                      scale: 0.9,
                      autoplay: listQnews[0].autoscroll == '1' ? true : false,
                      pagination: listQnews.length == 1 ? null : new SwiperPagination(
                        alignment: Alignment.bottomCenter,
                        builder: new DotSwiperPaginationBuilder(
                            color: Colors.grey, activeColor: new HexColor('#256fa0')),
                      ),
                      itemBuilder: (BuildContext context, int i) {
                        return SurveySlider(
                          gambar: listQnews[i].gambar,
                          color: listQnews[i].color,
                          id: listQnews[i].id,
                          deskripsi: listQnews[i].deskripsi,
                          judul: listQnews[i].judul,
                          jenis: listQnews[i].jenis,
                          // quota: listQnews[i].quota,
                        );
                      },
                    )
                ),
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
      expandedHeight: 60,
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