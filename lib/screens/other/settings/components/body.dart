import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import './info.dart';
import './listTite.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      children: [
        const SizedBox(height: 15),
        InfoCard(),
        const SizedBox(height: 35),
        CustomListTile(
          'Account & Privicy',
          Icons.person,
          screenRoute: '/accountPage',
        ),
        const SizedBox(height: 5),
        CustomListTile(
          'Appearance',
          Icons.light_mode,
          screenRoute: '/themePage',
        ),
        const SizedBox(height: 5),
        CustomListTile(
          'Chat',
          Icons.chat_bubble,
          screenRoute: '/chatPage',
        ),

      ],
    );
  }
}
