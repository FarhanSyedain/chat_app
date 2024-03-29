import 'package:chat_app/models/chat/old_chat.dart';
import 'package:chat_app/models/chat/old_chats.dart';
import 'package:chat_app/screens/auth/genderSelectionPage/genderSelectionPage.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/models/customUserModel.dart';
import 'package:chat_app/screens/chat/home/home.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/services/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'additional/confirmEmail.dart';
import '/screens/auth/profile/profile.dart';
import '/screens/welcome/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  final bool? profileSet;
  const Wrapper({this.profileSet = false});
  Future<void> sign() async {
    FirebaseAuth.instance.signOut();
  }

  Future<Widget> init(
      User? _user, AuthState? _authState, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final bool? authComplete = prefs.getBool('authComplete');
    if (authComplete ?? false) {
      await Provider.of<Chats>(context, listen: false).fetchChats();
      Provider.of<Chats>(context, listen: false).getChats;

      return ChatScreen();
    }

    await prefs.reload();
    await _user?.reload();

    if (_authState?.user == null) {
      return WelcomeScreen();
    }
    await _authState!.user?.reload();

    //? Socail authe removed so no need, will see later
    // bool emailVerified = _user!.emailVerified;
    // final _provider = _user.providerData[0].providerId;
    // if (_provider != 'password') {
    //   emailVerified = true;
    // }

    if (_user!.emailVerified) {
      if (prefs.getBool('profileSet') ?? true) {
        if (!(prefs.getBool('genderSelected') ?? false)) {
          return GenderSelectionPage();
        }
        if (prefs.getBool('profileSet') == null) {
          //Then fetch the profile
          await ProfileService().getProfile(FirebaseAuth.instance).then(
                (value) =>
                    const Wrapper(), //Now that the value of profileSet would be a bool
              );
        }
        prefs.setBool('authComplete', true);
        Provider.of<Chats>(context, listen: false).getChats;

        return ChatScreen();
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
      initialData: const CustomProsgressScreen(),
      builder: (context, data) {
        // return CustomProsgressScreen();
        return data.data == null
        ? const CustomProsgressScreen()
        : data.data as Widget;
      },
      future: init(_user, _authState, context),
    );
  }
}

class CustomProsgressScreen extends StatelessWidget {
  const CustomProsgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: Lottie.network(
                  'https://assets2.lottiefiles.com/packages/lf20_tqvrzfnf.json',
                ),
              ),
            ],
          ),
        ),
      ),
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
