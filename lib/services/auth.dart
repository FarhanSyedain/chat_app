import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

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

  Future<FirebaseAuthException?> loginUser(String email, String password) async {
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
        consumerKey: '6hUY3Q6y59swYd78P6ejdIYaW',
        consumerSecret: 'f2u73Xo0Ip2RMAukBJl8P8adeLrYXED80p58vSQBB8Tr8GGUxs',
      );
      final TwitterLoginResult loginResult = await twitterLogin.authorize();
      final TwitterSession twitterSession = loginResult.session;
      final twitterAuthCredential = TwitterAuthProvider.credential(
        accessToken: twitterSession.token,
        secret: twitterSession.secret,
      );

      await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
    } on FirebaseAuthException catch (e) {
      print(e.code);

      return e;
    }
    return null;
  }
}
