import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/animated_focus_light.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  //I have defined some widgets to show the tutorial on.
  //Now we'll add package
  // We need to define some global key for the widgets we want to show tutorial on.
  GlobalKey redBoxKey = GlobalKey();
  GlobalKey blueBoxKey = GlobalKey();
  GlobalKey helloTextKey = GlobalKey();
  GlobalKey gitImageKey = GlobalKey();

  //We need to define target focus for what to show on tutorial
  List<TargetFocus> targetList = List();


  @override
  void initState() {
    //Added keys of target widgets to show the contents on
    targetList.addAll([
      //now to add contents to show
      TargetFocus(
          keyTarget: redBoxKey,
          color: Colors.red, //can add any color as per our liking
          contents: [
            ContentTarget(
                align: AlignContent
                    .bottom, //to align the contents on bottom of the widget
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    children: [
                      //this takes widgets so you can use any widget you want
                      Text(
                        "This is red box",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "This box has color red and has some text!!",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ))
          ]),
      TargetFocus(keyTarget: blueBoxKey, color: Colors.blue, contents: [
        ContentTarget(
            align:
                AlignContent.left, //to align the contents on left of the widget
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                children: [
                  //this takes widgets so you can use any widget you want
                  Text(
                    "This is blue box",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "This box has color blue and has some text!!",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ))
      ]),
      TargetFocus(
          keyTarget: helloTextKey,
          shape: ShapeLightFocus.RRect, //can choose between these two shapes
          radius: 0, //and define radius for the shape
          contents: [
            ContentTarget(
                align: AlignContent
                    .bottom, //to align the contents on bottom of the widget
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    children: [
                      //this takes widgets so you can use any widget you want
                      Text(
                        "This is red box",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "This box has color red and has some text!!",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ))
          ]),
      TargetFocus(keyTarget: gitImageKey, contents: [])
    ]);
    super.initState();
    //now to start the widget automatically when the widgets render


    isFirstTime().then((firstTime){
      if(firstTime) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          TutorialCoachMark(context, targets: targetList, onClickSkip: () {
            //we can use these callbacks to define what to do on Skipping, clicking the target
            // and finishing the tutorial
            print("Skipped");

            //call this function if you dont want to show after the first time
            setFirstTime();
          }, onClickTarget: (target) {
            //print(target);
          }, onFinish: () {
            print("Finished");
            //you can save the finished state to sharedpreference to not show this again.
            //call this function if you dont want to show after the first time
            setFirstTime();
          })
            ..show();
        });
      }
    });

    //dont directly call this function on initstate . It will cause errors because the
    //required widgets wont have been loaded till. This function will call only after
    // the widgets are rendered.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  key: redBoxKey,
                  height: 80,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(-2, 1),
                            color: Colors.red.withOpacity(0.4),
                            spreadRadius: 1,
                            blurRadius: 10)
                      ]),
                  child: Center(
                      child: Text(
                    "Red Box",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  )),
                ),
                Container(
                  key: blueBoxKey,
                  height: 80,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(-2, 1),
                            color: Colors.blue.withOpacity(0.8),
                            spreadRadius: 1,
                            blurRadius: 10)
                      ]),
                  child: Center(
                      child: Text(
                    "Blue Box",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  )),
                ),
              ],
            ),
            Text(
              "Hello! Username",
              key: helloTextKey,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            InkWell(
              //we dont need this function now
              child: Image.network(
                "https://cdn0.iconfinder.com/data/icons/octicons/1024/mark-github-512.png",
                width: 160,
                height: 160,
                fit: BoxFit.contain,
                key: gitImageKey,
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<bool> isFirstTime() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("firstTime")??true;
  }

  void setFirstTime() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("firstTime", false);

  }
}
