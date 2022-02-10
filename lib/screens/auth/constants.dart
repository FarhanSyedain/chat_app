import 'package:flutter/material.dart';

OutlineInputBorder unFocusedBorder(c, {isError = false}) => OutlineInputBorder(
      borderSide: BorderSide(
        color: isError ? Colors.red : Color(0xFF161618),

        width: 3,
      ),
      borderRadius: BorderRadius.circular(15),
    );

OutlineInputBorder focusedBorder(c) => OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFF161618),
        width: 2,
      ),
      borderRadius: BorderRadius.circular(15),
    );
