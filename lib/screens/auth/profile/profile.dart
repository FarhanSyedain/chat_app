import 'dart:io';

import 'package:chat_app/components/customProceedButton.dart';
import 'package:chat_app/screens/auth/components/customAppbar.dart';
import 'package:chat_app/screens/auth/components/customTextField.dart';
import 'package:chat_app/screens/auth/profile/components/CustomFormArea.dart';
import 'package:chat_app/screens/auth/profile/components/profileArea.dart';
import 'package:chat_app/services/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePageScreen extends StatefulWidget {
  @override
  _ProfilePageScreenState createState() => _ProfilePageScreenState();
}

class _ProfilePageScreenState extends State<ProfilePageScreen> {
  XFile? _pickedImage;
  File? _currentImage;
  bool showSpiner = false;
  bool firstTime = true;

  Future<void> init() async {
    //In case we have uploaded an image to the database but it could not be stored locally
    //The chances of happening are .0000001% but still would run the check
    final dir = await getApplicationDocumentsDirectory();
    final String profilePicturePath = '${dir.path}/userProfile';
    final prefs = await SharedPreferences.getInstance();
    if (File(profilePicturePath).existsSync()) {
      _currentImage = File(profilePicturePath);
    }
    if (prefs.containsKey('DPUpdateFinished')) {
      var finished = prefs.getBool('DPUpdateFinished');
      if (!finished!) {
        await _fetchNewImage();
      }
    }
  }

  Future<void> _fetchNewImage() async {
    //Fetch and store new image from the database
    await ProfileService.updateProfilePicture();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: buildAppBar(
        context,
        title: 'Profile',
        showBackButton: false,
      ),
      body: FutureBuilder(
        future: init(),
        builder: (context, data) => LoadingOverlay(
          // progressIndicator: ,
          isLoading: showSpiner,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30),
                ProfileArea(
                  currentImage: _currentImage,
                  pickedImage: _pickedImage,
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: CustomFormArea(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
