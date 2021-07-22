import 'package:chat_app/components/customProceedButton.dart';
import 'package:chat_app/screens/auth/components/customAppbar.dart';
import 'package:chat_app/screens/auth/components/customTextField.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ProfilePageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: buildAppBar(context, 'Profile'),
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
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    CustomTextField(
                      'Name',
                      'Enter your name',
                      null,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Todo : Add a multiline option for CustomTextField and impliment that on bio
                    CustomTextField(
                      'Bio',
                      'Say something about yourself',
                      null,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    CustomProceedButton('Update Profile'),
                    //Todo : Make this thing only avalible when redirected from register screen
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text.rich(
                        TextSpan(
                          text: 'Skip',
                          style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => print(
                                'Stop being lazy and add logic here man.'),
                        ),
                      ),
                    )
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
