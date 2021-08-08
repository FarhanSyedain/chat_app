import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:path/path.dart' as path;

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
    await ref.putFile(profilePicture);
    final dir = await pathProvider.getApplicationDocumentsDirectory();
    final storagePath = '$dir/userProfile';
    await profilePicture.copy(storagePath);
    //Copied the image to the deviece 
    
  }
}
