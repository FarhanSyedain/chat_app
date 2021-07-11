import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: IntroductionScreen(
        pages: [
          PageViewModel(
            title: "Welcome to Spark",
            body: "A brand new way to connect with people you care about.",
          )
        ],
      ),
    );
  }
}
