import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

void showAwsomeDilog(
  DialogType type,
  String title,
  String desc,
  BuildContext context,
) {
  AwesomeDialog(
    context: context,
    dialogType: type,
    autoHide: const Duration(seconds: 5),
    body: Container(
      child: Column(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 20),
          Text(desc),
          const SizedBox(height: 30),
        ],
      ),
    ),
  ).show();
}
