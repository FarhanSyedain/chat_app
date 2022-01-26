import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final String? screenRoute;
  final bool showTrailingArrow;
  final Color? iconColor;
  final Color? titleColor;
  final void Function()? onTapHandler;
  CustomListTile(
    this.title,
    this.icon, {
    this.screenRoute,
    this.showTrailingArrow = true,
    this.iconColor,
    this.titleColor,
    this.onTapHandler,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapHandler ?? () {
        Navigator.pushNamed(context, '$screenRoute');
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF242526),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.symmetric(
          vertical: showTrailingArrow ? 15 : 25,
          horizontal: 20,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor ?? Theme.of(context).colorScheme.secondary,
            ),
            SizedBox(width: 20),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                color: titleColor ?? Colors.white,
              ),
            ),
            Spacer(),
            if (showTrailingArrow)
              IconButton(
                onPressed: () {},
                padding: EdgeInsets.all(0),
                icon: Icon(
                  Icons.arrow_forward_ios,
                ),
                color: Theme.of(context).colorScheme.secondary,
              )
          ],
        ),
      ),
    );
  }
}
