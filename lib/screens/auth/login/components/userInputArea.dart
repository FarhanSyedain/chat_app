import 'package:awesome_dialog/awesome_dialog.dart';
import '/services/profile.dart';
import '/components/customProceedButton.dart';
import '/components/dilog/awsomeDilog.dart';
import '/screens/auth/components/customTextField.dart';
import '/services/auth.dart';
import '/utilities/validitors/basicFormValiditors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserInputArea extends StatefulWidget {
  final Function(bool) changeVal;
  UserInputArea(this.changeVal);

  @override
  _UserInputAreaState createState() => _UserInputAreaState();
}

class _UserInputAreaState extends State<UserInputArea> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailControler = TextEditingController();
  TextEditingController _passwordControler = TextEditingController();
  bool userNotFound = false;
  bool incorrectPassword = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              Column(
                children: [
                  CustomTextField(
                    'Email',
                    'Enter your email',
                    emailValidator,
                    controller: _emailControler,
                    errorMessage: userNotFound
                        ? 'User with this email doesn\'t exist'
                        : null,
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    'Password',
                    'Enter your password',
                    passwordValidator,
                    errorMessage: incorrectPassword
                        ? 'Incorrect password or no password set'
                        : null,
                    isPassword: true,
                    controller: _passwordControler,
                  ),
                ],
              ),
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.only(left: 10, top: 5),
                child: Text.rich(
                  TextSpan(
                    text: 'Forgot Password?',
                    recognizer: TapGestureRecognizer()..onTap = forgotPassword,
                  ),
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
              SizedBox(height: 25),
              GestureDetector(
                child: CustomProceedButton('Log In'),
                onTap: () => login(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void forgotPassword() {
    Navigator.pushNamed(context, '/forgotPassword');
  }

  Future<void> login(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      userNotFound = false;
      incorrectPassword = false;
      widget.changeVal(true);
    });
    FirebaseAuthException? response =
        await context.read<AuthService>().loginUser(
              _emailControler.text,
              _passwordControler.text,
            );
    setState(() {
      widget.changeVal(false);
    });
    if (response == null) {
      ProfileService().getProfile(FirebaseAuth.instance);
      await Navigator.pushNamedAndRemoveUntil(
        context,
        '/wrapper',
        (r) => false,
      );
    } else {
      switch (response.code) {
        case 'user-not-found':
          {
            setState(() {
              userNotFound = true;
            });
            break;
          }
        case 'wrong-password':
          {
            print(response.code);
            setState(() {
              incorrectPassword = true;
            });
            break;
          }
        default:
          {
            showAwsomeDilog(
              DialogType.ERROR,
              'Something unexpected occured',
              'An unexpected error occured. Please try again.',
              context,
            );
          }
      }
    }
  }
}
