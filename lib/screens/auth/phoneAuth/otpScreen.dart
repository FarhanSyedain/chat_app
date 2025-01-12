// import '/screens/auth/phoneAuth/components/form.dart';
// import '/screens/auth/phoneAuth/components/topBar.dart';
// import 'package:flutter/material.dart';
// import 'package:loading_overlay/loading_overlay.dart';
// import 'dart:async';
// import 'util/verfiyPhoneNumber.dart';

// class OTPScreen extends StatefulWidget {
//   final String phoneNumber;
//   OTPScreen(this.phoneNumber);
//   @override
//   _OTPScreenState createState() => _OTPScreenState();
// }

// class _OTPScreenState extends State<OTPScreen> {
//   int timeLeft = 60;
//   int previousTimeLeft = 60;
//   Timer? resendTimer;
//   bool showSpiner = true;
//   String? _verificationCode = '';

//   final formKey = GlobalKey<FormState>();
//   @override
//   void initState() {
//     resendTimer = Timer.periodic(
//       Duration(seconds: 1),
//       (timer) {
//         setState(() {
//           timeLeft--;
//         });
//         if (timeLeft == 0) {
//           timer.cancel();
//         }
//       },
//     );
//     super.initState();
//   }

//   void changeVal(v) {
//     setState(() {
//       showSpiner = v;
//     });
//   }

//   @override
//   void dispose() {
//     resendTimer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: LoadingOverlay(
//         isLoading: showSpiner,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               TopBar(widget.phoneNumber),
//               SizedBox(height: 30),
//               CustomForm(widget.phoneNumber, _verificationCode!, changeVal),
//               Center(
//                 child: TextButton(
//                   onPressed: () {
//                     if (timeLeft > 0) {
//                       return;
//                     }
//                     changeVal(true);
//                     verifyPhoneNumber(
//                       widget.phoneNumber,
//                       context,
//                       (v) {
//                         setState(() {
//                           _verificationCode = v;
//                         });
//                       },
//                       changeVal,
//                     );
//                     setState(() {
//                       timeLeft = previousTimeLeft * 2;
//                       previousTimeLeft = timeLeft;
//                     });
//                     resendTimer = Timer.periodic(
//                       Duration(seconds: 1),
//                       (timer) {
//                         setState(
//                           () {
//                             timeLeft--;
//                           },
//                         );
//                       },
//                     );
//                   },
//                   child: Text(
//                     timeLeft == 0 ? 'Resend Code' : 'Resend Code ($timeLeft s)',
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
