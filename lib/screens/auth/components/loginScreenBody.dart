import 'package:chat_app/screens/auth/components/customProceedButton.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'customTextField.dart';
import 'socialMediaLoginButton.dart';

class LoginScreenBody extends StatefulWidget {
  @override
  _LoginScreenBodyState createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<LoginScreenBody> {
  var withPhoneNumber = false;

  void changeLoginField() {
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
            'Login with any of the below options.',
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
          SizedBox(height: 20),
          Center(
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text.rich(
                TextSpan(
                  recognizer: TapGestureRecognizer()..onTap = changeLoginField,
                  text: withPhoneNumber
                      ? 'Use phone number instead.'
                      : 'Use email instead',
                ),
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    ?.copyWith(fontSize: 14),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          withPhoneNumber
              ? Column(
                  children: [
                    CustomTextField(
                      'Email',
                      'Enter your email',
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      'Password',
                      'Enter your password',
                    ),
                  ],
                )
              : CustomTextField(
                  'Phone Number',
                  'Enter your mobile number',
                ),
          if (withPhoneNumber)
            Padding(
              padding: EdgeInsets.only(left: 10, top: 5),
              child: Text.rich(
                TextSpan(text: 'Forgot Password?'),
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          SizedBox(height: 25),
          CustomProceedButton('Log In'), // Login Button Here
          SizedBox(height: 10),
          Center(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Sign up',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Navigator.of(context)
                          .pushReplacementNamed('/register'),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
                text: 'Don\'t have an account?   ',
              ),
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ],
      ),
    );
  }
}
