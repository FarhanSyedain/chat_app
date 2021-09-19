import 'package:chat_app/screens/auth/components/customAppbar.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';

class IndidualChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: buildAppBar(context,
          height: 65.0,
          showBackButton: false,
          titleWidget: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              backButton(context, () {}, 0.0),
              SizedBox(
                width: 5,
              ),
              Container(
                height: 35,
                width: 35,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(100)),
                clipBehavior: Clip.hardEdge,
                child: Image.asset('assets/dummy/profilePicture.jpg'),
              ),
              SizedBox(width: 8),
              Text(
                'Linus Torvalds',
                style: Theme.of(context).textTheme.headline2,
              )
            ],
          ),
          bgColor: Theme.of(context).backgroundColor,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.video_call),
              padding: EdgeInsets.zero,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.call,
              ),
              padding: EdgeInsets.zero,
            ),
          ]),
    );
  }
}
