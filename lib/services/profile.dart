import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileService {
  static Future<void> removeProfilePicture(String userUid) async {
    final ref =
        FirebaseStorage.instance.ref().child('userProfiles').child(userUid);
    ref.delete().catchError(
      (e) {
        //Todo:Handle errors later
      },
    );
  }

  static Future<void> uploadProfilePicture(
      File profilePicture, String userUid) async {
    final ref =
        FirebaseStorage.instance.ref().child('userProfiles').child(userUid);

    ref.putFile(profilePicture).catchError(
      (e) {
        //Todo: Handle errors
      },
    );
  }
}
