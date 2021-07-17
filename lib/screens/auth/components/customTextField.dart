import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String fieldName;
  final String helperText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  CustomTextField(
    this.fieldName,
    this.helperText,
    this.validator, {
    this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            fieldName,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: controller == null ? null : controller,
          validator: validator,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(fontSize: 15, height: 1.5),
          decoration: InputDecoration(
            hintText: helperText,
            hintStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: kDarkSecondaryColor.withAlpha(200),
                ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.green,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).cardColor.withAlpha(200),
                width: 3,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ],
    );
  }
}
