import 'package:awesome_dialog/awesome_dialog.dart';
import '/services/profile.dart';
import '/components/customProceedButton.dart';
import '/components/dilog/awsomeDilog.dart';
import '/screens/auth/components/customTextField.dart';
import '/services/auth.dart';
import '/utilities/validitors/basicFormValiditors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserInputArea extends StatefulWidget {
  final Function(bool) changeVal;
  const UserInputArea(this.changeVal);

  @override
  _UserInputAreaState createState() => _UserInputAreaState();
}

class _UserInputAreaState extends State<UserInputArea> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailControler = TextEditingController();
  final TextEditingController _passwordControler = TextEditingController();
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    'Email',
                    emailValidator,
                    controller: _emailControler,
                    errorMessage: userNotFound
                        ? 'User with this email doesn\'t exist'
                        : null,
                    prefixIcon: Icons.email,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    'Password',
                    passwordValidator,
                    errorMessage: incorrectPassword
                        ? 'Incorrect password or no password set'
                        : null,
                    isPassword: true,
                    controller: _passwordControler,
                    textInputAction: TextInputAction.done,
                    prefixIcon: Icons.lock,
                  ),
                ],
              ),

              // ),
              const SizedBox(height: 55),
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

  Future<void> login(BuildContext context) async {
    FocusScope.of(context).unfocus();

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
