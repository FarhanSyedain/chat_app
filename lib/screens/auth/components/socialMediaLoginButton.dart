import 'package:flutter/material.dart';

class SocialMediaLoginButton extends StatelessWidget {
  final String text;
  SocialMediaLoginButton(this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15),
      ),
      height: 70,
      alignment: Alignment.center,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
