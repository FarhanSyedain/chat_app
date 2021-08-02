import 'package:chat_app/components/customProceedButton.dart';
import 'package:chat_app/screens/auth/components/socialAuthRow.dart';
import 'package:chat_app/utilities/auth.dart';
import 'package:chat_app/utilities/emailRegexValidator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'customTextField.dart';
import 'socialMediaLoginButton.dart';

class LoginScreenBody extends StatefulWidget {
  @override
  _LoginScreenBodyState createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<LoginScreenBody> {
  final _formKey = GlobalKey<FormState>();
  void changeVal(v) {}
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
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
            SocialMediaRowWithPhoneNumberSwitch(changeVal),
            SizedBox(
              height: 5,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Column(
                    children: [
                      CustomTextField(
                        'Email',
                        'Enter your email',
                        (value) {
                          if (value == null) {
                            return 'Enter an email';
                          }
                          if (!validateEmail(value)) {
                            return 'Enter a valid email adress';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                        'Password',
                        'Enter your password',
                        (value) {
                          return null;
                        },
                        isPassword: true,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 5),
                    child: Text.rich(
                      TextSpan(text: 'Forgot Password?'),
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            GestureDetector(
              child: CustomProceedButton('Log In'),
              onTap: () {
                final isValid = _formKey.currentState?.validate();
                if (isValid == null) {
                  return;
                }
                if (isValid) {
                  print('Hello World');
                }
              },
            ), // Login Button Here
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
      ),
    );
  }

  Future<void> login() async {}
}
