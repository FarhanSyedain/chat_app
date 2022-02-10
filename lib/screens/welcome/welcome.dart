import 'package:chat_app/animations/animations.dart';
import 'package:chat_app/screens/auth/login/login.dart';
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
    // var brightness = MediaQuery.of(context).platformBrightness;
    // // final isDarkMode = brightness == Brightness.dark;
    var titleStyle = const TextStyle(
      fontSize: 20,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
    const isDarkMode = true;
    return Container(
      child: IntroductionScreen(
        globalBackgroundColor: Theme.of(context).backgroundColor,
        done: SizedBox(
          height: 60,
          child: const RotatedBox(
            child: Icon(
              Icons.arrow_back_ios,
              size: 30,
              color: Colors.blue,
            ),
            quarterTurns: 2,
          ),
        ),
        onDone: () {
          Navigator.push(
            context,
            PageTransition(
              child: LoginScreen(),
              type: PageTransitionType.fromRight,
            ),
          );
        },
        next: SizedBox(
          height: 60,
          child: const RotatedBox(
            child: Icon(
              Icons.arrow_back_ios,
              size: 30,
              color: Colors.blue,
            ),
            quarterTurns: 2,
          ),
        ),
        pages: [
          PageViewModel(
            decoration: PageDecoration(
              titleTextStyle: titleStyle,
              pageColor:
                  isDarkMode ? Theme.of(context).backgroundColor : Colors.white,
              imagePadding: const EdgeInsets.only(top: 50),
            ),
            title: "Welcome to Spark",
            body: "A brand new way to connect with people you care about.",
            image: SvgPicture.asset(
              "assets/vectors/people.svg",
            ),
          ),
          PageViewModel(
            decoration: PageDecoration(
              titleTextStyle: titleStyle,
              pageColor:
                  isDarkMode ? Theme.of(context).backgroundColor : Colors.white,
              imagePadding: const EdgeInsets.only(top: 50),
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
              titleTextStyle: titleStyle,
              pageColor:
                  isDarkMode ? Theme.of(context).backgroundColor : Colors.white,
              imagePadding: const EdgeInsets.only(top: 50),
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
