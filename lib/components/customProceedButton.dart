import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

class CustomProceedButton extends StatelessWidget {
  final String buttonText;

  CustomProceedButton(this.buttonText);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: kDarkCardColor,
      ),
      width: double.infinity,
      height: 60,
      alignment: Alignment.center,
      child: Text(
        buttonText,
        style: Theme.of(context).textTheme.bodyText1?.copyWith(
              fontSize: 20,
            ),
      ),
    );
  }
}
