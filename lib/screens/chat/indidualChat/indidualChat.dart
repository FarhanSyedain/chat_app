import 'package:chat_app/screens/auth/components/customAppbar.dart';
import 'package:flutter/material.dart';

class IndidualChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        title: 'Linus Torvalds',
        bgColor: Theme.of(context).cardColor,
        showBackButton: true,
        leading: Container(
          child: Image.asset('assets/dummy/profilePicture.jpg'),
        ),
      ),
    );
  }
}
