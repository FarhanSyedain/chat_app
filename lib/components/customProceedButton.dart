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
        color: disabled
            ? Theme.of(context).cardColor.withAlpha(180)
            : Theme.of(context).cardColor,
      ),
      width: double.infinity,
      height: 60,
      alignment: Alignment.center,
      child: Text(
        buttonText,
        style: disabled
            ? Theme.of(context).textTheme.headline5
            : Theme.of(context).textTheme.headline4,
      ),
    );
  }
}
