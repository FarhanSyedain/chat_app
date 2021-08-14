import 'package:chat_app/screens/auth/components/socialAuthRow.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/utilities/emailRegexValidator.dart';
import 'package:chat_app/utilities/passwordValidator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/components/customProceedButton.dart';
import 'package:provider/provider.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../../components/customTextField.dart';

class RegisterScreenBody extends StatefulWidget {
  @override
  _RegisterScreenBodyState createState() => _RegisterScreenBodyState();
}

class _RegisterScreenBodyState extends State<RegisterScreenBody> {
  var emailAlreadyInUse = false;
  var loading = false;
  final passwordTextFieldControler = TextEditingController();
  final emailTextFieldControler = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: loading,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Text(
                'Sign up with any of the below options.',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(height: 20),
              SocialMediaRowWithPhoneNumberSwitch(
                (v) {
                  setState(
                    () {
                      loading = v;
                    },
                  );
                },
              ),
              SizedBox(height: 5),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      'Email',
                      'Enter your email',
                      emailValidator,
                      controller: emailTextFieldControler,
                      errorMessage: !emailAlreadyInUse
                          ? null
                          : "This email is already in use!",
                      disabled: loading,
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      'Password',
                      'Set a passowrd',
                      passwordValidator,
                      controller: passwordTextFieldControler,
                      disabled: loading,
                      isPassword: true,
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      'Confirm Password',
                      'Confirm your password',
                      (value) => confirmPasswordValidator(
                        value,
                        passwordTextFieldControler,
                      ),
                      disabled: loading,
                      isPassword: true,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 35),
              loading
                  ? CustomProceedButton('Signin in..')
                  : GestureDetector(
                      onTap: () {
                        final isValid = _formKey.currentState?.validate();
                        if (isValid == null) {
                          return;
                        }
                        if (isValid) {
                          signUpWithEmail(
                            context,
                            emailTextFieldControler.text,
                            passwordTextFieldControler.text,
                          );
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: CustomProceedButton(
                          'Sign Up',
                        ),
                      ),
                    ), // Login Button Here
              SizedBox(height: 10),
              Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Sign In',
                        style: Theme.of(context).textTheme.bodyText1,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pushReplacementNamed(
                              '/login',
                            );
                          },
                      ),
                    ],
                    text: 'Already have an account?   ',
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

  Future<void> signUpWithEmail(
      BuildContext context, String email, String password) async {
    setState(() {
      emailAlreadyInUse = false;
      loading = true;
    });
    String response =
        await context.read<AuthService>().registerUser(email, password);
    setState(() {
      loading = false;
    });
    if (response == '') {
      //User successfully registerd
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/verifyEmail',
        (r) => false,
      );
    } else {
      if (response == 'email-already-in-use') {
        setState(() {
          emailAlreadyInUse = true;
        });
      }
    }
  }
}

String? emailValidator(value) {
  if (value == null) {
    return 'Enter an email';
  }
  if (!validateEmail(value)) {
    return 'Enter a valid email';
  }
}

String? passwordValidator(value) {
  if (value == null) {
    return 'Enter a password';
  }
  if (!validatePassword(value)) {
    return 'Password must be atleast 6 charecters';
  }
}

String? confirmPasswordValidator(value, passwordTextFieldController) {
  final password = passwordTextFieldController.text;

  if (password != value) {
    return 'Passwords don\'t match';
  }
}
