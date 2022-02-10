import 'package:flutter/material.dart';
import '../components/socialMediaLoginButton.dart';

class SocialMediaRowWithPhoneNumberSwitch extends StatelessWidget {
  final Function(dynamic) changeVal;
  final String uniqueText;
  const SocialMediaRowWithPhoneNumberSwitch(
    this.changeVal,
    this.uniqueText,
  );
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        const Text(
          'Chat Freely!',
          style: TextStyle(
            fontFamily: 'MontserratB',
            fontSize: 50,
            color: Colors.white,
          ),
        ),
        const Text(
          'Welcome,',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 30,
          ),
        ),
        Text(
          'Sign $uniqueText below',
          style: const TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 30,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        // Text(
        //   'Sign in with one of these options.',
        //   style: Theme.of(context).textTheme.bodyText2,
        // ),
        // SizedBox(height: 20),
        // SocialMediaLoginButton('Sign in with Phone Instead'),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Expanded(
        //       child: GestureDetector(
        //         onTap: () => signInWithGoogle(context, changeVal),
        //         child: SocialMediaLoginButton('assets/vectors/google_icon.svg'),
        //       ),
        //     ),
        //     SizedBox(width:25),
        //     Expanded(
        //       child: GestureDetector(
        //         onTap: () => signWithTwitter(context, changeVal),
        //         child: SocialMediaLoginButton('assets/vectors/twitter_icon.svg'),
        //       ),
        //     ),
        //   ],
        // ),
        // SizedBox(height: 10),
        // Center(
        //   child: TextButton(
        //     child: Text('Use phone number instead.'),
        //     onPressed: () {
        //       Navigator.of(context).pushReplacementNamed('/phoneAuth');
        //     },
        //   ),
        // ),
      ],
    );
  }
}
