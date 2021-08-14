import 'package:chat_app/screens/auth/login/confirmEmail.dart';
import 'package:chat_app/screens/auth/profile/profile.dart';
import 'package:chat_app/screens/welcome/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  final bool? profileSet;
  Wrapper({this.profileSet = false});
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
        ? profileSet == null
            ? ProfilePageScreen()
            : profileSet! 
                ? Container(
                    child: TextButton(
                      onPressed: () {
                        sign();
                      },
                      child: Text('Signout'),
                    ),
                  )
                : ProfilePageScreen()
        : ConfirmEmailScreen();
  }
}
