import 'package:flutter/material.dart';

OutlineInputBorder unFocusedBorder(c, {isError = false}) => OutlineInputBorder(
      borderSide: BorderSide(
        // color: isError ? Colors.red : Colors.black,

        width: 3,
      ),
      borderRadius: BorderRadius.circular(15),
    );

OutlineInputBorder focusedBorder(c) => OutlineInputBorder(
      borderSide: BorderSide(
        // color: Theme.of(c).colorScheme.secondary,
        color: Colors.black,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(15),
    );
