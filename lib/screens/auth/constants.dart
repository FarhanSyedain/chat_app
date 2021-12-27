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
        color: Theme.of(c).colorScheme.secondary,
        // color: Colors.blue,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(15),
    );
