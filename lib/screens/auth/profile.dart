import 'package:chat_app/components/customProceedButton.dart';
import 'package:chat_app/screens/auth/components/customAppbar.dart';
import 'package:chat_app/screens/auth/components/customTextField.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ProfilePageScreen extends StatefulWidget {
  @override
  _ProfilePageScreenState createState() => _ProfilePageScreenState();
}

class _ProfilePageScreenState extends State<ProfilePageScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: buildAppBar(context, title: 'Profile'),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.orange,
                  ),
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                          'assets/dummy/profilePicture.jpg',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text.rich(
                  TextSpan(
                    text: 'Change Profile Picture.',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => print('Replace me'),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            'Frist name',
                            'Enter your first name',
                            (value) {
                              if (value == null) {
                                return 'Please enter a name';
                              }
                              if (value.trim().length == 0) {
                                return 'Please enter a name';
                              }
                              if (value.trim().length > 20) {
                                return 'Enter a name less that 20 charecters';
                              }
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            'Last name',
                            'Enter your last name (optional)',
                            null,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          // Todo : Add a multiline option for CustomTextField and impliment that on bio
                          CustomTextField(
                            'Bio',
                            'Say something about yourself (optional)',
                            null,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        final valid = _formKey.currentState?.validate();
                        if (valid == null) {
                          return;
                        }
                        if (valid) {
                          print('Good');
                        }
                      },
                      child: CustomProceedButton(
                        'Set Up Profile',
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
