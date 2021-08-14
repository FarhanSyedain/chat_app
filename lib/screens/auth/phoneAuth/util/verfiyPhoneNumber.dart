import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_app/components/dilog/awsomeDilog.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> verifyPhoneNumber(phoneNumber,context,setVal) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber:phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {},
      verificationFailed: (FirebaseAuthException e) => showAwsomeDilog(
        DialogType.ERROR,
        'An error occured',
        e.message!,
        context,
      ),
      codeSent: (String verificationId, int? resendToken) {
        setVal(verificationId);
        showAwsomeDilog(
          DialogType.SUCCES,
          'Otp Sent Successfully',
          'We have sent you an otp at phoneNumber',
          context,
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

