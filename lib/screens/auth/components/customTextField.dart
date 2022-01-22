import '../constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String helperText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String? errorMessage;
  final bool disabled;
  final bool isPassword;
  final bool focused;
  final TextInputAction textInputAction;
  final IconData? prefixIcon;
  final FocusNode? focusNode;

  CustomTextField(
    this.helperText,
    this.validator, {
    this.controller,
    this.errorMessage,
    this.disabled = false,
    this.isPassword = false,
    this.focused = false,
    this.textInputAction = TextInputAction.next,
    this.prefixIcon,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          textInputAction: textInputAction,
          autofocus: focused,
          focusNode: focusNode,
          controller: controller == null ? null : controller,
          validator: validator,
          obscureText: isPassword,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(fontSize: 15, height: 1.5),
          decoration: InputDecoration(
            fillColor: Colors.black,
            filled: true,
            prefixIcon: prefixIcon == null
                ? null
                : Icon(
                    prefixIcon,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            enabled: !disabled,
            disabledBorder: unFocusedBorder(context),
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
