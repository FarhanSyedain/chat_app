import 'dart:async';

import 'package:android_intent/android_intent.dart';
import 'package:android_intent/flag.dart';
import 'package:chat_app/components/background.dart';
import 'package:chat_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/components/customProceedButton.dart';
import '/screens/auth/components/customAppbar.dart';
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

  void openDefaultMail() {
    AndroidIntent intent = AndroidIntent(
      action: 'android.intent.action.MAIN',
      category: 'android.intent.category.APP_EMAIL',
      flags: [Flag.FLAG_ACTIVITY_NEW_TASK],
    );
    intent.launch();
  }

  @override
  void initState() {
    _user?.sendEmailVerification().catchError((e) {});
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        checkIfVerified();
      },
    );
    timeLeftTimer = Timer.periodic(
      const Duration(seconds: 1),
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
        '/wrapper',
        (route) => false,
      );
    }
  }

  @override
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
    });
    timeLeft = previousTimeLeft * 3;
    previousTimeLeft = timeLeft;
    timeLeftTimer = Timer.periodic(
      const Duration(seconds: 1),
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
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: buildAppBar(
        context,
        title: 'Verify Email',
        showBackButton: false,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      backgroundColor: Theme.of(context).cardColor,
                      title: const Text('Logout ?'),
                      actions: [
                        TextButton(
                          child: const Text('No'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                          ),
                          child: Text(
                            'Yes',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Provider.of<AuthService>(context, listen: false)
                                .signOut();
                          },
                        ),
                      ],
                    );
                  });
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: BackgroundWrapper(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/vectors/emailSent.svg',
                  height: 300,
                ),
                const Center(
                  child: Text(
                    'Verification link sent',
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Sans',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    'We\'ve sent you a verification link on your email $emailAdress.',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                      fontFamily: 'Sans',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: deviceHeight * .10),
                GestureDetector(
                  child: CustomProceedButton('Open Mail'),
                  onTap: () {
                    openDefaultMail();
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: sendingEmail
                              ? 'Sending..'
                              : timeLeft == 0
                                  ? 'Resend email'
                                  : 'Resend email ($timeLeft s)',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              if (timeLeft != 0 || sendingEmail) {
                                return;
                              }
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
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.blue),
                        ),
                      ],
                    ),
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    SharedPreferences.getInstance().then((value) {
      value.clear();
    });
    Navigator.pushReplacementNamed(context, '/wrapper');
  }
}
