import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/animated_focus_light.dart';
import 'package:tutorial_coach_mark/content_target.dart';
import 'package:tutorial_coach_mark/target_focus.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  List<TargetFocus> targets = List();
  GlobalKey imageKey = GlobalKey();
  GlobalKey redBoxKey = GlobalKey();
  GlobalKey blueBoxKey = GlobalKey();
  
  @override
  void initState() {
    targets.addAll([
      TargetFocus(
          radius: 0,
          color: Colors.green,
          shape: ShapeLightFocus.RRect,
          identify: "Image",
          keyTarget: imageKey,
          contents: [
            ContentTarget(
                align: AlignContent.top,
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "This is image",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          "This is a new showcase for image",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ))
          ]),
      TargetFocus(
          radius: 40,
          color: Colors.red,
          shape: ShapeLightFocus.Circle,
          identify: "RedBox",
          keyTarget: redBoxKey,
          contents: [
            ContentTarget(
                align: AlignContent.bottom,
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Icon(Icons.touch_app_outlined, color: Colors.white,),
                          Text(
                            "Tap the RedBox",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20.0),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          "This is a new showcase for greenbox",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ))
          ]),
      TargetFocus(
          radius: 40,
          color: Colors.blue,
          shape: ShapeLightFocus.Circle,
          identify: "BlueBox",
          keyTarget: blueBoxKey,
          contents: [
            ContentTarget(
                align: AlignContent.left,
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "This is Blue Box",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          "This is a new showcase for blue box",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ))
          ]),
    ]);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showTutorial();
    });
  }

  void showTutorial() {
    TutorialCoachMark(context, targets: targets)..show();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<LayoutChangedNotification>(
      onNotification: (notification){
        print(notification.runtimeType);
        return true;
      },
      child: Scaffold(
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
                          offset: Offset(-2,1),
                          color: Colors.red.withOpacity(0.4),
                          spreadRadius: 1,
                          blurRadius: 10
                        )
                      ]
                    ),
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
                              offset: Offset(-2,1),
                              color: Colors.blue.withOpacity(0.8),
                              spreadRadius: 1,
                              blurRadius: 10
                          )
                        ]
                    ),
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Image.network(
                "https://images.pexels.com/photos/4785054/pexels-photo-4785054.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260",
                width: 160,
                height: 160,
                fit: BoxFit.contain,
                key: imageKey,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
