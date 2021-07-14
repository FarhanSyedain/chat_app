import 'package:chat_app/constants.dart';
import 'package:chat_app/screens/auth/components/customProceedButton.dart';
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
  final isDarkMode = ThemeMode.system == ThemeMode.dark;
  Widget build(BuildContext context) {
    return Container(
      child: IntroductionScreen(
        color: isDarkMode ? kDarkBackgroundColor: kDarkBackgroundColor,
        done: CustomProceedButton(
          "Sign up",
        ), // todo: put CustomProceedButton here

        onDone: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => RegisterScreen()));
        },
        // showNextButton: false,

        next: CustomProceedButton("Next"), // todo: put CustomProceedButton here
        pages: [
          PageViewModel(
            decoration: PageDecoration(
              imagePadding: EdgeInsets.only(top: 50),
            ),
            title: "Welcome to Spark",
            body: "A brand new way to connect with people you care about.",
            image: SvgPicture.asset(
              "assets/vectors/people.svg",
            ),
          ),
          PageViewModel(
            decoration: PageDecoration(
              imagePadding: EdgeInsets.only(top: 50),
            ),
            title: "Hybrid Voice Texting",
            body:
                "Make your online communication more personal using voice texting",
            image: SvgPicture.asset(
              "assets/vectors/voice.svg",
            ),
          ),
          PageViewModel(
            decoration: PageDecoration(
              imagePadding: EdgeInsets.only(top: 50),
            ),
            image: SvgPicture.asset('assets/vectors/getStarted.svg'),
            title: "Get started",
            body: "It's free and easy",
          ),
        ],
      ),
    );
  }
}
