
import 'package:flutter/material.dart';

class CustomFancyTextButton extends StatelessWidget {
  final String text;
  final Color? color;
  const CustomFancyTextButton(this.text,{this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText1?.copyWith(color: color),
      ),
    );
  }
}
