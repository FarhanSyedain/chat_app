import 'package:awesome_dialog/awesome_dialog.dart';
import '/components/dilog/awsomeDilog.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> verifyPhoneNumber(phoneNumber, context, setVal, changeVal) async {
  await FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: phoneNumber,
    timeout: const Duration(seconds: 60),
    verificationCompleted: (PhoneAuthCredential credential) async {},
    verificationFailed: (FirebaseAuthException e) {
      showAwsomeDilog(
        DialogType.ERROR,
        'An error occured',
        e.message!,
        context,
      );
      changeVal(false);
    },
    codeSent: (String verificationId, int? resendToken) {
      setVal(verificationId);
      showAwsomeDilog(
        DialogType.SUCCES,
        'Otp Sent Successfully',
        'We have sent you an otp at phoneNumber',
        context,
      );
      changeVal(false);
    },
    codeAutoRetrievalTimeout: (String verificationId) {},
  );
}
