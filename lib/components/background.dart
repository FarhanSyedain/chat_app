import 'package:flutter/material.dart';

class BackgroundWrapper extends StatelessWidget {
  final Widget child;

  const BackgroundWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      color: Colors.black,
      width: double.infinity,
      height: double.infinity,
    );
  }
}
