import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:surveyqu/domain.dart';
import 'package:surveyqu/login/login.dart';
import 'package:http/http.dart' as http;
import 'package:surveyqu/model/slidercontent.dart';
import '../model/slidercontent.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen({Key key}) : super(key: key);

  @override
  IntroScreenState createState() => new IntroScreenState();
}
class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = new List();
  List<Slidercontent> _content;
  Domain domain = new Domain();
  Function goToTab;
  var dataJson;

  Future<List<Slidercontent>> getContent() async {
    String url = domain.getDomain()+"auth/content";
    var headers = {
      //'content-type': 'application/json',
      'Client-Service' : domain.getHeaderClient(),
      'Auth-Key' : domain.getHeaderAuth()
    };
    try {
      http.Response hasil = await http.post(url, headers: headers);
      if (200 == hasil.statusCode) {
        dataJson = jsonDecode(hasil.body);
        for (var i = 0; i < 3; i++) {
          slides.add(
            new Slide(
              title: dataJson['result'][i]['urutan'],
              styleTitle: TextStyle(
                color: Colors.blue,
                fontSize: 30.0,),
              description:
              dataJson['result'][i]['konten'],
              styleDescription: TextStyle(
                color: Colors.lightBlue,
                fontSize: 20.0,),
              pathImage: dataJson['result'][i]['img'],
            ),
          );
        }
        // _content = slidercontentFromJson(hasil.body) as List<Slidercontent>;
        // final children = <Widget>[];
        // return _content;
      }
      // else {
      //   return List<Slidercontent>();
      // }
    } catch (e) {
      return List<Slidercontent>();
    }
  }

  // Future getContent() async {
  //   String url = domain.getDomain()+"auth/content";
  //   var headers = {
  //     //'content-type': 'application/json',
  //     'Client-Service' : domain.getHeaderClient(),
  //     'Auth-Key' : domain.getHeaderAuth()
  //   };
  //   http.Response hasil = await http.post(url, headers: headers);
  //   final jsonData = json.decode(hasil.body);
  //   slides = List<dynamic>.from(slides.map((jsonData) => slides.add(jsonData)));
  //   // slides = Content as List;
  // }

  @override
  void dispose() {
    super.dispose();
    // bring the status bar back
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  @override
  void initState() {
    super.initState();
    getContent();

  //   slides.add(
  //     new Slide(
  //       title: 'slider 1',
  //       styleTitle: TextStyle(
  //           color: Colors.blue,
  //           fontSize: 30.0,),
  //       description:
  //       "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa.",
  //       styleDescription: TextStyle(
  //           color: Colors.lightBlue,
  //           fontSize: 20.0,),
  //       pathImage: "images/slide1.png",
  //     ),
  //   );
  }

  Future<void> onDonePress() async {
    // Back to the first tab\
    Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (context) => Login()), (route) => false);
    // Navigator.of(context, rootNavigator: false).push(new MaterialPageRoute(builder: (context) => Login()),
    // );
  }

  void onTabChangeCompleted(index) {
    // Index of current tab is focused
  }

  Widget renderNextBtn() {
    return new Text("Next", style: TextStyle(color: Colors.blue),);
    //   Icon(
    //   Icons.navigate_next,
    //   color: Color(0xffffcc5c),
    //   size: 35.0,
    // );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: Colors.blue,
    );
  }

  Widget renderSkipBtn() {
    return new Text("Skip", style: TextStyle(color: Colors.blue),);
    //   Icon(
    //   Icons.skip_next,
    //   color: Color(0xffffcc5c),
    // );
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = new List();
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          margin: EdgeInsets.only(bottom: 60.0, top: 50.0),
          child: ListView(
            children: <Widget>[
              Container(
                child: Image.asset(
                  'images/logo.png',
                  width: 200.0,
                  height: 200.0,
                  fit: BoxFit.contain,
                ),
                margin: EdgeInsets.only(top: 20.0, left: 10, right: 10),
              ),
              GestureDetector(
                  child: Image.network(
                    currentSlide.pathImage,
                    width: 200.0,
                    height: 200.0,
                    fit: BoxFit.contain,
                  )),
              Container(
                child: Text(
                  currentSlide.title,
                  style: currentSlide.styleTitle,
                  textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.only(top: 20.0, left: 10, right: 10),
              ),
              Container(
                child: Text(
                  currentSlide.description,
                  style: currentSlide.styleDescription,
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
                margin: EdgeInsets.only(top: 20.0, left: 10, right: 10),
              ),
            ],
          ),
        ),
      ));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      // List slides
      slides: this.slides,
      // Skip button
      renderSkipBtn: this.renderSkipBtn(),
      // colorSkipBtn: Colors.blue,
      // highlightColorSkipBtn: Colors.white,
      // Next button
      renderNextBtn: this.renderNextBtn(),
      // Done button
      renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onDonePress,
      // colorDoneBtn: Color(0x33ffcc5c),
      // highlightColorDoneBtn: Color(0xffffcc5c),
      // Dot indicator
      colorDot: Colors.blue,
      sizeDot: 13.0,
      typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,
      // Tabs
      listCustomTabs: this.renderListCustomTabs(),
      backgroundColorAllSlides: Colors.white,
      refFuncGoToTab: (refFunc) {
        this.goToTab = refFunc;
      },
      // Behavior
      scrollPhysics: BouncingScrollPhysics(),
      // Show or hide status bar
      shouldHideStatusBar: true,
      // On tab change completed
      onTabChangeCompleted: this.onTabChangeCompleted,
    );
  }
}