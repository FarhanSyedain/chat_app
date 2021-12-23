import 'package:chat_app/models/customUserModel.dart';
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

  Future<Widget> init(User? _user, AuthState? _authState) async {
    
    final prefs = await SharedPreferences.getInstance();

    await prefs.reload();
    await _user?.reload();
    await _authState!.user?.reload();

    if (_authState.user == null) {
      return WelcomeScreen();
    } 

    bool emailVerified = _user!.emailVerified;
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
      }
      return ProfilePageScreen();
    } else {
      return ConfirmEmailScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context, listen: false);
    final _authState = Provider.of<AuthState?>(context);
    return FutureBuilder(
      initialData: CircularProgressIndicator(),
      builder: (context, data) {
        return data.data == null
            ? CircularProgressIndicator()
            : data.data as Widget;
      },
      future: init(_user, _authState),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
          children: [
            Container(
              width: 100,
              height: 100,
              color: Colors.greenAccent,
            ),
            TextButton(
              onPressed: () {
                context.read<AuthService>().signOut();
              },
              child: Center(
                child: Text(
                  'Signout',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
