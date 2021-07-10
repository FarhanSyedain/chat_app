import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'customProceedButton.dart';
import 'socialMediaLoginButton.dart';
import 'customTextField.dart';

class RegisterScreenBody extends StatefulWidget {
  @override
  _RegisterScreenBodyState createState() => _RegisterScreenBodyState();
}

class _RegisterScreenBodyState extends State<RegisterScreenBody> {
  var withPhoneNumber = false;

  void changeRegisterField() {
    setState(() {
      withPhoneNumber = !withPhoneNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 60),
          Text(
            'Sign up with any of the below options.',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SocialMediaLoginButton('Google'),
              SocialMediaLoginButton('Github'),
            ],
          ),

          Center(
            child: Padding(
              padding: EdgeInsets.all(25),
              child: Text.rich(
                TextSpan(
                    text: withPhoneNumber
                        ? 'Use email instead'
                        : 'Use phone number instead.',
                    recognizer: TapGestureRecognizer()
                      ..onTap = changeRegisterField),
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    ?.copyWith(fontSize: 14),
              ),
            ),
          ),

          withPhoneNumber
              ? CustomTextField('Phone Number', 'Enter your phone number')
              : Column(
                  children: [
                    CustomTextField('Email', 'Enter your email'),
                    SizedBox(height: 20),
                    CustomTextField('Password', 'Set a passowrd'),
                    SizedBox(height: 20),
                    CustomTextField(
                        'Confirm Password', 'Confirm your password'),
                  ],
                ),

          SizedBox(height: 35),

          CustomProceedButton(withPhoneNumber
              ? 'Generate Otp'
              : 'Sign Up'), // Login Button Here
          SizedBox(height: 10),
          Center(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Sign In',
                    style: Theme.of(context).textTheme.bodyText1,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).pushReplacementNamed('/login');
                      },
                  ),
                ],
                text: 'Already have an account?   ',
              ),
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ],
      ),
    );
  }
}
