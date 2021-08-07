import 'package:chat_app/components/customProceedButton.dart';
import 'package:chat_app/screens/auth/components/customAppbar.dart';
import 'package:chat_app/screens/auth/components/customTextField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePageScreen extends StatefulWidget {
  @override
  _ProfilePageScreenState createState() => _ProfilePageScreenState();
}

class _ProfilePageScreenState extends State<ProfilePageScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: buildAppBar(context, title: 'Profile'),
      body: SingleChildScrollView(
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
                            controller: _firstNameController,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            'Last name',
                            'Enter your last name (optional)',
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
                            controller: _lastNameController,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          // Todo : Add a multiline option for CustomTextField and impliment that on bio
                          CustomTextField(
                            'Bio',
                            'Say something about yourself (optional)',
                            null,
                            controller: _bioController,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: setProfile,
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
    );
  }

  Future<void> setProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;
    final bio = _bioController.text;
    final prefs= await SharedPreferences.getInstance();

    final ref = FirebaseFirestore.instance;
    final _auth = FirebaseAuth.instance;
    final String uid = _auth.currentUser!.uid;

    if (_auth.currentUser == null) {
      //This check would never pass , but ya incase.
    }
    ref.collection('users').doc(uid).set(
      {
        'firstName': firstName,
        'lastName': lastName,
        'bio': bio,
      },
    ).then(
      (value) {
        prefs.setBool('profileSet', true);
      },
    ).catchError(
      (eroor) {
        print('Hello i want to inform you that an error has occured $eroor');
      },
    );
  }
}
