import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialMediaLoginButton extends StatelessWidget {
  final String svgPath;
  SocialMediaLoginButton(this.svgPath);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15),
      ),
      height: 70,
      alignment: Alignment.center,
      child: SvgPicture.asset(svgPath,height: 35,width: 35,),
    );
  }
}
