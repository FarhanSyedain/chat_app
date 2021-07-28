import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_app/components/customProceedButton.dart';
import 'package:chat_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:async';

import 'package:pin_code_fields/pin_code_fields.dart';

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
  String? _verificationCode;
  bool showSpiner = false;
  bool pinGiven = false;
  String? pin;
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  bool hasError = false;

  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
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
      phoneNumber: widget.phoneNumber,
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
          title: widget.phoneNumber,
          desc: 'OTP sent successfully.',
        ).show();
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
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
                        text: widget.phoneNumber,
                        style: Theme.of(context).textTheme.bodyText2,
                        children: [
                          WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(
                                Icons.edit,
                                size: 20,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.color,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  otp(),
                  SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    child: CustomProceedButton(
                      'Verify',
                      disabled: !pinGiven,
                    ),
                    onTap: pinGiven ? verifyUser : () {},
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
                      child: TextButton(
                        onPressed: () => _verifyPhoneNumber(),
                        child: Text(
                          timeLeft == 0
                              ? 'Resend Code'
                              : 'Resend Code ($timeLeft s)',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> reSendCode() async {}

  Future<void> verifyUser() async {
    // if (pin?.length != 6) {
    //   errorController!
    //       .add(ErrorAnimationType.shake); // Triggering error shake animation
    //   setState(
    //     () => hasError = true,
    //   );
    // } else {

    setState(() {
      showSpiner = true;
    });
    try {
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
      errorController!.add(
        ErrorAnimationType.shake,
      ); // Triggering error shake animation
      setState(
        () => hasError = true,
      );
    }

    setState(
      () {
        showSpiner = false;
      },
    );
  }

  Widget otp() {
    return Form(
      // key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
        child: PinCodeTextField(
          appContext: context,
          pastedTextStyle: TextStyle(
            color: Colors.green.shade600,
            fontWeight: FontWeight.bold,
          ),
          length: 6,
          animationType: AnimationType.fade,
          validator: (v) {
            if (hasError) {
              return "Invalid OTP";
            }
            if (v!.length < 6) {
              return 'OTP must be 6 didgits long';
            }
          },
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.underline,
            borderRadius: BorderRadius.circular(5),
            selectedFillColor: Colors.transparent,
            inactiveFillColor: Colors.transparent,
            fieldHeight: 50,
            fieldWidth: 40,
            selectedColor: Colors.green,
            inactiveColor: kDarkCardColor,
            borderWidth: 3,
            errorBorderColor: Colors.red,
          ),
          cursorColor: Colors.black,
          animationDuration: Duration(milliseconds: 300),
          enableActiveFill: true,
          errorAnimationController: errorController,
          controller: textEditingController,
          keyboardType: TextInputType.number,
          boxShadows: [
            BoxShadow(
              offset: Offset(0, 1),
              color: Colors.black12,
              blurRadius: 10,
            )
          ],
          onCompleted: (v) {
            setState(() {
              pinGiven = true;
            });
          },
          onChanged: (value) {
            print(value);
            setState(() {
              hasError = false;
              pinGiven = false;
              pin = value;
            });
          },
          beforeTextPaste: (text) {
            return true;
          },
        ),
      ),
    );
  }
}
