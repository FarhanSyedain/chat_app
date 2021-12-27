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
        borderRadius: BorderRadius.circular(15),
        color: disabled
            ? Theme.of(context).cardColor.withAlpha(180)
            : Theme.of(context).colorScheme.secondary,
      ),
      width: double.infinity,
      height: 60,
      alignment: Alignment.center,
      child: Text(
        buttonText,
        style: disabled
            ? Theme.of(context).textTheme.headline4?.copyWith(fontSize: 20)
            : Theme.of(context).textTheme.headline4,
      ),
    );
  }
}
