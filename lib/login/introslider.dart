import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:surveyqu/domain.dart';
import 'package:surveyqu/login/login.dart';
import 'package:http/http.dart' as http;
import 'package:surveyqu/model/slidercontent.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen({Key key}) : super(key: key);

  @override
  IntroScreenState createState() => new IntroScreenState();
}
class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = new List();
  Domain domain = new Domain();
  var dataJson;
  Function goToTab;

  Future getContent() async {
    String url = domain.getDomain()+"auth/content";
    var headers = {
      //'content-type': 'application/json',
      'Client-Service' : domain.getHeaderClient(),
      'Auth-Key' : domain.getHeaderAuth()
    };
    http.Response hasil = await http.post(url, headers: headers);
    this.setState(() {
      dataJson = jsonDecode(hasil.body);
      SliderContent content = new SliderContent.fromJson(dataJson);
      slides = content.content as List<Slide>;
    });
  }

  @override
  void initState() {
    super.initState();
    this.getContent();

    slides.add(
      new Slide(
        title: 'Slide 1',
        styleTitle: TextStyle(
            color: Colors.blue,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa.",
        styleDescription: TextStyle(
            color: Colors.lightBlue,
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "images/slide1.png",
      ),
    );
    slides.add(
      new Slide(
        title: 'Slide 2',
        styleTitle: TextStyle(
            color: Colors.blue,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
        "Ye indulgence unreserved connection alteration appearance",
        styleDescription: TextStyle(
            color: Colors.lightBlue,
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "images/slide2.png",
      ),
    );
    slides.add(
      new Slide(
        title: 'Slide 3',
        styleTitle: TextStyle(
            color: Colors.blue,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
        "Much evil soon high in hope do view. Out may few northward believing attempted. Yet timed being songs marry one defer men our. Although finished blessing do of",
        styleDescription: TextStyle(
            color: Colors.lightBlue,
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "images/slide3.png",
      ),
    );
  }

  void onDonePress() {
    // Back to the first tab
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
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
                  child: Image.asset(
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