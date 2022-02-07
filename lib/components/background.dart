import 'package:flutter/material.dart';

class BackgroundWrapper extends StatelessWidget {
  final Widget child;

  BackgroundWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      width: double.infinity,
      height: double.infinity,
    );
  }
}
