import 'package:flutter/material.dart';
import '../components/socialMediaLoginButton.dart';
import '../../../utilities/auth.dart';

class SocialMediaRowWithPhoneNumberSwitch extends StatelessWidget {
  final Function(dynamic) changeVal;
  SocialMediaRowWithPhoneNumberSwitch(this.changeVal);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 50),
        Text(
          'Sign in with one of these options.',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => signInWithGoogle(context, changeVal),
                child: SocialMediaLoginButton('assets/vectors/google_icon.svg'),
              ),
            ),
            SizedBox(width:25),
            Expanded(
              child: GestureDetector(
                onTap: () => signWithTwitter(context, changeVal),
                child: SocialMediaLoginButton('assets/vectors/twitter_icon.svg'),
              ),
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
