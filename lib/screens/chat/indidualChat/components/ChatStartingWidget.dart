import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatStartingWidget extends StatelessWidget {
  const ChatStartingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30),
      child: Column(
        children: [
          SvgPicture.asset(
            'assets/vectors/male.svg',
            height: 100,
          ),
          SizedBox(height: 5),
          Text(
            'Farhan Syedain',
            style: TextStyle(
              fontFamily: 'MontserratB',
              fontSize: 25,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          Center(
            child: Text(
              'This is my chapri bio. Lemnmne try to make it longer',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
