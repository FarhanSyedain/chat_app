import 'dart:io';

import 'package:chat_app/components/customProceedButton.dart';
import 'package:chat_app/screens/auth/components/customAppbar.dart';
import 'package:chat_app/screens/auth/components/customTextField.dart';
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
  final _formKey = GlobalKey<FormState>();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  XFile? _pickedImage;
  File? _currentImage;
  bool showSpiner = false;
  bool firstTime = true;

  Future<void> _pickImage(ImageSource? source) async {
    Navigator.of(context).pop();
    setState(() {
      showSpiner = true;
    });
    final _imagePicker = ImagePicker();
    final _currentUser = FirebaseAuth.instance.currentUser;
    if (source == null) {
      //remove profile picture
      ProfileService.removeProfilePicture(_currentUser!.uid).then((value) {
        setState(() {
          _currentImage = null;
          showSpiner = false;
        });
      });
    } else {
      _pickedImage = await _imagePicker.pickImage(source: source);

      if (_pickedImage == null) {
        setState(() {
          showSpiner = false;
        });
        return;
      }

      ProfileService.uploadProfilePicture(
        File(_pickedImage!.path),
        _currentUser!.uid,
      ).then(
        (value) async {
          final dir = await getApplicationDocumentsDirectory();
          setState(
            () {
              _currentImage = File('${dir.path}/userProfile');
              showSpiner = false;
            },
          );
        },
      );
    }
  }

  Future<void> _askForSource() async {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(10),
            ),
            height: _currentImage == null ? 120 : 180,
            width: double.infinity,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    _pickImage(ImageSource.gallery);
                  },
                  child: ListTile(
                    title: Text(
                      'Gallery',
                    ),
                    leading: Icon(
                      Icons.photo,
                      color: Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _pickImage(ImageSource.camera),
                  child: ListTile(
                    title: Text(
                      'Camera',
                    ),
                    leading: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                  ),
                ),
                if (_currentImage != null)
                  GestureDetector(
                    onTap: () => _pickImage(null),
                    child: ListTile(
                      title: Text(
                        'Remove Profile Picture',
                      ),
                      leading: Icon(
                        Icons.cancel,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

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
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.green,
                    ),
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: _currentImage != null
                              ? FileImage(_currentImage!) as ImageProvider
                              : AssetImage(
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
                        ..onTap = () => _askForSource(),
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
                              null,
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
        prefs.setBool('profileSet', true);
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/wrapper',
          (route) => false,
        );
      },
    ).catchError(
      (eroor) {
        print('Hello i want to inform you that an error has occured $eroor');
      },
    );
  }
}
