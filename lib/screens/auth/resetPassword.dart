import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_app/components/customProceedButton.dart';
import 'package:chat_app/screens/auth/components/customAppbar.dart';
import 'package:chat_app/screens/auth/components/customTextField.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/utilities/emailRegexValidator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ResetEmailScreen extends StatefulWidget {
  @override
  _ResetEmailScreenState createState() => _ResetEmailScreenState();
}

class _ResetEmailScreenState extends State<ResetEmailScreen> {
  final _textEditingController = TextEditingController();
  bool _invalidEmail = false;
  bool _noUserAssociated = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: buildAppBar(
        context,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    'Forgot your password?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Text(
                    'Enter the email associated with your account, so that we could send you instructions.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white54,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: SvgPicture.asset(
                    'assets/vectors/emailReset.svg',
                    height: 200,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Center(
                  child: Form(
                    key: _formKey,
                    child: CustomTextField(
                      '',
                      'Email',
                      (v) {
                        if (v == null) {
                          return 'Enter an email';
                        }
                        if (!validateEmail(v)) {
                          return 'Enter a valid email';
                        }
                      },
                      controller: _textEditingController,
                      errorMessage: _invalidEmail
                          ? 'Invalid Email'
                          : _noUserAssociated
                              ? 'No user associated with this email'
                              : null,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Remeber Password?  '),
                        Text.rich(
                          TextSpan(
                            children: [
                              WidgetSpan(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8.0),
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: GestureDetector(
                    child: CustomProceedButton('Send Email'),
                    onTap: sendEmail,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> sendEmail() async {
    setState(() {
      _noUserAssociated = false;
      _invalidEmail = false;
    });
    try {
      print('No here');
      if (!_formKey.currentState!.validate()) {
        return;
      }
      print('object');
      final response = await context.read<AuthService>().sendResetPasswordEmail(
            _textEditingController.text.trim(),
          );
      if (response == null) {
        print('It is null for sure');
        await Navigator.of(context).pushReplacementNamed('/resetEmailSend');
      }

      switch (response!.code) {
        case '':
          {
            break;
          }
        case 'invalid-email':
          {
            setState(
              () {
                _invalidEmail = true;
              },
            );
            break;
          }
        case 'user-not-found':
          {
            setState(() {
              _noUserAssociated = true;
            });
            break;
          }
        default:
          {
            throw Error();
          }
      }
    } catch (e) {
      print(e);
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
      ).show();
    }
  }
}
