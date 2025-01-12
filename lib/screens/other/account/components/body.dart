import 'package:chat_app/screens/other/account/components/customSwitchTile.dart';
import 'package:chat_app/screens/other/account/components/listGroupTitle.dart';
import 'package:chat_app/screens/other/settings/components/listTite.dart';
import 'package:chat_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
  final Function changeLoadingValue;
  const Body(this.changeLoadingValue);
}

class _BodyState extends State<Body> {
  bool switchVal = true;
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        ListGroupTitle(
          'Privicy',
          paddingtop: 0,
        ),
        const SizedBox(height: 10),
        CustomSwitchTile('Read recipts'),
        const SizedBox(height: 5),
        CustomSwitchTile('Typing Indicators'),
        ListGroupTitle('Account and sessions'),
        const SizedBox(height: 10),
        CustomListTile(
          'Sign  out',
          Icons.logout,
          showTrailingArrow: false,
          iconColor: Colors.red,
          titleColor: Colors.red,
          onTapHandler: () => signOut(widget.changeLoadingValue),
        ),
        const SizedBox(height: 5),
        CustomListTile(
          'Delete account',
          Icons.delete,
          showTrailingArrow: false,
          iconColor: Colors.red,
          titleColor: Colors.red,
          onTapHandler: () {
            print('Delete account');
          },
        ),
      ],
    );
  }

  Future<void> signOut(Function changeLoadingValue) async {
    changeLoadingValue(true);
    await context.read<AuthService>().signOut(context: context);
    changeLoadingValue(false);
  }
}
