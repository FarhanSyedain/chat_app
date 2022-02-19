import 'package:chat_app/animations/animations.dart';
import 'package:chat_app/components/background.dart';
import 'package:chat_app/screens/auth/login/login.dart';
import 'package:flutter/material.dart';

import '../components/customAppbar.dart';
import 'components/registerScreenBody.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: buildAppBar(
        context,
        back: () {
          Navigator.of(context).pushReplacement(
            PageTransition(
              child: LoginScreen(),
              type: PageTransitionType.fromRight,
            ),
          );
        },
      ),
      body: BackgroundWrapper(
        child: WillPopScope(
          onWillPop: () async {
            Navigator.of(context).pushReplacement(
              PageTransition(
                child: LoginScreen(),
                type: PageTransitionType.fromRight,
              ),
            );
            return true;
          },
          child: RegisterScreenBody(),
        ),
      ),
    );
  }
}
