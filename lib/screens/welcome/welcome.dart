import 'package:chat_app/screens/auth/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        done: Text("Sign up"), // todo: put CustomProceedButton here

        onDone: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => RegisterScreen()));
        },
        next: Text("Next"), // todo: put CustomProceedButton here

        pages: [
          PageViewModel(
            title: "Welcome to Spark",
            body: "A brand new way to connect with people you care about.",
            image: SvgPicture.asset(
              "vectors/people.svg",
            ),
          ),
          PageViewModel(
            title: "Hybrid Voice Texting",
            body:
                "Make your online communication more personal using voice texting",
            image: SvgPicture.asset(
              "vectors/voice.svg",
            ),
          ),
          PageViewModel(
            title: "Get started",
            body: "It's free and easy",
          ),
        ],
      ),
    );
  }
}
