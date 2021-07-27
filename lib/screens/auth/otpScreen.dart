import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_app/components/customProceedButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:async';

class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  int timeLeft = 60;
  int previousTimeLeft = 60;
  Timer? resendTimer;
  String? _verificationCode;
  bool showSpiner = false;
  bool pinGiven = false;
  String? pin;
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
    _verifyPhoneNumber();
    super.initState();
  }

  Future<void> _verifyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+911111221122',
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {},
      verificationFailed: (FirebaseAuthException e) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          title: 'Error',
          desc: e.message,
        ).show();
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationCode = verificationId;

        AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          title: '+911111221122',
          desc: 'OTP sent successfully.',
        ).show();
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.currentUser);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          SvgPicture.asset(
            'assets/vectors/phoneAuth.svg',
            height: MediaQuery.of(context).size.height / 3,
          ),
          SizedBox(height: 20),
          Text(
            'Verify OTP',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  child: Text.rich(
                    TextSpan(
                      text: '9596342946',
                      style: Theme.of(context).textTheme.bodyText2,
                      children: [
                        WidgetSpan(
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Icon(
                              Icons.edit,
                              size: 20,
                              color:
                                  Theme.of(context).textTheme.bodyText1?.color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                OTPTextField(
                  keyboardType: TextInputType.number,
                  length: 6,
                  width: MediaQuery.of(context).size.width - 40,
                  fieldWidth: 40,
                  style: TextStyle(fontSize: 17),
                  otpFieldStyle: OtpFieldStyle(
                    borderColor: Colors.grey,
                    enabledBorderColor: Colors.grey,
                  ),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldStyle: FieldStyle.underline,
                  onChanged: (v) {
                    print('I am getting called');
                    print(v.length);
                    if (v.length == 6) {
                      setState(
                        () {
                          pin = v;
                          pinGiven = true;
                        },
                      );
                    } else {
                      setState(
                        () {
                          pin = '';
                          pinGiven = false;
                        },
                      );
                    }
                  },
                  onCompleted: (v) {},
                ),
                SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  child: CustomProceedButton(
                    'Verify',
                    disabled: !pinGiven,
                  ),
                  onTap: pinGiven ? verifyUser : verifyUser,
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      if (timeLeft == 0)
                        reSendCode().then(
                          (value) {
                            setState(
                              () {
                                timeLeft = previousTimeLeft * 2;
                                previousTimeLeft = timeLeft;
                              },
                            );
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
                          },
                        );
                    },
                    child: Text(
                      timeLeft == 0
                          ? 'Resend Code'
                          : 'Resend Code ($timeLeft s)',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> reSendCode() async {}

  Future<void> verifyUser() async {
    print(pin);
    FocusScope.of(context).unfocus();
    print('I am atlest getting exculted');
    try {
      setState(() {
        showSpiner = true;
      });
      print('I am atlest getting exculted 2 $pin');

      await FirebaseAuth.instance
          .signInWithCredential(
            PhoneAuthProvider.credential(
              verificationId: _verificationCode!,
              smsCode: pin!,
            ),
          )
          .then(
            (value) => print('Successfull'),
          );
      print('Hello');
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/wrapper',
        (route) => false,
      );
    } catch (e) {
      print('Threr is an error actually');
      print(e);
    }

    setState(
      () {
        showSpiner = false;
      },
    );
  }
}
