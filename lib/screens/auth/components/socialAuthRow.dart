import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:chat_app/screens/auth/components/socialMediaLoginButton.dart';
import '../../../utilities/auth.dart';

class SocialMediaRowWithPhoneNumberSwitch extends StatelessWidget {
  final Function(dynamic) changeVal;
  SocialMediaRowWithPhoneNumberSwitch(this.changeVal);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => signInWithGoogle(context, changeVal),
              child: SocialMediaLoginButton('Google'),
            ),
            GestureDetector(
              onTap: () => signWithTwitter(context, changeVal),
              child: SocialMediaLoginButton('Github'),
            ),
          ],
        ),
        SizedBox(height: 20),
        Center(
          child: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text.rich(
              TextSpan(
                text: 'Use phone number instead.',
              ),
              style:
                  Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }
}