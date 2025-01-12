import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HaveOrHaveNotAnAccount extends StatelessWidget {
  final String? route;
  final String? title;
  final String? pageName;
  const HaveOrHaveNotAnAccount({this.route, this.title, this.pageName});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: pageName!,
              recognizer: TapGestureRecognizer()
                ..onTap =
                    () => Navigator.of(context).pushReplacementNamed(route!),
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
          text: title!,
        ),
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}
