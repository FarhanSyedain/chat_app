// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// class TopBar extends StatelessWidget {
//   final String phoneNumber;
//   TopBar(this.phoneNumber);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(height: 40),
//         SvgPicture.asset(
//           'assets/vectors/phoneAuth.svg',
//           height: MediaQuery.of(context).size.height / 3,
//         ),
//         SizedBox(height: 20),
//         Text(
//           'Verify OTP',
//           style: TextStyle(
//             fontSize: 40,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.all(20),
//           child: Column(
//             children: [
//               Container(
//                 child: TextButton(
//                   onPressed: () =>
//                       Navigator.of(context).pushReplacementNamed('/phoneAuth'),
//                   child: Text.rich(
//                     TextSpan(
//                       text: phoneNumber,
//                       style: Theme.of(context).textTheme.bodyText2,
//                       children: [
//                         WidgetSpan(
//                           child: Padding(
//                             padding: EdgeInsets.only(left: 10),
//                             child: Icon(
//                               Icons.edit,
//                               size: 20,
//                               color:
//                                   Theme.of(context).textTheme.bodyText1?.color,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }
