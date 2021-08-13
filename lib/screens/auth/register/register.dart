import 'package:flutter/material.dart';

import '../components/customAppbar.dart';
import '../components/registerScreenBody.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: buildAppBar(context, title: 'Sign in'),
      body: RegisterScreenBody(),
    );
  }
}
