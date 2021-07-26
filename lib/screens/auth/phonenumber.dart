import 'package:chat_app/components/customProceedButton.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/screens/auth/components/customAppbar.dart';
import 'package:chat_app/screens/auth/components/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class PhoneNumberScreen extends StatefulWidget {
  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
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
                    'assets/vectors/phoneAuth.svg',
                    height: MediaQuery.of(context).size.height / 3,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  CustomTextField(
                    'Phone Number',
                    'Enter a valid phone number',
                    (v) {
                      if (v == null) {
                        return null;
                      }
                      return v.length == 10
                          ? null
                          : 'Please enter a valid phone number';
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomProceedButton('Get OTP'),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Use Email instead?'),
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
}
