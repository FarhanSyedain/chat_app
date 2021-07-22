import 'dart:async';

import 'package:chat_app/components/customProceedButton.dart';
import 'package:chat_app/screens/auth/components/customAppbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ConfirmEmailScreen extends StatefulWidget {
  @override
  _ConfirmEmailScreenState createState() => _ConfirmEmailScreenState();
}

class _ConfirmEmailScreenState extends State<ConfirmEmailScreen> {
  final _user = FirebaseAuth.instance.currentUser;
  var timer;
  @override
  void initState() {
    _user?.sendEmailVerification();
    timer = Timer.periodic(
      Duration(seconds: 5),
      (_) {
        checkIfVerified();
      },
    );
    super.initState();
  }

  Future<void> sign() async {
    FirebaseAuth.instance.signOut();
  }

  Future<void> checkIfVerified() async {
    final user = FirebaseAuth.instance.currentUser;
    await user?.reload();

    final emailVerified = user?.emailVerified;
    if (emailVerified == null) {
      return;
      //Stupid null saftey
    }
    if (emailVerified) {
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: buildAppBar(context, title: 'Verify Email', back: () {
        FirebaseAuth.instance.signOut();
        Navigator.pop(context);
      }),
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
                'We\'ve sent you a verification link on your email. Please open the link to complete the setup of your account',
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
            CustomProceedButton('Resend Email')
          ],
        ),
      ),
    );
  }
}
