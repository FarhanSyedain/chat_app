import 'package:chat_app/screens/welcome/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = FirebaseAuth.instance.currentUser;
    return (_user != null) ? WelcomeScreen() : Container();
  }
}
