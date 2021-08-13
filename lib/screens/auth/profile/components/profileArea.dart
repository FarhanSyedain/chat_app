import '/services/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class ProfileArea extends StatefulWidget {
  final XFile? pickedImage;
  final File? currentImage;
  final Function(bool)? changeSpinerval;
  ProfileArea({this.pickedImage, this.currentImage, this.changeSpinerval});
  @override
  _ProfileAreaState createState() => _ProfileAreaState();
}

class _ProfileAreaState extends State<ProfileArea> {
  XFile? _pickedImage;
  File? _currentImage;

  @override
  initState() {
    XFile? _pickedImage = widget.pickedImage;
    File? _currentImage = widget.currentImage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        SizedBox(height: 20),
        Center(
          child: Text.rich(
            TextSpan(
              text: 'Change Profile Picture.',
              style: Theme.of(context).textTheme.subtitle2,
              recognizer: TapGestureRecognizer()..onTap = () => _askForSource(),
            ),
          ),
        )
      ],
    );
  }

  Future<void> _pickImage(ImageSource? source) async {
    Navigator.of(context).pop();

    final _imagePicker = ImagePicker();
    final _currentUser = FirebaseAuth.instance.currentUser;
    if (source == null) {
      //remove profile picture
      ProfileService.removeProfilePicture(_currentUser!.uid).then((value) {
        setState(() {
          _currentImage = null;
        });
        widget.changeSpinerval!(false);
      });
    } else {
      _pickedImage = await _imagePicker.pickImage(source: source);

      if (_pickedImage == null) {
        // setState(() {
        //   showSpiner = false;
        // });
        widget.changeSpinerval!(false);
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
              // showSpiner = false
            },
          );
            widget.changeSpinerval!(false);
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
}
