import 'package:flutter/material.dart';
import 'package:flutter_tutorial_onboard/onboarding_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Onboarding tutorial"),),
      body: Center(
        child: Container(
          child: MaterialButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => OnboardingPage())),
            child: Text("Open Onboarding Screen"),
            color: Colors.green,
            textColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
