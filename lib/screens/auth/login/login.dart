import 'package:flutter/material.dart';

import '../components/customAppbar.dart';
import 'components/loginScreenBody.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: buildAppBar(
        context,
        back: () {
          Navigator.of(context).pop();
        },
      ),
      body: LoginScreenBody(),
    );
  }
}
