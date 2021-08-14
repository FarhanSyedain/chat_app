import '/components/dilog/awsomeDilog.dart';
import 'package:flutter/material.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import '/services/auth.dart';
import 'package:provider/provider.dart';

Future<void> signWithTwitter(context, Function chagneSpinerVal) async {
  final _authService = Provider.of<AuthService>(context, listen: false);

  chagneSpinerVal(true);
  _authService.signInWithTwitter().then(
    (value) async {
      print('Completed');
      chagneSpinerVal(false);
      if (value!.code == '') {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      } else {
        switch (value.code) {
          case 'account-exists-with-different-credential':
            {
              AwesomeDialog(
                padding: EdgeInsets.all(10),
                animType: AnimType.LEFTSLIDE,
                context: context,
                dialogType: DialogType.ERROR,
                title: 'Email has already been taken',
                body: Container(
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          'Email has been already taken',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Center(
                        child: Text(
                          'A user with this email exists with signed from different method. Use that method to sign in',
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
              break;
            }
          default:
            {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.ERROR,
                title: 'Eroor',
                desc: 'There was an error from our side',
              ).show();
            }
        }
      }
    },
  ).catchError(
    (_) {
      chagneSpinerVal(false);
      print(_);
    },
  );
}

Future<void> signInWithGoogle(context, Function changeSpinerVal) async {
  final _authService = Provider.of<AuthService>(context, listen: false);
  changeSpinerVal(true);

  _authService.signInWithGoogle().then(
    (value) {
      changeSpinerVal(false);
      if (value) {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      } else {
        showAwsomeDilog(
          DialogType.ERROR,
          'Error',
          'There was an error from our side',
          context,
        );
      }
    },
  ).catchError(
    (_) {
      changeSpinerVal(false);
    },
  );
}
