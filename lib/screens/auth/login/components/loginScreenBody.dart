import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_app/components/customProceedButton.dart';
import 'package:chat_app/components/dilog/awsomeDilog.dart';
import 'package:chat_app/screens/auth/components/haveAccount.dart';
import 'package:chat_app/screens/auth/components/socialAuthRow.dart';
import 'package:chat_app/screens/auth/login/components/userInputArea.dart';
import 'package:chat_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/utilities/emailRegexValidator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../components/customTextField.dart';

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
              SizedBox(height: 60),
              Text(
                'Login with any of the below options.',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(height: 20),
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
