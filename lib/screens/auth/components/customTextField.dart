import 'dart:js';

import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String fieldName;
  final String helperText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String? errorMessage;
  final bool disabled;
  final bool isPassword;

  CustomTextField(
    this.fieldName,
    this.helperText,
    this.validator, {
    this.controller,
    this.errorMessage,
    this.disabled = false,
    this.isPassword = false,
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
        SizedBox(height: 5),
        TextFormField(
          controller: controller == null ? null : controller,
          validator: validator,
          obscureText: isPassword,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(fontSize: 15, height: 1.5),
          decoration: InputDecoration(
            enabled: !disabled,
            disabledBorder: focusedBorder(context),
            errorText: errorMessage == null ? null : errorMessage,
            focusedErrorBorder: focusedBorder(context),
            errorBorder: unFocusedBorder(context),
            focusedBorder: focusedBorder(context),
            enabledBorder: unFocusedBorder(context),
            hintText: helperText,
            hintStyle: Theme.of(context).textTheme.bodyText2,
          ),
        ),
      ],
    );
  }
}

OutlineInputBorder unFocusedBorder(c) => OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(c).cardColor.withAlpha(200),
        width: 3,
      ),
      borderRadius: BorderRadius.circular(15),
    );

OutlineInputBorder focusedBorder(c) => OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.green,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(15),
    );
