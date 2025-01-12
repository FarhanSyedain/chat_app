import 'package:flutter/material.dart';

class CustomSwitchTile extends StatefulWidget {
  final String title;
  const CustomSwitchTile(this.title);
  @override
  State<CustomSwitchTile> createState() => _CustomSwitchTileState();
}

class _CustomSwitchTileState extends State<CustomSwitchTile> {
  bool switchVal = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF242526),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Row(
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              color: Colors.white,
              // fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Switch(
            value: switchVal,
            onChanged: (v) {
              setState(() {
                switchVal = v;
              });
            },
          ),
        ],
      ),
    );
  }
}
