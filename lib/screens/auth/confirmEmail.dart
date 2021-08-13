import 'dart:async';

import 'package:chat_app/components/customProceedButton.dart';
import 'package:chat_app/screens/auth/components/customAppbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ConfirmEmailScreen extends StatefulWidget {
  @override
  _ConfirmEmailScreenState createState() => _ConfirmEmailScreenState();
}

class _ConfirmEmailScreenState extends State<ConfirmEmailScreen> {
  final _user = FirebaseAuth.instance.currentUser;
  var timer;
  int timeLeft = 60;
  int previousTimeLeft = 60;
  bool sendingEmail = false;
  String? emailAdress = '';
  Timer? timeLeftTimer;
  @override
  void initState() {
    _user?.sendEmailVerification().catchError((e) {
      print(e);
    });
    timer = Timer.periodic(
      Duration(seconds: 5),
      (_) {
        checkIfVerified();
      },
    );
    timeLeftTimer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        setState(() {
          timeLeft--;
          if (timeLeft == 0) {
            timer.cancel();
          }
        });
      },
    );
    emailAdress = _user?.email;
    super.initState();
  }

  Future<void> checkIfVerified() async {
    final user = FirebaseAuth.instance.currentUser;
    await user?.reload();

    final emailVerified = user?.emailVerified;

    if (emailVerified!) {
      timer.cancel();
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home',
        (route) => false,
      );
    }
  }

  void dispose() {
    timer.cancel();
    timeLeftTimer?.cancel();
    super.dispose();
  }

  Future<void> resendVerificationEmail() async {
    if (timeLeft > 0) {
      return;
    }
    await _user?.sendEmailVerification().catchError((e) {
      //Too many requests sent
      print(e);
    });
    timeLeft = previousTimeLeft * 3;
    previousTimeLeft = timeLeft;
    timeLeftTimer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        setState(() {
          timeLeft--;
          if (timeLeft == 0) {
            timer.cancel();
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: buildAppBar(
        context,
        title: 'Verify Email',
        showBackButton: false,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/vectors/emailSent.svg',
              height: 400,
            ),
            Center(
              child: Text(
                'Verification link sent',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                'We\'ve sent you a verification link on your email $emailAdress. Please open the link to complete the setup of your account',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.white54,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            sendingEmail
                ? CustomProceedButton('Sending Email.')
                : GestureDetector(
                    child: CustomProceedButton(
                      timeLeft == 0
                          ? 'Resend Email'
                          : 'Resend Email (in $timeLeft s)',
                    ),
                    onTap: () async {
                      setState(() {
                        sendingEmail = true;
                      });
                      await resendVerificationEmail();
                      setState(
                        () {
                          sendingEmail = false;
                        },
                      );
                    },
                  ),
            SizedBox(
              height: 13,
            ),
            Center(
              child: Text.rich(
                TextSpan(
                  text: 'Clicked the link?  ',
                  children: [
                    TextSpan(
                      text: 'Refresh page',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => checkIfVerified(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                  style: TextStyle(
                    color: Colors.white60,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(child: Container()),
            Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Sign out',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => signOut(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: Colors.blue),
                    ),
                  ],
                  text: '',
                ),
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/wrapper');
  }

}
