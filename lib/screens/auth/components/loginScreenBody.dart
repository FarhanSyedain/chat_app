import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_app/components/customProceedButton.dart';
import 'package:chat_app/screens/auth/components/socialAuthRow.dart';
import 'package:chat_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/utilities/emailRegexValidator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'customTextField.dart';

class LoginScreenBody extends StatefulWidget {
  @override
  _LoginScreenBodyState createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<LoginScreenBody> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailControler = TextEditingController();
  TextEditingController _passwordControler = TextEditingController();
  bool userNotFound = false;
  bool incorrectPassword = false;
  bool loading = false;

  void changeVal(v) {}
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
              SizedBox(
                height: 5,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Column(
                      children: [
                        CustomTextField(
                          'Email',
                          'Enter your email',
                          (value) {
                            if (value == null) {
                              return 'Enter an email';
                            }
                            if (!validateEmail(value)) {
                              return 'Enter a valid email adress';
                            }
                            return null;
                          },
                          controller: _emailControler,
                          errorMessage: userNotFound
                              ? 'User with this email doesn\'t exist'
                              : null,
                        ),
                        SizedBox(height: 20),
                        CustomTextField(
                          'Password',
                          'Enter your password',
                          (value) {
                            return null;
                          },
                          errorMessage: incorrectPassword
                              ? 'Incorrect password or no password set'
                              : null,
                          isPassword: true,
                          controller: _passwordControler,
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 5),
                      child: Text.rich(
                        TextSpan(text: 'Forgot Password?'),
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              GestureDetector(
                child: CustomProceedButton('Log In'),
                onTap: () => login(context),
              ), // Login Button Here
              SizedBox(height: 10),
              Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Sign up',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.of(context)
                              .pushReplacementNamed('/register'),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                    text: 'Don\'t have an account?   ',
                  ),
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> login(BuildContext context) async {
    setState(() {
      userNotFound = false;
      incorrectPassword = false;
      loading = true;
    });
    FirebaseAuthException? response =
        await context.read<AuthService>().loginUser(
              _emailControler.text,
              _passwordControler.text,
            );
    setState(() {
      loading = false;
    });
    if (response!.code == '') {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/wrapper',
        (r) => false,
      );
    } else {
      print(response);
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
            AwesomeDialog(
              padding: EdgeInsets.all(10),
              animType: AnimType.LEFTSLIDE,
              context: context,
              dialogType: DialogType.ERROR,
              body: Container(
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        'Something unexpected occured',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Center(
                      child: Text(
                        'An unexpected error occured. Please try again',
                        style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
              desc:
                  'A user wih this email has been signed with differnt method. Please try using that method.',
            ).show();
            print(response);
          }
      }
    }
  }
}
