import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '/components/dilog/awsomeDilog.dart';
import '/screens/auth/components/customAppbar.dart';
import '/screens/auth/components/customTextField.dart';
import '/services/auth.dart';
import '/utilities/validitors/basicFormValiditors.dart';
import '/components/customProceedButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ResetEmailScreen extends StatefulWidget {
  @override
  _ResetEmailScreenState createState() => _ResetEmailScreenState();
}

class _ResetEmailScreenState extends State<ResetEmailScreen> {
  final _textEditingController = TextEditingController();
  bool _loading = false;
  bool _invalidEmail = false;
  bool _noUserAssociated = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _loading,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: buildAppBar(context, back: () {
          Navigator.of(context).pop();
        }),
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Forgot your password?',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  SizedBox(height: 15),
                  Center(
                    child: Text(
                      'Enter the email associated with your account, so that we could send you instructions.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: SvgPicture.asset(
                      'assets/vectors/emailReset.svg',
                      height: 200,
                    ),
                  ),
                  SizedBox(height: 25),
                  Center(
                    child: Form(
                      key: _formKey,
                      child: CustomTextField(
                        'Email',
                        emailValidator,
                        controller: _textEditingController,
                        prefixIcon: Icons.email,
                        errorMessage: _invalidEmail
                            ? 'Invalid Email'
                            : _noUserAssociated
                                ? 'No user associated with this email'
                                : null,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  // Padding(
                  //   padding: const EdgeInsets.all(10.0),
                  //   child: Center(
                  //     child: Row(
                  //       mainAxisSize: MainAxisSize.min,
                  //       children: [
                  //         Text(
                  //           'Remeber Password?  ',
                  //           style: Theme.of(context).textTheme.bodyText2,
                  //         ),
                  //         Text.rich(
                  //           TextSpan(
                  //             children: [
                  //               WidgetSpan(
                  //                 child: GestureDetector(
                  //                   onTap: () {
                  //                     Navigator.of(context).pop();
                  //                   },
                  //                   child: Padding(
                  //                     padding:
                  //                         EdgeInsets.symmetric(vertical: 8.0),
                  //                     child: Text(
                  //                       'Login',
                  //                       style:
                  //                           Theme.of(context).textTheme.bodyText1,
                  //                     ),
                  //                   ),
                  //                 ),
                  //               )
                  //             ],
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 15),
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
      ),
    );
  }

  Future<void> sendEmail() async {
    setState(() {
      _noUserAssociated = false;
      _invalidEmail = false;
      _loading = true;
    });
    try {
      if (!_formKey.currentState!.validate()) {
        return;
      }

      final response = await context.read<AuthService>().sendResetPasswordEmail(
            _textEditingController.text.trim(),
          );
      if (response == null) {
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
      showAwsomeDilog(
        DialogType.ERROR,
        'Something went wrong!',
        'Unfourtunatley something happened , please try again maybe after some time',
        context,
      );
    }
  }
}
