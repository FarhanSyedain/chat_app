import 'package:flutter/material.dart';

import './info.dart';
import './listTite.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 15),
      children: [
        SizedBox(height: 15),
        InfoCard(),
        SizedBox(height: 35),
        CustomListTile(
          'Account & Privicy',
          Icons.person,
          screenRoute: '/accountPage',
        ),
        SizedBox(height: 5),
        CustomListTile(
          'Appearance',
          Icons.light_mode,
          screenRoute: '/themePage',
        ),
        SizedBox(height: 5),
        CustomListTile(
          'Chat',
          Icons.chat_bubble,
          screenRoute: '/chatPage',
        ),
      ],
    );
  }
}
