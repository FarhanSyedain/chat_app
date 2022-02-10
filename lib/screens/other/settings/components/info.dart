import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Hero(
          tag: 'chat-appBar-image',
          child: Container(
            child: SvgPicture.asset(
              'assets/vectors/male.svg',
              height: 80,
              width: 80,
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Farhan',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'MontserratB',
                fontSize: 21,
              ),
            ),
            Text(
              FirebaseAuth.instance.currentUser!.email!,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Montserrat',
                fontSize: 15,
              ),
            ),
          ],
        )
      ],
    );
  }
}
