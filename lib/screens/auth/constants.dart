import 'package:flutter/material.dart';

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
