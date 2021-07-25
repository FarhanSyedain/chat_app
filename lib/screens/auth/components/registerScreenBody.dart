import 'package:chat_app/services/auth.dart';
import 'package:chat_app/utilities/emailRegexValidator.dart';
import 'package:chat_app/utilities/passwordValidator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/components/customProceedButton.dart';
import 'package:provider/provider.dart';

import 'socialMediaLoginButton.dart';
import 'customTextField.dart';

class RegisterScreenBody extends StatefulWidget {
  @override
  _RegisterScreenBodyState createState() => _RegisterScreenBodyState();
}

class _RegisterScreenBodyState extends State<RegisterScreenBody> {
  var emailAlreadyInUse = false;
  var loading = false;
  var withPhoneNumber = false;
  final passwordTextFieldControler = TextEditingController();
  final emailTextFieldControler = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void changeRegisterField() {
    setState(() {
      withPhoneNumber = !withPhoneNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SocialMediaLoginButton('Google'),
                SocialMediaLoginButton('GitHub'),
              ],
            ),

            Center(
              child: Padding(
                padding: EdgeInsets.all(25),
                child: Text.rich(
                  TextSpan(
                    text: withPhoneNumber
                        ? 'Use email instead'
                        : 'Use phone number instead.',
                    recognizer: TapGestureRecognizer()
                      ..onTap = changeRegisterField,
                  ),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      ?.copyWith(fontSize: 14),
                ),
              ),
            ),

            Form(
              key: _formKey,
              child: withPhoneNumber
                  ? CustomTextField('Phone Number', 'Enter your phone number',
                      (value) {
                      if (value == null) {
                        return 'Enter a phone number';
                      }
                      return null;
                    })
                  : Column(
                      children: [
                        CustomTextField(
                          'Email',
                          'Enter your email',
                          (value) {
                            if (value == null) {
                              return 'Enter an email';
                            }
                            if (!validateEmail(value)) {
                              return 'Enter a valid email';
                            }
                          },
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
                          (value) {
                            if (value == null) {
                              return 'Enter a password';
                            }
                            if (!validatePassword(value)) {
                              return 'Password must be atleast 6 charecters';
                            }
                          },
                          controller: passwordTextFieldControler,
                          disabled: loading,
                          isPassword: true,
                        ),
                        SizedBox(height: 20),
                        CustomTextField(
                          'Confirm Password',
                          'Confirm your password',
                          (value) {
                            final password = passwordTextFieldControler.text;

                            if (password != value) {
                              return 'Passwords don\'t match';
                            }
                          },
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
                        !withPhoneNumber
                            ? signUpWithEmail(
                                context,
                                emailTextFieldControler.text,
                                passwordTextFieldControler.text,
                              )
                            : print(withPhoneNumber);
                      }
                    },
                    child: CustomProceedButton(
                      withPhoneNumber ? 'Generate Otp' : 'Sign Up',
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
                          Navigator.of(context).pushReplacementNamed('/login');
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
