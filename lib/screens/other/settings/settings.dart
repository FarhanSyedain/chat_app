import 'package:flutter/material.dart';

import '../../auth/components/customAppbar.dart';
import './components/body.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: buildAppBar(
        context,
        title: 'Profile',
        showBackButton: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Body(),
        color: Colors.black,
      ),
    );
  }
}
