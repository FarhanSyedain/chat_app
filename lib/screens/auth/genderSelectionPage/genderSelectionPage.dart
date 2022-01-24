import 'package:chat_app/components/customProceedButton.dart';
import 'package:chat_app/components/radio.dart';
import 'package:chat_app/screens/auth/genderSelectionPage/components/loadingOverlay.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GenderSelectionPage extends StatefulWidget {
  @override
  _GenderSelectionPageState createState() => _GenderSelectionPageState();
}

class _GenderSelectionPageState extends State<GenderSelectionPage> {
  int _value = 1;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'Select Your Gender',
                style: TextStyle(
                  fontSize: 50,
                  fontFamily: 'MontserratB',
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'This will be used to generate an avatar',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyRadioListTile<int>(
                    value: 1,
                    groupValue: _value,
                    leading: 'Boy',
                    onChanged: (value) => setState(() => _value = value!),
                  ),
                  MyRadioListTile<int>(
                    value: 2,
                    groupValue: _value,
                    leading: 'Girl',
                    onChanged: (value) => setState(() => _value = value!),
                  ),
                ],
              ),
              SizedBox(height: 60),
              GestureDetector(
                child: CustomProceedButton('Next'),
                onTap: () => setGender(_value),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> setGender(value) async {
    setState(() {
      isLoading = true;
    });
    final gender = value == 1 ? 'M' : 'F';
    final uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'gender': '$gender'}).then((value) async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('genderSelected', true);
    }).whenComplete(
      () => Navigator.pushNamed(context, '/home'),
    );
  }
}
