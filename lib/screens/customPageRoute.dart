import 'package:flutter/material.dart';

class CustomRoute extends PageRouteBuilder {
  final Widget child;
  final AxisDirection direction;

  CustomRoute(this.child, this.direction)
      : super(
          transitionDuration: Duration(milliseconds: 300),
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: getOffset,
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  Offset get getOffset {
    switch (direction) {
      case AxisDirection.up:
        return Offset(0, 1);
      case AxisDirection.down:
        return Offset(0, -1);
      case AxisDirection.left:
        return Offset(-1, 0);
      case AxisDirection.right:
        return Offset(1, 0);
    }
  }
}
