import 'package:chat_app/screens/auth/confirmEmail.dart';
import 'package:chat_app/screens/welcome/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);
  Future<void> sign() async {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final _user = FirebaseAuth.instance.currentUser;
    if (_user == null) {
      return WelcomeScreen();
    }
    bool emailVerified = _user.emailVerified;
    final _provider = _user.providerData[0].providerId;
    if (_provider != 'password') {
      emailVerified = true;
    }
    return emailVerified
        ? Container(
            child: TextButton(
                onPressed: () {
                  sign();
                },
                child: Text('Signout')),
          )
        : ConfirmEmailScreen();
  }
}
