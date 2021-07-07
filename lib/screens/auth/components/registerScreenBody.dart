import 'package:flutter/material.dart';

import 'customProceedButton.dart';
import 'socialMediaLoginButton.dart';
import 'customTextField.dart';

class RegisterScreenBody extends StatelessWidget {
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
          SizedBox(height: 20),
          Center(
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text.rich(
                TextSpan(text: 'Use phone number instead.'),
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    ?.copyWith(fontSize: 14),
              ),
            ),
          ),
          CustomTextField('Name'),
          SizedBox(height: 20),

          CustomTextField('Email'),
          SizedBox(height: 20),
          CustomTextField('Password'),
  
          SizedBox(height: 25),
          CustomProceedButton(), // Login Button Here
          SizedBox(height: 10),
          Center(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Sign Up',
                    style: Theme.of(context).textTheme.bodyText1,
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
