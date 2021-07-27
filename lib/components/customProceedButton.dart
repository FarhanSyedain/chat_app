import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

class CustomProceedButton extends StatelessWidget {
  final String buttonText;
  final bool disabled;
  CustomProceedButton(
    this.buttonText, {
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: disabled ? kDarkCardColor.withAlpha(180) : kDarkCardColor,
      ),
      width: double.infinity,
      height: 60,
      alignment: Alignment.center,
      child: Text(
        buttonText,
        style: disabled
            ? Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 20)
            : Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontSize: 20,
                ),
      ),
    );
  }
}
