import 'package:chat_app/services/auth.dart';
import 'package:chat_app/services/profile.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/screens/auth/login/confirmEmail.dart';
import '/screens/auth/profile/profile.dart';
import '/screens/welcome/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  final bool? profileSet;
  Wrapper({this.profileSet = false});
  Future<void> sign() async {
    FirebaseAuth.instance.signOut();
  }

  Future<Widget?> init() async {
    final prefs = await SharedPreferences.getInstance();
    final _user = FirebaseAuth.instance.currentUser;
    if (_user == null) {
      return WelcomeScreen();
    }
    bool emailVerified = _user.emailVerified;
    final _provider = _user.providerData[0].providerId;
    if (_provider != 'password') {
      emailVerified = true;
    }
    if (emailVerified) {
      if (prefs.getBool('profileSet') ?? false) {
        if (prefs.getBool('profileSet') == null) {
          //Then fetch the profile
          await ProfileService().getProfile(FirebaseAuth.instance).then(
            (value) =>
                Wrapper(), //Now that the value of profileSet would be a bool
          );
        }
        return Container();
      }
      return ProfilePageScreen();
    } else {
      return ConfirmEmailScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, data) {
        return data.connectionState == ConnectionState.waiting
            ? CircularProgressIndicator()
            : data.data as Widget;
      },
      future: init(),
    );
  }
}
