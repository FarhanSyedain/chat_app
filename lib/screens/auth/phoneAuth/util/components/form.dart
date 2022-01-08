// import 'dart:async';

// import '/components/customProceedButton.dart';
// import '/constants.dart';
// import '/screens/auth/phoneAuth/util/verfiyPhoneNumber.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';

// class CustomForm extends StatefulWidget {
//   final String phoneNumber;
//   final String code;
//   final Function(bool)? changeVal;
//   CustomForm(this.phoneNumber, this.code, this.changeVal);

//   @override
//   _CustomFormState createState() => _CustomFormState();
// }

// class _CustomFormState extends State<CustomForm> {
//   bool pinGiven = false;
//   String? pin;
//   StreamController<ErrorAnimationType>? errorController;
//   bool showSpiner = false;
//   TextEditingController textEditingController = TextEditingController();
//   bool hasError = false;

//   String? _verificationCode;
//   @override
//   void initState() {
//     _verificationCode = widget.code;
//     errorController = StreamController<ErrorAnimationType>();
//     verifyPhoneNumber(widget.phoneNumber, context, (v) {
//       setState(() {
//         _verificationCode = v;
//       });
//     },widget.changeVal);

//     super.initState();
//   }

//   @override
//   void dispose() {
//     errorController?.close();
//     textEditingController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Form(
//           // key: formKey,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
//             child: PinCodeTextField(
//               appContext: context,
//               pastedTextStyle: TextStyle(
//                 color: Colors.green.shade600,
//                 fontWeight: FontWeight.bold,
//               ),
//               length: 6,
//               animationType: AnimationType.fade,
//               validator: (v) => otpIsValid(v, hasError),
//               pinTheme: PinTheme(
//                 shape: PinCodeFieldShape.underline,
//                 borderRadius: BorderRadius.circular(5),
//                 selectedFillColor: Colors.transparent,
//                 inactiveFillColor: Colors.transparent,
//                 fieldHeight: 50,
//                 fieldWidth: 40,
//                 selectedColor: Colors.green,
//                 inactiveColor: kDarkCardColor,
//                 borderWidth: 3,
//                 errorBorderColor: Colors.red,
//               ),
//               cursorColor: Colors.black,
//               animationDuration: Duration(milliseconds: 300),
//               enableActiveFill: true,
//               errorAnimationController: errorController,
//               controller: textEditingController,
//               keyboardType: TextInputType.number,
//               boxShadows: [
//                 BoxShadow(
//                   offset: Offset(0, 1),
//                   color: Colors.black12,
//                   blurRadius: 10,
//                 )
//               ],
//               onCompleted: (v) {
//                 setState(() {
//                   pinGiven = true;
//                 });
//               },
//               onChanged: (value) {
//                 setState(() {
//                   hasError = false;
//                   pinGiven = false;
//                   pin = value;
//                 });
//               },
//               beforeTextPaste: (text) {
//                 return true;
//               },
//             ),
//           ),
//         ),
//         SizedBox(height: 40),
//         GestureDetector(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.0),
//             child: CustomProceedButton(
//               'Verify',
//               disabled: !pinGiven,
//             ),
//           ),
//           onTap: pinGiven ? verifyUser : () {},
//         ),
//       ],
//     );
//   }

//   Future<void> verifyUser() async {
//     widget.changeVal!(true);
//     try {
//       await FirebaseAuth.instance
//           .signInWithCredential(
//             PhoneAuthProvider.credential(
//               verificationId: _verificationCode!,
//               smsCode: pin!,
//             ),
//           )
//           .then(
//             (value) => {},
//           );
//       Navigator.pushNamedAndRemoveUntil(
//         context,
//         '/wrapper',
//         (route) => false,
//       );
//     } catch (e) {
//       errorController!.add(
//         ErrorAnimationType.shake,
//       ); // Triggering error shake animation
//       setState(
//         () => hasError = true,
//       );
//       widget.changeVal!(false);
//     }
//   }
// }

// String? otpIsValid(v, hasError) {
//   if (hasError) {
//     return "Invalid OTP";
//   }
//   if (v!.length < 6) {
//     return 'OTP must be 6 didgits long';
//   }
// }
