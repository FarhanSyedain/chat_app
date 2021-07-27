import 'package:chat_app/components/customProceedButton.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  Widget build(BuildContext context) {
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
                SizedBox(height: 30),
                OTPTextField(
                  length: 6,
                  width: MediaQuery.of(context).size.width - 40,
                  fieldWidth: 40,
                  style: TextStyle(fontSize: 17),
                  otpFieldStyle: OtpFieldStyle(
                      borderColor: Colors.grey,
                      enabledBorderColor: Colors.grey),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldStyle: FieldStyle.underline,
                  onCompleted: (pin) {
                    print("Completed: " + pin);
                  },
                ),
                SizedBox(
                  height: 40,
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
    );
  }
}
