import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;
import 'package:liquid_swipe/liquid_swipe.dart';
import 'dart:async';
import 'dart:convert';

import 'package:surveyqu/domain.dart';
import 'package:surveyqu/hexacolor.dart';
import 'package:surveyqu/loading.dart';

import '../loading.dart';
import 'login.dart';

class SliderInfo extends StatefulWidget {
  _SliderInfo createState() => _SliderInfo();
}

class _SliderInfo extends State<SliderInfo> {

  Size size;
  String message;
  var dataJson;
  Domain domain = new Domain();
  int page = 0;
  LiquidController liquidController;
  UpdateType updateType;

  Future<void> getData() async {

    String url = domain.getDomain()+"auth/content";
    var headers = {
      //'content-type': 'application/json',
      'Client-Service' : domain.getHeaderClient(),
      'Auth-Key' : domain.getHeaderAuth()
    };
    http.Response hasil = await http.post(url, headers: headers);
    if (200 == hasil.statusCode) {
      if(this.mounted) {
        dataJson = jsonDecode(hasil.body);
      }
      setState(() {
        message = dataJson['result'][0]['img'] == null ? '1' : dataJson['result'][0]['img'];
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    liquidController = LiquidController();
    this.getData();
  }

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((page ?? 0) - index).abs(),
      ),
    );
    double zoom = 1.0 + (2.0 - 1.0) * selectedness;
    return new Container(
      width: 25.0,
      child: new Center(
        child: new Material(
          color: Colors.white,
          type: MaterialType.circle,
          child: new Container(
            width: 8.0 * zoom,
            height: 8.0 * zoom,
          ),
        ),
      ),
    );
  }

  final Color = [
    Colors.red,
    Colors.green,
    Colors.blue
  ];

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Container(
        child: message == null ? new Container(
          alignment: Alignment.center,
          child: new LoadingLogo(),
        ) :
        new Stack(
          children: <Widget>[
            LiquidSwipe.builder(
              itemCount: 3,
              itemBuilder: (context, i){
                return new Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/banner.png'),
                        fit: BoxFit.cover,
                      )
                  ),
                  child: Container(
                    margin: EdgeInsets.only(top: 50, bottom: 80, left: 20,right: 20),
                    width: size.width,
                    // color: Color[i],
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white.withOpacity(.8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Container(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          height: 150,
                          child: Image.asset(
                            'images/logo.png',
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        new Container(
                          padding: EdgeInsets.only(left: 20,right: 20),
                          height: 200,
                          child:Image.network(
                            dataJson['result'][i]['img'],
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        new Container(
                          padding: EdgeInsets.only(top: 20),
                          child: Column(
                            children: <Widget>[
                              // Text(
                              //   dataJson['result'][i]['img'],
                              //   // style: WithPages.style,
                              // ),
                              new Container(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Text(
                                    dataJson['result'][i]['judul'], style: TextStyle(color: new HexColor('#2670A1'),fontWeight: FontWeight.w600, fontSize: 17), textAlign: TextAlign.center,
                                  // style: WithPages.style,
                                ),
                              ),
                              new Container(
                                padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                                child: Text(
                                    dataJson['result'][i]['konten'], style: TextStyle(color: new HexColor('#2670A1')), textAlign: TextAlign.justify,
                                  // style: WithPages.style,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              positionSlideIcon: 0.8,
              // slideIconWidget: Icon(Icons.arrow_back_ios),
              onPageChangeCallback: pageChangeCallback,
              waveType: WaveType.circularReveal,
              liquidController: liquidController,
              ignoreUserGestureWhileAnimating: true,
              enableLoop: false,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 42),
              child: Column(
                children: <Widget>[
                  Expanded(child: SizedBox()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(3, _buildDot),
                  ),
                ],
              ),
            ),
            liquidController.currentPage == 2 ? new Container()
                :
            new Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(27.0),
                child: FlatButton(
                  onPressed: () {
                    liquidController.animateToPage(
                        page: 3 - 1, duration: 200);
                  },
                  child: Text("Lewati", style: TextStyle(color: Colors.white)),
                  color: Colors.white.withOpacity(0.01),
                ),
              ),
            ),

            liquidController.currentPage == 2 ? Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(27.0),
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (context) => new Login()), (route) => false);
                  },
                  child: Text("Masuk", style: TextStyle(color: Colors.white)),
                  color: Colors.white.withOpacity(0.01),
                ),
              ),
            ) : Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(27.0),
                child: FlatButton(
                  onPressed: () {
                    liquidController.jumpToPage(
                        page:
                        liquidController.currentPage + 1 > 3 - 1
                            ? 0
                            : liquidController.currentPage + 1);
                  },
                  child: Text("Selanjutnya", style: TextStyle(color: Colors.white),),
                  color: Colors.white.withOpacity(0.01),
                ),
              ),
            )
          ],
        ),
    );
  }

  pageChangeCallback(int lpage) {
    setState(() {
      page = lpage;
    });
  }
}