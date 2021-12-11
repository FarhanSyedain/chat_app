import 'package:chat_app/services/auth.dart';
import 'package:chat_app/services/profile.dart';
import 'package:path/path.dart';
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

  Future<Widget> init(User? _user) async {
    // FirebaseAuth.instance.signOut();
    final prefs = await SharedPreferences.getInstance();

    // final _user = FirebaseAuth.instance.currentUser;
    await _user?.reload();
    if (_user == null) {
      return WelcomeScreen();
    }
    bool emailVerified = _user.emailVerified;
    final _provider = _user.providerData[0].providerId;
    if (_provider != 'password') {
      emailVerified = true;
    }
    if (emailVerified) {
      if (prefs.getBool('profileSet') ?? true) {
        if (prefs.getBool('profileSet') == null) {
          //Then fetch the profile
          await ProfileService().getProfile(FirebaseAuth.instance).then(
                (value) =>
                    Wrapper(), //Now that the value of profileSet would be a bool
              );
        }
        return HomeScreen();
        // return Container();
      }
      return ProfilePageScreen();
    } else {
      return ConfirmEmailScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);
    return FutureBuilder(
      builder: (context, data) {
        return data.connectionState == ConnectionState.waiting
            ? CircularProgressIndicator()
            : data.data as Widget;
        // return data.data as Widget;
      },
      future: init(_user),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                context.read<AuthService>().signOut();
              },
              child: Text('Signout',style: Theme.of(context).textTheme.bodyText1,),
            )
          ],
        ),
      ),
    );
  }
}
