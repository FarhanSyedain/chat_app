import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
    final prefs = await SharedPreferences.getInstance();
    try {
      prefs.setBool('DPUpdateFinished', false);
      final ref =
          FirebaseStorage.instance.ref().child('userProfiles').child(userUid);
      await ref.putFile(profilePicture);
      final dir = await pathProvider.getApplicationDocumentsDirectory();
      final storagePath = '${dir.path}/userProfile';
      await profilePicture.copy(storagePath);
      //Copied the image to the deviece
      prefs.setBool('DPUpdateFinished', true);
    } catch (e) {
      print('This is the eroor $e');
    }
  }

  static Future<void> updateProfilePicture({skipCheck = true}) async {
    final dir = await pathProvider.getApplicationDocumentsDirectory();
    if (!skipCheck) {
      //Check if profilePicture already exists
      if (File('${dir.path}/profilePicture').existsSync()) {
        return;
      }
    }
    final userUid = FirebaseAuth.instance.currentUser!.uid;
    final ref =
        FirebaseStorage.instance.ref().child('userProfiles').child(userUid);
    final downloadUrl = await ref.getDownloadURL();
    final response = await http.get(Uri(path: downloadUrl));
    final tempDir = await pathProvider.getTemporaryDirectory();
    final dir = await pathProvider.getApplicationDocumentsDirectory();
    //?Temp file for to avoid creating empty files
    File file = File('${tempDir.path}/profilePicture');
    file.writeAsBytesSync(response.bodyBytes);

    await file.copy('${dir.path}/profilePicture');
    await file.delete();
  }
}
