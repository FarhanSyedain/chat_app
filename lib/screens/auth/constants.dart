import 'package:flutter/material.dart';

OutlineInputBorder unFocusedBorder(c, {isError = false}) => OutlineInputBorder(
      borderSide: BorderSide(
        color: isError ? Colors.red : Theme.of(c).cardColor.withAlpha(200),
        width: 3,
      ),
      borderRadius: BorderRadius.circular(15),
    );

OutlineInputBorder focusedBorder(c) => OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.green,
        width: 3,
      ),
      borderRadius: BorderRadius.circular(15),
    );
