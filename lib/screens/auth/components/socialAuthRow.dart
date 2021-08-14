import 'package:flutter/material.dart';
import '../components/socialMediaLoginButton.dart';
import '../../../utilities/auth.dart';

class SocialMediaRowWithPhoneNumberSwitch extends StatelessWidget {
  final Function(dynamic) changeVal;
  SocialMediaRowWithPhoneNumberSwitch(this.changeVal);
  @override
  Widget build(BuildContext context) {
    return Column(
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
            GestureDetector(
              onTap: () => signInWithGoogle(context, changeVal),
              child: SocialMediaLoginButton('Google'),
            ),
            GestureDetector(
              onTap: () => signWithTwitter(context, changeVal),
              child: SocialMediaLoginButton('Twitter'),
            ),
          ],
        ),
        SizedBox(height: 10),
        Center(
          child: TextButton(
            child: Text('Use phone number instead.'),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/phoneAuth');
            },
          ),
        ),
      ],
    );
  }
}
