import 'package:chat_app/components/background.dart';

import '/components/customProceedButton.dart';
import '/screens/auth/components/customAppbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ResetEmailSendScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: Theme.of(context).backgroundColor,
      body: BackgroundWrapper(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Email has been sent!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 25),
                Text(
                  'Please check your inbox. We\'ve sent you an email to reset your password.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                const SizedBox(height: 60),
                Center(
                  child: SvgPicture.asset(
                    'assets/vectors/emailReset.svg',
                    height: 200,
                  ),
                ),
                const SizedBox(height: 80),
                GestureDetector(
                  child: CustomProceedButton('Login'),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
