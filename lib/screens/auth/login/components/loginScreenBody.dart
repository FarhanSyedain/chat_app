import 'package:chat_app/screens/auth/components/haveAccount.dart';
import 'package:chat_app/screens/auth/components/socialAuthRow.dart';
import 'package:chat_app/screens/auth/login/components/userInputArea.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:flutter/material.dart';

class LoginScreenBody extends StatefulWidget {
  @override
  _LoginScreenBodyState createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<LoginScreenBody> {
  bool loading = false;

  void changeVal(v) {
    setState(() {
      loading = v;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: loading,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SocialMediaRowWithPhoneNumberSwitch(changeVal),
              SizedBox(height: 5),
              UserInputArea(changeVal),
              SizedBox(height: 10),
              HaveOrHaveNotAnAccount(
                pageName: 'Sign Up',
                title: 'Don\'t have an account?  ',
                route: '/register',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
