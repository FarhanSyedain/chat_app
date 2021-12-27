import 'dart:async';

import 'package:chat_app/models/customUserModel.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/secrets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';

class AuthService with ChangeNotifier {
  StreamController<AuthState> streamController = StreamController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthService() {
    _auth.authStateChanges().listen(
      (user) {
        streamController.add(AuthState(user));
      },
    );
  }

  Stream<User?> get authStateChanges => _auth.userChanges();
  Stream<AuthState> get authChanges => _authChanges();

  Stream<AuthState> _authChanges() {
    final stream = streamController.stream;
    return stream;
  }

  signOut() async {
    _auth.signOut();
    SharedPreferences.getInstance().then((value) => value.clear());
  }

  Future<String> registerUser(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
    return '';
  }

  Future<FirebaseAuthException?> loginUser(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      return e;
    }
    return null;
  }

  Future<bool> signInWithGoogle() async {
    try {
      await GoogleSignIn().signOut();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      return false;
    }
    return true;
  }

  Future<FirebaseAuthException?> signInWithTwitter() async {
    try {
      final TwitterLogin twitterLogin = new TwitterLogin(
        consumerKey: twitterConsumerKey,
        consumerSecret: twitterSecretKey,
      );
      final TwitterLoginResult loginResult = await twitterLogin.authorize();
      final TwitterSession twitterSession = loginResult.session;
      final twitterAuthCredential = TwitterAuthProvider.credential(
        accessToken: twitterSession.token,
        secret: twitterSession.secret,
      );

      await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
    } on FirebaseAuthException catch (e) {
      return e;
    }
    return null;
  }

  Future<FirebaseAuthException?> sendResetPasswordEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      return e;
    } catch (e) {}
    return null;
  }
}
