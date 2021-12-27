import '/components/customProceedButton.dart';
import '/screens/auth/components/customTextField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomFormArea extends StatefulWidget {
  final Function(bool)? changeSpinerVal;
  CustomFormArea(this.changeSpinerVal);

  @override
  _CustomFormAreaState createState() => _CustomFormAreaState();
}

class _CustomFormAreaState extends State<CustomFormArea> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                // 'Frist name',
                'First name',
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
                prefixIcon: Icons.person_outline,
                controller: _firstNameController,
              ),
              SizedBox(height: 10),
              CustomTextField(
                'Last Name',
                null,
                prefixIcon: Icons.person,
                controller: _lastNameController,
              ),
              SizedBox(height: 10),
              // Todo : Add a multiline option for CustomTextField and impliment that on bio
              CustomTextField(
                'About',
                null,
                prefixIcon: Icons.info,
                controller: _bioController,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
        GestureDetector(
          onTap: setProfile,
          child: CustomProceedButton(
            'Set Up Profile',
          ),
        )
      ],
    );
  }

  Future<void> setProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    widget.changeSpinerVal!(true);
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;
    final bio = _bioController.text;
    final prefs = await SharedPreferences.getInstance();

    final ref = FirebaseFirestore.instance;
    final _auth = FirebaseAuth.instance;
    final String uid = _auth.currentUser!.uid;

    ref.collection('users').doc(uid).set(
      {
        'firstName': firstName,
        'lastName': lastName,
        'bio': bio,
      },
    ).then(
      (value) {
        widget.changeSpinerVal!(false);
        prefs.setBool('profileSet', true);
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/wrapper',
          (route) => false,
        );
      },
    ).catchError(
      (eroor) {
        widget.changeSpinerVal!(false);
        print('Hello i want to inform you that an error has occured $eroor');
      },
    );
  }
}
