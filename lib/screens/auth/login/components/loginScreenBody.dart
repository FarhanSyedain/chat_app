import 'package:chat_app/screens/chat/loadingOverlay.dart';
import 'package:flutter/gestures.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

import '../../components/haveAccount.dart';
import '../../components/socialAuthRow.dart';
import '../components/userInputArea.dart';
import 'package:flutter/material.dart';

class LoginScreenBody extends StatefulWidget {
  @override
  _LoginScreenBodyState createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<LoginScreenBody> {
  bool loading = false;
  bool keyboardVisivle = false;
  void changeVal(v) {
    setState(() {
      loading = v;
    });
  }

  @override
  void initState() {
    super.initState();

    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        setState(() {
          keyboardVisivle = visible;
        });
      },
    );
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
              if (!keyboardVisivle)
                AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  child: SocialMediaRowWithPhoneNumberSwitch(changeVal, 'in'),
                ),
              if (keyboardVisivle) ...[
                Center(
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      fontFamily: 'MontserratB',
                      fontSize: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
              SizedBox(height: 5),
              UserInputArea(changeVal),
              SizedBox(height: 15),
              HaveOrHaveNotAnAccount(
                pageName: 'Sign Up',
                title: 'Don\'t have an account?  ',
                route: '/register',
              ),
              SizedBox(height: 5),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 10, top: 5),
                child: Center(
                  child: Text.rich(
                    TextSpan(
                      text: 'Forgot Password?',
                      recognizer: TapGestureRecognizer()
                        ..onTap = forgotPassword,
                    ),
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void forgotPassword() {
    Navigator.pushNamed(context, '/forgotPassword');
  }
}
