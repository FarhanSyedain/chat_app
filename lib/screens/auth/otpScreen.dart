import 'package:chat_app/components/customProceedButton.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/screens/auth/components/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pinPutController = TextEditingController();
  final pinPutDecoration = BoxDecoration(
    color: Colors.grey,
    // borderRadius: BorderRadius.circular(20.0),

    border: Border(
      bottom: BorderSide(
        color: Colors.grey,
      ),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: kDarkCardColor,
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: kDarkCardColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(40),
                  bottomLeft: Radius.circular(40),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    'assets/vectors/otpScreen.svg',
                    height: MediaQuery.of(context).size.height / 3,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Enter OTP',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  CustomTextField('OTP', 'Enter the otp', (v) {}),
                  SizedBox(
                    height: 30,
                  ),
                  CustomProceedButton('Verify'),
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: Text('Resend Code'),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
