import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyRadioListTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String leading;
  final Widget? title;
  final ValueChanged<T?> onChanged;

  const MyRadioListTile({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.leading,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final title = this.title;
    return InkWell(
      onTap: () => onChanged(value),
      child: Container(
        height: 150,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            _customRadioButton(context),
            // SizedBox(width: 12),
            if (title != null) title,
          ],
        ),
      ),
    );
  }

  Widget _customRadioButton(context) {
    final isSelected = value == groupValue;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color:
            isSelected ? Theme.of(context).colorScheme.secondary : Colors.white,
        // borderRadius: BorderRadius.circular(4),
        // border: Border.all(
        //   color: isSelected
        //       ? Theme.of(context).colorScheme.secondary
        //       : Colors.grey[300]!,
        //   width: 2,
        // ),
      ),
      child: Column(
        children: [
          Text(
            leading,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[600]!,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 5),
          SvgPicture.asset(
            value == 1
                ? 'assets/vectors/male.svg'
                : 'assets/vectors/female.svg',
            width: 100,
            height: 100,
          ),
        ],
      ),
    );
  }
}
