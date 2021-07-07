import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

class CustomProceedButton extends StatelessWidget {
  const CustomProceedButton({Key? key}) : super(key: key);

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
        'Log in',
        style: Theme.of(context).textTheme.bodyText1?.copyWith(
              fontSize: 20,
            ),
      ),
    );
  }
}
