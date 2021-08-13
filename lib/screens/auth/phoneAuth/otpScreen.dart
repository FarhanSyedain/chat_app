import 'dart:js';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_app/components/customProceedButton.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/screens/auth/phoneAuth/components/form.dart';
import 'package:chat_app/screens/auth/phoneAuth/components/topBar.dart';
import 'package:chat_app/screens/auth/profile/components/CustomFormArea.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'dart:async';
import '../../../components/dilog/awsomeDilog.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'util/verfiyPhoneNumber.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;
  OTPScreen(this.phoneNumber);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  int timeLeft = 60;
  int previousTimeLeft = 60;
  Timer? resendTimer;
  bool showSpiner = false;
  String? _verificationCode;

  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    resendTimer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        setState(() {
          timeLeft--;
        });
        if (timeLeft == 0) {
          timer.cancel();
        }
      },
    );
    super.initState();
  }

  void changeVal(v) {
    setState(() {
      showSpiner = v;
    });
  }

  @override
  void dispose() {
    resendTimer?.cancel();
    // textEditingController.dispose();
    // errorController?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LoadingOverlay(
        isLoading: showSpiner,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TopBar(widget.phoneNumber),
              SizedBox(height: 30),
              CustomForm(widget.phoneNumber, _verificationCode!,changeVal),
              Center(
                child: TextButton(
                  onPressed: () {
                    if (timeLeft > 0) {
                      return;
                    }
                    verifyPhoneNumber(widget.phoneNumber, context, (v) {
                      setState(() {
                        _verificationCode = v;
                      });
                    });
                    setState(() {
                      timeLeft = previousTimeLeft * 2;
                      previousTimeLeft = timeLeft;
                    });
                    resendTimer = Timer.periodic(
                      Duration(seconds: 1),
                      (timer) {
                        setState(
                          () {
                            timeLeft--;
                          },
                        );
                      },
                    );
                  },
                  child: Text(
                    timeLeft == 0 ? 'Resend Code' : 'Resend Code ($timeLeft s)',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
